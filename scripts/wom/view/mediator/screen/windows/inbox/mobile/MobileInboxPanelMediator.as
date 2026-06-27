package wom.view.mediator.screen.windows.inbox.mobile
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import wom.controller.event.inbox.InboxEvent;
   import wom.controller.event.mobile.MobileExternalInterfaceEvent;
   import wom.controller.event.platform.PlatformUserEvent;
   import wom.model.game.friend.InboxInfo;
   import wom.model.game.friend.ProfileIdPair;
   import wom.view.screen.windows.inbox.mobile.MobileInboxPanel;
   
   public class MobileInboxPanelMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileInboxPanel;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var inboxInfo:InboxInfo;
      
      public function MobileInboxPanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         injector.injectInto(view);
         addContextListener("requestsUpdated",onRequestsUpdated,InboxEvent);
         addContextListener("requestsLayoutUpdated",onRequestsLayoutUpdated,InboxEvent);
         if(inboxInfo.inboxMode == 1)
         {
            inboxInfo.inboxMode = 2;
         }
      }
      
      private function onRequestsUpdated(param1:InboxEvent) : void
      {
         update();
      }
      
      private function update() : void
      {
         var _loc1_:Vector.<ProfileIdPair> = view.update(inboxInfo.requests);
         if(_loc1_ != null && _loc1_.length > 0)
         {
            dispatch(new PlatformUserEvent("getPlatformUserInfo",_loc1_));
         }
      }
      
      private function onRequestsLayoutUpdated(param1:InboxEvent) : void
      {
         view.drawLayout();
      }
      
      override public function onRemove() : void
      {
         dispatch(new MobileExternalInterfaceEvent("inboxCount"));
         super.onRemove();
      }
   }
}

