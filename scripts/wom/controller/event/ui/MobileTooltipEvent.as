package wom.controller.event.ui
{
   import flash.events.Event;
   import wom.view.ui.tooltip.MobileBaseTooltipView;
   
   public class MobileTooltipEvent extends Event
   {
      
      public static const SHOW_TOOLTIP_VIEW:String = "mobileTooltipEventShow";
      
      public static const CLOSE_TOOLTIP_VIEW:String = "mobileTooltipEventClose";
      
      public static const TOOLTIP_CLOSED_BY_HITTEST:String = "tooltipClosedByHittest";
      
      private var _tooltipView:MobileBaseTooltipView;
      
      private var _x:int;
      
      private var _y:int;
      
      public function MobileTooltipEvent(param1:String, param2:MobileBaseTooltipView = null, param3:int = 0, param4:int = 0)
      {
         super(param1);
         _tooltipView = param2;
         _x = param3;
         _y = param4;
      }
      
      override public function clone() : Event
      {
         return new MobileTooltipEvent(type,tooltipView,x,y);
      }
      
      public function get tooltipView() : MobileBaseTooltipView
      {
         return _tooltipView;
      }
      
      public function get x() : int
      {
         return _x;
      }
      
      public function get y() : int
      {
         return _y;
      }
   }
}

