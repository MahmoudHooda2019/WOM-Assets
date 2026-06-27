package wom.view.mediator.screen.popups.npcattack.mobile
{
   import starling.events.Event;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.model.game.UserInfo;
   import wom.model.game.defense.NPCAttackStatus;
   import wom.model.game.gold.MonetizationType;
   import wom.model.game.window.WindowEnumeration;
   import wom.model.message.request.DelayNPCAttackRequest;
   import wom.model.message.request.SkipNPCAttackRequest;
   import wom.model.message.request.StartNPCAttackRequest;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.npcattack.mobile.MobileNPCAttackPopup;
   
   public class MobileNPCAttackPopupMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileNPCAttackPopup;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function MobileNPCAttackPopupMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.prepareDefensesButton,"triggered",onPrepareDefensesButtonClicked,Event);
         eventMap.mapStarlingListener(view.engageAttackButton,"triggered",onEngageAttackButtonClicked,Event);
         eventMap.mapStarlingListener(view.skipButton,"triggered",onSkipButtonClicked,Event);
      }
      
      override protected function closeWindow() : void
      {
      }
      
      private function onPrepareDefensesButtonClicked(param1:Event) : void
      {
         if(!userInfo.npcAttackDelayed)
         {
            userInfo.npcAttackStatus = NPCAttackStatus.INIT_DELAY;
            dispatch(new ModelUpdateEvent("npcAttackStatusUpdated"));
            dispatch(new OutgoingMessageEvent("outgoingMessage",new DelayNPCAttackRequest()));
         }
         super.closeWindow();
      }
      
      private function onEngageAttackButtonClicked(param1:Event) : void
      {
         userInfo.npcAttackStatus = NPCAttackStatus.INIT_ATTACK;
         dispatch(new ModelUpdateEvent("npcAttackStatusUpdated"));
         dispatch(new OutgoingMessageEvent("outgoingMessage",new StartNPCAttackRequest()));
         super.closeWindow();
      }
      
      private function onSkipButtonClicked(param1:Event) : void
      {
         if(userInfo.numberOfGolds >= 10)
         {
            userInfo.npcAttackStatus = NPCAttackStatus.SKIPPING;
            dispatch(new ModelUpdateEvent("npcAttackStatusUpdated"));
            dispatch(new OutgoingMessageEvent("outgoingMessage",new SkipNPCAttackRequest()));
            super.closeWindow();
         }
         else
         {
            view.addWindowEnumeration(new WindowEnumeration(0,{"womview":view}));
            view.addWindowEnumeration(new WindowEnumeration(16,{"monetizationType":MonetizationType.NOT_ENOUGH_GOLD}));
            super.closeWindow();
         }
      }
   }
}

