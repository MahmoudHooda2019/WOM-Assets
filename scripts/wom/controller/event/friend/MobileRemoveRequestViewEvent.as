package wom.controller.event.friend
{
   import flash.events.Event;
   import wom.view.screen.windows.inbox.mobile.MobileBaseRequestView;
   
   public class MobileRemoveRequestViewEvent extends Event
   {
      
      public static const REMOVE:String = "removeRequestView";
      
      private var _view:MobileBaseRequestView;
      
      public function MobileRemoveRequestViewEvent(param1:String, param2:MobileBaseRequestView)
      {
         super(param1);
         _view = param2;
      }
      
      override public function clone() : Event
      {
         return new MobileRemoveRequestViewEvent(type,_view);
      }
      
      public function get view() : MobileBaseRequestView
      {
         return _view;
      }
   }
}

