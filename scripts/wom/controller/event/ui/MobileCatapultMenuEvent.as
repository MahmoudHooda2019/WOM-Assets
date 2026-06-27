package wom.controller.event.ui
{
   import flash.events.Event;
   import starling.events.Event;
   import wom.view.ui.mainframe.combat.catapult.MobileCatapultMenuView;
   
   public class MobileCatapultMenuEvent extends flash.events.Event
   {
      
      public static const MOUSE_OVER:String = "mouseOver";
      
      public static const MOUSE_OUT:String = "mouseOut";
      
      public static const TOOLTIP_CHANGED:String = "tooltipChanged";
      
      public static const SELECTED:String = "selected";
      
      public static const UNSELECTED:String = "unselected";
      
      private var _view:MobileCatapultMenuView;
      
      private var _event:starling.events.Event;
      
      public function MobileCatapultMenuEvent(param1:String, param2:MobileCatapultMenuView, param3:starling.events.Event)
      {
         super(param1);
         _view = param2;
         _event = param3;
      }
      
      override public function clone() : flash.events.Event
      {
         return new MobileCatapultMenuEvent(type,_view,_event);
      }
      
      public function get view() : MobileCatapultMenuView
      {
         return _view;
      }
      
      public function get event() : starling.events.Event
      {
         return _event;
      }
   }
}

