package wom.view.mediator.screen.popups.npcattack.mobile
{
   import starling.events.Event;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.mobile.MobileExternalInterfaceEvent;
   import wom.model.game.AttackInfo;
   import wom.model.game.defense.NPCAttackChoiceType;
   import wom.model.game.viral.WallPostParams;
   import wom.model.message.request.UpdateNPCAttackChoiceRequest;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.npcattack.mobile.MobileNPCAttackRepelledPopup;
   
   public class MobileNPCAttackRepelledPopupMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileNPCAttackRepelledPopup;
      
      [Inject]
      public var attackInfo:AttackInfo;
      
      public function MobileNPCAttackRepelledPopupMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.actionButton,"triggered",onIWillBeWaitingButtonClicked,Event);
      }
      
      private function onIWillBeWaitingButtonClicked(param1:Event) : void
      {
         sendResponse(NPCAttackChoiceType.BRING_MORE);
      }
      
      private function sendResponse(param1:NPCAttackChoiceType) : void
      {
         closeWindow();
         dispatch(new OutgoingMessageEvent("outgoingMessage",new UpdateNPCAttackChoiceRequest(param1)));
         if(attackInfo.attacker.isNpc)
         {
            dispatch(new MobileExternalInterfaceEvent("makeWallPost",new WallPostParams(14,attackInfo.attacker.npcId.substr(4))));
         }
      }
   }
}

