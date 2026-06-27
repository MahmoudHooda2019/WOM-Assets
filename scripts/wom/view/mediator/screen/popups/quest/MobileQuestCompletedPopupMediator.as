package wom.view.mediator.screen.popups.quest
{
   import flash.geom.Point;
   import peak.i18n.PText;
   import peak.resource.SoundPlayer;
   import starling.events.Event;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.mobile.MobileExternalInterfaceEvent;
   import wom.controller.event.tutorial.TutorialReferencePositionEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.game.UserInfo;
   import wom.model.game.viral.WallPostParams;
   import wom.model.message.request.ClaimQuestRequest;
   import wom.service.facebook.FacebookAPIManager;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.quest.MobileQuestCompletedPopup;
   
   public class MobileQuestCompletedPopupMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileQuestCompletedPopup;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var soundPlayer:SoundPlayer;
      
      [Inject]
      public var facebookAPIManager:FacebookAPIManager;
      
      public function MobileQuestCompletedPopupMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         if(!userInfo.mandatoryTutorialCompleted)
         {
            var _temp_1:* = view.boostAndShareButton;
            var _loc1_:String = "ui.popups.questcompleted.great";
            _temp_1.label = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         }
         eventMap.mapStarlingListener(view.boostAndShareButton,"triggered",onBoastAndShareButtonClicked,Event);
         soundPlayer.playSfxById("QuestCompleted");
         addContextListener("platformUsersUpdated",onPlatformUsersUpdated,ModelUpdateEvent);
         addContextListener("getMandatoryActionButtonPosition",onMandatoryActionButtonPositionRequested,TutorialReferencePositionEvent);
         platformUsersUpdated();
      }
      
      private function onMandatoryActionButtonPositionRequested(param1:TutorialReferencePositionEvent) : void
      {
         dispatch(new TutorialReferencePositionEvent("positionReady",param1.objectToBeAligned,view.boostAndShareButton.localToGlobal(new Point()),param1.additionalInfo,view.boostAndShareButton));
      }
      
      private function onBoastAndShareButtonClicked(param1:Event) : void
      {
         closeWindow();
         if(userInfo.mandatoryTutorialCompleted && view.questInfo.questId != 40)
         {
            dispatch(new MobileExternalInterfaceEvent("makeWallPost",new WallPostParams(6,view.questInfo.questId)));
         }
      }
      
      override protected function onCloseNotification(param1:MobilePopUpWindowEvent) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         if(view == param1.popUpWindowInfo.window)
         {
            _loc2_ = false;
            _loc3_ = 0;
            while(_loc3_ < userInfo.quests.length && !_loc2_)
            {
               if(userInfo.quests[_loc3_].questId == view.questInfo.questId)
               {
                  userInfo.quests.splice(_loc3_,1);
                  _loc2_ = true;
               }
               _loc3_++;
            }
            closeWindow();
         }
      }
      
      override protected function closeWindow() : void
      {
         claimQuest();
         super.closeWindow();
      }
      
      private function claimQuest() : void
      {
         dispatch(new OutgoingMessageEvent("outgoingMessage",new ClaimQuestRequest(view.questInfo.questId)));
      }
      
      private function onPlatformUsersUpdated(param1:ModelUpdateEvent) : void
      {
         platformUsersUpdated();
      }
      
      private function platformUsersUpdated() : void
      {
         view.updateSharePromptTextField(facebookAPIManager.getUserNameByProfile(userInfo.profile,false));
      }
   }
}

