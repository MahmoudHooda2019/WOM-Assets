package wom.controller.event.ui
{
   import flash.events.Event;
   
   public class VictoryMeterEvent extends Event
   {
      
      public static const STAR_GAINED:String = "starGained";
      
      public static const VISIBILITY_CHANGED:String = "visibilityChanged";
      
      public static const CITY_CENTER_DESTROYED:String = "cityCenterDestroyed";
      
      public function VictoryMeterEvent(param1:String)
      {
         super(param1);
      }
      
      override public function clone() : Event
      {
         return new VictoryMeterEvent(type);
      }
   }
}

