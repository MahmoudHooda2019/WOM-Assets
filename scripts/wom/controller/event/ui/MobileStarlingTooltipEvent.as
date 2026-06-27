package wom.controller.event.ui
{
   import starling.events.Event;
   
   public class MobileStarlingTooltipEvent extends Event
   {
      
      public static const CLOSE_TOOLTIP_TRIGGERED:String = "closeTooltipTriggered";
      
      public function MobileStarlingTooltipEvent(param1:String)
      {
         super(param1);
      }
   }
}

