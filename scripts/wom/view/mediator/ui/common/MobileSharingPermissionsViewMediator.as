package wom.view.mediator.ui.common
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import wom.controller.event.mobile.MobileFacebookConnectionEvent;
   import wom.controller.event.mobile.MobileSharingPermissionsViewEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.view.ui.common.MobileSharingPermissionsView;
   
   public class MobileSharingPermissionsViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileSharingPermissionsView;
      
      [Inject]
      public var injector:IInjector;
      
      public function MobileSharingPermissionsViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         injector.injectInto(view);
         eventMap.mapStarlingListener(view,"touch",onTouchView,TouchEvent);
         addContextListener("showPopUpWindow",onShowPopUp,MobilePopUpWindowEvent);
         addContextListener("showSecondaryPopUpWindow",onShowPopUp,MobilePopUpWindowEvent);
         addContextListener("showDelayedPopUps",onShowPopUp,MobilePopUpWindowEvent);
      }
      
      private function onShowPopUp(param1:MobilePopUpWindowEvent) : void
      {
         dispatch(new MobileSharingPermissionsViewEvent("mobileSharingPermissionsViewClose"));
      }
      
      private function onTouchView(param1:TouchEvent) : void
      {
         var _loc2_:Touch = param1.getTouch(view,"ended");
         if(_loc2_)
         {
            dispatch(new MobileFacebookConnectionEvent("reauthWithPublishPermissions"));
            dispatch(new MobileSharingPermissionsViewEvent("mobileSharingPermissionsViewClose"));
         }
      }
   }
}

