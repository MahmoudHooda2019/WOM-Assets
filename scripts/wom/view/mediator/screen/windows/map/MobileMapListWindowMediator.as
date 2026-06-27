package wom.view.mediator.screen.windows.map
{
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import peak.i18n.PText;
   import starling.events.Event;
   import wom.controller.event.ActivateScreenEvent;
   import wom.controller.event.GameTickEvent;
   import wom.controller.event.combat.StartAttackEvent;
   import wom.controller.event.tutorial.TutorialReferencePositionEvent;
   import wom.controller.event.tutorial.TutorialTriggerEvent;
   import wom.controller.event.ui.MobileMapListSelectionToggleEvent;
   import wom.controller.event.ui.MobileUINotificationEvent;
   import wom.model.game.UserInfo;
   import wom.model.game.WomScreenType;
   import wom.model.game.experience.ExperienceUtil;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.windows.map.MobileMapListWindow;
   
   public class MobileMapListWindowMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileMapListWindow;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function MobileMapListWindowMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         userInfo.usesListForMap = true;
         eventMap.mapStarlingListener(view.returnButton,"triggered",onReturnButtonClicked,Event);
         eventMap.mapStarlingListener(view.smartAttackButton,"triggered",onSmartAttackButtonClicked,Event);
         eventMap.mapStarlingListener(view.tournamentAttackButton,"triggered",onTournamentAttackButtonClicked,Event);
         eventMap.mapStarlingListener(view.tournamentAttackWithGoldButton,"triggered",onTournamentAttackWithGoldButtonClicked,Event);
         eventMap.mapStarlingListener(view.campaignButton,"triggered",onCampaignButtonClicked,Event);
         eventMap.mapStarlingListener(view.showAllCheckBox,"change",onCheckboxToggle,Event);
         addContextListener("showAllMapMembers",onShowAllMapMembers,TutorialTriggerEvent);
         addContextListener("getMandatoryActionButtonPosition",onMandatoryActionButtonPositionRequested,TutorialReferencePositionEvent);
         addContextListener("tick",onTick);
         initActionButtons();
         view.updateDurationRelatedFields(userInfo.tournamentNextAttackRemainingDuration,userInfo.tournamentRemainingDuration);
      }
      
      private function onMandatoryActionButtonPositionRequested(param1:TutorialReferencePositionEvent) : void
      {
         dispatch(new TutorialReferencePositionEvent("positionReady",param1.objectToBeAligned,view.campaignButton.localToGlobal(new Point()),param1.additionalInfo,view.campaignButton));
      }
      
      private function onShowAllMapMembers(param1:TutorialTriggerEvent) : void
      {
         if(!view.showAllCheckBox.isSelected)
         {
            view.showAllCheckBox.isSelected = true;
            dispatch(new MobileMapListSelectionToggleEvent("MobileMapListSelectionToggle",true));
         }
      }
      
      private function initActionButtons() : void
      {
         if(!userInfo.mandatoryTutorialCompleted)
         {
            view.campaignButton.isEnabled = view.smartAttackButton.isEnabled = false;
         }
      }
      
      private function onCheckboxToggle(param1:Event) : void
      {
         dispatch(new MobileMapListSelectionToggleEvent("MobileMapListSelectionToggle",view.showAllCheckBox.isSelected));
      }
      
      private function onReturnButtonClicked(param1:Event) : void
      {
         dispatch(new ActivateScreenEvent("activate",WomScreenType.CITY));
      }
      
      private function onSmartAttackButtonClicked(param1:Event) : void
      {
         if(ExperienceUtil.calculateLevelOfExperience(userInfo.experiencePoints) < 5)
         {
            var _temp_2:* = §§findproperty(MobileUINotificationEvent);
            var _temp_1:* = "mobileUINotificationEventShow";
            var _loc2_:String = "ui.popups.apologies.cantquickattackbefore5";
            dispatch(new MobileUINotificationEvent(_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc2_)));
         }
         else
         {
            dispatch(new StartAttackEvent("startAttack",null,false,false,true,true,true));
         }
      }
      
      private function onTournamentAttackButtonClicked(param1:Event) : void
      {
         dispatch(new StartAttackEvent("startAttack",null,false,false,true,true,false,false,true));
      }
      
      private function onTournamentAttackWithGoldButtonClicked(param1:Event) : void
      {
         dispatch(new StartAttackEvent("startAttack",null,false,false,true,true,false,false,true,true));
      }
      
      private function onCampaignButtonClicked(param1:Event) : void
      {
         var _loc2_:Dictionary = new Dictionary();
         _loc2_["mapScreenCampaignMode"] = true;
         dispatch(new ActivateScreenEvent("activate",WomScreenType.MAP,_loc2_));
      }
      
      override protected function closeWindow() : void
      {
         super.closeWindow();
         dispatch(new ActivateScreenEvent("activate",WomScreenType.CITY));
         userInfo.usesListForMap = false;
      }
      
      private function onTick(param1:GameTickEvent) : void
      {
         view.updateDurationRelatedFields(userInfo.tournamentNextAttackRemainingDuration,userInfo.tournamentRemainingDuration);
      }
   }
}

