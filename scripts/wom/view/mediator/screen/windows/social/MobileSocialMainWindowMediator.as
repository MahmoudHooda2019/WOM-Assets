package wom.view.mediator.screen.windows.social
{
   import peak.component.mobile.MPButton;
   import starling.events.Event;
   import wom.controller.event.WindowCreationEvent;
   import wom.controller.event.ui.SelectFriendsWindowEvent;
   import wom.model.game.window.WindowEnumeration;
   import wom.model.mobile.MobileConnectionServiceInfo;
   import wom.view.mediator.util.MobileButtonTabbedWindowMediator;
   import wom.view.screen.windows.social.MobileSocialMainWindow;
   
   public class MobileSocialMainWindowMediator extends MobileButtonTabbedWindowMediator
   {
      
      [Inject]
      public var view:MobileSocialMainWindow;
      
      [Inject]
      public var mobileConnectionServiceInfo:MobileConnectionServiceInfo;
      
      public function MobileSocialMainWindowMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         addContextListener("showSelectFriendsWindow",showSelectFriendsWindow,SelectFriendsWindowEvent);
         onTabButtonClicked(null);
      }
      
      override protected function onTabButtonClicked(param1:Event) : void
      {
         if(!view.isConnectToFBToSendGiftPanelVisible() && !mobileConnectionServiceInfo.isConnectedWithFacebook())
         {
            view.showFBConnectPanel();
            return;
         }
         if(view.isConnectToFBToSendGiftPanelVisible() && param1 && param1.target as MPButton == view.tabButtonInviteFriends)
         {
            view.addWindowEnumeration(new WindowEnumeration(205,{}));
            closeWindow();
            return;
         }
         if(view.isConnectToFBToSendGiftPanelVisible())
         {
            return;
         }
         if(!param1)
         {
            return;
         }
         var _loc2_:MPButton = param1.target as MPButton;
         if(_loc2_ == view.tabButtonInviteFriends)
         {
            dispatch(new WindowCreationEvent("createWindow",new WindowEnumeration(19,{})));
         }
         else if(_loc2_ == view.tabButtonSendGift)
         {
            view.updateGiftPanel(null);
            super.onTabButtonClicked(param1);
         }
      }
      
      private function showSelectFriendsWindow(param1:SelectFriendsWindowEvent) : void
      {
         closeWindow();
      }
   }
}

