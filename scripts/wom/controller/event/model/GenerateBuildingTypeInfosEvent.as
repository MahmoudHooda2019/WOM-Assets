package wom.controller.event.model
{
   import flash.events.Event;
   
   public class GenerateBuildingTypeInfosEvent extends Event
   {
      
      public static const GENERATE_BUILDING_TYPE_INFOS:String = "generateBuildingTypeInfosEvent";
      
      public function GenerateBuildingTypeInfosEvent(param1:String)
      {
         super(param1);
      }
      
      override public function clone() : Event
      {
         return new GenerateBuildingTypeInfosEvent(type);
      }
   }
}

