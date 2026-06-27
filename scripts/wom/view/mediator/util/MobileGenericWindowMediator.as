package wom.view.mediator.util
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import starling.events.Event;
   import wom.controller.event.ui.MobileCloseGenericWindowEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.view.util.MobileGenericWindow;
   
   public class MobileGenericWindowMediator extends StarlingMediator
   {
      
      [Inject]
      public var mobileGenericWindow:MobileGenericWindow;
      
      [Inject]
      public var injector:IInjector;
      
      public function MobileGenericWindowMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         injector.injectInto(mobileGenericWindow);
         addContextListener("notifyClosingWindow",onCloseNotification,MobilePopUpWindowEvent);
         addContextListener("notifyClosingSecondaryWindow",onCloseNotification,MobilePopUpWindowEvent);
         eventMap.mapStarlingListener(mobileGenericWindow.closeButton,"triggered",onCloseButtonClicked,Event);
      }
      
      protected function onCloseNotification(param1:MobilePopUpWindowEvent) : void
      {
         if(param1.popUpWindowInfo.window == mobileGenericWindow)
         {
            closeWindow();
         }
      }
      
      protected function onCloseButtonClicked(param1:Event) : void
      {
         closeWindow();
      }
      
      protected function closeWindow() : void
      {
         dispatch(new MobileCloseGenericWindowEvent("mobileCloseGenericWindow",mobileGenericWindow));
      }
   }
}

