package wom.controller.event.ui
{
   import flash.events.Event;
   
   public class CityPlannerEvent extends Event
   {
      
      public static const RESET_SELECTIONS:String = "resetSelections";
      
      public static const DISCARD_LAYOUT:String = "discardLayout";
      
      public static const SAVE_LAYOUT:String = "saveLayout";
      
      public static const SAVE_LAYOUT_SUCCESS:String = "saveLayoutSuccess";
      
      public function CityPlannerEvent(param1:String)
      {
         super(param1);
      }
      
      override public function clone() : Event
      {
         return new CityPlannerEvent(type);
      }
   }
}

