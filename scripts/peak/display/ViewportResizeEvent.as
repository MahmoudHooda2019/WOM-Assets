package peak.display
{
   import flash.events.Event;
   
   public class ViewportResizeEvent extends Event
   {
      
      public static const RESIZE:String = "resize";
      
      public static const STAGE_DISPLAY_STATE_CHANGE:String = "stageDisplayStateChange";
      
      private var _viewport:Viewport;
      
      public function ViewportResizeEvent(param1:String, param2:Viewport)
      {
         super(param1);
         _viewport = param2;
      }
      
      override public function clone() : Event
      {
         return new ViewportResizeEvent(type,_viewport);
      }
      
      public function get viewport() : Viewport
      {
         return _viewport;
      }
   }
}

