package wom.controller.event.staff
{
   import flash.events.Event;
   
   public class HireStaffEvent extends Event
   {
      
      public static const HIRE:String = "hireStaff";
      
      private var _staffId:int;
      
      public function HireStaffEvent(param1:String, param2:int)
      {
         super(param1);
         _staffId = param2;
      }
      
      public function get staffId() : int
      {
         return _staffId;
      }
      
      override public function clone() : Event
      {
         return new HireStaffEvent(type,_staffId);
      }
   }
}

