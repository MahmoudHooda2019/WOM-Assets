package wom.controller.event
{
   import flash.events.Event;
   
   public class MaintenanceEvent extends Event
   {
      
      public static const MAINTENANCE:String = "maintenance";
      
      private var _maintenanceTime:Number;
      
      private var _maintenanceMode:String;
      
      public function MaintenanceEvent(param1:String, param2:Number, param3:String)
      {
         super(param1);
         _maintenanceTime = param2;
         _maintenanceMode = param3;
      }
      
      override public function clone() : Event
      {
         return new MaintenanceEvent(type,_maintenanceTime,_maintenanceMode);
      }
      
      public function get maintenanceTime() : Number
      {
         return _maintenanceTime;
      }
      
      public function get maintenanceMode() : String
      {
         return _maintenanceMode;
      }
   }
}

