package wom.view.mediator.screen.windows.catapult
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import starling.events.Event;
   import wom.controller.event.GameTickEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.ui.CatapultRechargeEvent;
   import wom.model.game.UserInfo;
   import wom.model.message.request.RechargeCatapultRequest;
   import wom.view.screen.windows.catapult.MobileCatapultElementRechargeView;
   
   public class MobileCatapultElementRechargeViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileCatapultElementRechargeView;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function MobileCatapultElementRechargeViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         injector.injectInto(view);
         view.updateDuration(userInfo.catapultActivationRemainingTimes);
         eventMap.mapStarlingListener(view.rechargeButton.button,"triggered",onRechargeClicked,Event);
         addContextListener("catapultRecharged",onCatapultRecharged,CatapultRechargeEvent);
         if(view.remainingDuration > 0)
         {
            addContextListener("tick",onTick,GameTickEvent);
         }
      }
      
      private function onRechargeClicked(param1:Event) : void
      {
         dispatch(new OutgoingMessageEvent("outgoingMessage",new RechargeCatapultRequest(view.catapultId,view.goldCost())));
      }
      
      private function onCatapultRecharged(param1:CatapultRechargeEvent) : void
      {
         if(param1.catapultId == view.catapultId)
         {
            view.updateDuration(userInfo.catapultActivationRemainingTimes);
         }
      }
      
      private function onTick(param1:GameTickEvent) : void
      {
         view.updateDuration(userInfo.catapultActivationRemainingTimes);
      }
   }
}

