package wom.controller.event.ui
{
   import starling.events.Event;
   
   public class MobileVictoryMeterEvent extends Event
   {
      
      public static const STAR_GAINED:String = "starGained";
      
      public static const VISIBILITY_CHANGED:String = "visibilityChanged";
      
      public function MobileVictoryMeterEvent(param1:String)
      {
         super(param1);
      }
   }
}

