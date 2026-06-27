package wom.view.mediator.ui.mainframe.combat.catapult
{
   import starling.events.Event;
   import wom.controller.event.GameTickEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.mobile.MobileCatapultCombatRechargeStartedEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.game.UserInfo;
   import wom.model.message.request.RechargeCatapultRequest;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.ui.mainframe.combat.catapult.MobileCatapultCombatRechargePopUp;
   
   public class MobileCatapultCombatRechargePopUpMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileCatapultCombatRechargePopUp;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function MobileCatapultCombatRechargePopUpMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.actionButton,"triggered",onRechargeButtonClicked,Event);
         addContextListener("tick",onGameTick,GameTickEvent);
         onGameTick(null);
      }
      
      private function onRechargeButtonClicked(param1:Event) : void
      {
         dispatch(new OutgoingMessageEvent("outgoingMessage",new RechargeCatapultRequest(view.type,view.rechargeCost)));
         dispatch(new MobileCatapultCombatRechargeStartedEvent(view.type));
         closeWindow();
      }
      
      private function onGameTick(param1:GameTickEvent) : void
      {
         var _loc2_:int = int(userInfo.catapultActivationRemainingTimes[view.type].catapultTime);
         if(_loc2_ > 0)
         {
            view.updateDuration(_loc2_);
         }
         else
         {
            closeWindow();
         }
      }
      
      override protected function closeWindow() : void
      {
         dispatch(new MobilePopUpWindowEvent("closePopUpWindow",view));
      }
   }
}

