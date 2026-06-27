package wom.controller.event.mobile
{
   import flash.events.Event;
   import wom.view.ui.mainframe.city.mobile.MobileConstructableOptionsView;
   
   public class MobileConstructableOptionsEvent extends Event
   {
      
      public static const SHOW:String = "mobileConstructableOptionsShow";
      
      public static const CLOSE:String = "mobileConstructableOptionsClose";
      
      private var _view:MobileConstructableOptionsView;
      
      public function MobileConstructableOptionsEvent(param1:String, param2:MobileConstructableOptionsView = null)
      {
         super(param1);
         _view = param2;
      }
      
      override public function clone() : Event
      {
         return new MobileConstructableOptionsEvent(type,view);
      }
      
      public function get view() : MobileConstructableOptionsView
      {
         return _view;
      }
   }
}

