package wom.view.mediator.screen.popups.attack
{
   import starling.events.Event;
   import wom.controller.event.combat.StartAttackEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.game.UserInfo;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.attack.MobileAttackWarnPopup;
   
   public class MobileAttackWarnPopupMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileAttackWarnPopup;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function MobileAttackWarnPopupMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.imageAsset,"change",onAssetChanged,Event);
         eventMap.mapStarlingListener(view.attackButton,"triggered",onAttackButtonClicked,Event);
         eventMap.mapStarlingListener(view.cancelButton,"triggered",onCancelButtonClicked,Event);
      }
      
      private function onAttackButtonClicked(param1:Event) : void
      {
         this.closeWindow();
         if(view.isTournamentAttack)
         {
            eventDispatcher.dispatchEvent(new StartAttackEvent("startAttack",null,false,true,false,true,false,false,true,view.isTournamentAttackByGold));
         }
         else
         {
            eventDispatcher.dispatchEvent(new StartAttackEvent("startAttack",view.profile,view.npc,true,false,true,view.isQuickAttack,userInfo.mapInCampaignMode));
         }
      }
      
      private function onAssetChanged(param1:Event) : void
      {
         view.drawLayout();
      }
      
      private function onCancelButtonClicked(param1:Event) : void
      {
         this.closeWindow();
      }
      
      override protected function closeWindow() : void
      {
         dispatch(new MobilePopUpWindowEvent("closeSecondaryPopUpWindow",view));
      }
   }
}

