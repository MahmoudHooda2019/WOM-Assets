package wom.controller.event.model
{
   import flash.events.Event;
   
   public class GenerateUnitTypeInfosEvent extends Event
   {
      
      public static const GENERATE_UNIT_TYPE_INFOS:String = "generateUnitTypeInfosEvent";
      
      public function GenerateUnitTypeInfosEvent(param1:String)
      {
         super(param1);
      }
      
      override public function clone() : Event
      {
         return new GenerateBuildingTypeInfosEvent(type);
      }
   }
}

