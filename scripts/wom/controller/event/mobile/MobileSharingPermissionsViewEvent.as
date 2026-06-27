package wom.controller.event.mobile
{
   import flash.events.Event;
   import wom.view.ui.common.MobileSharingPermissionsView;
   
   public class MobileSharingPermissionsViewEvent extends Event
   {
      
      public static const SHOW:String = "mobileSharingPermissionsViewShow";
      
      public static const CLOSE:String = "mobileSharingPermissionsViewClose";
      
      private var _view:MobileSharingPermissionsView;
      
      public function MobileSharingPermissionsViewEvent(param1:String, param2:MobileSharingPermissionsView = null)
      {
         super(param1);
         _view = param2;
      }
      
      public function get view() : MobileSharingPermissionsView
      {
         return _view;
      }
      
      override public function clone() : Event
      {
         return new MobileConstructableOptionsEvent(type);
      }
   }
}

