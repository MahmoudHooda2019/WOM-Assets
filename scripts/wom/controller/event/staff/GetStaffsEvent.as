package wom.controller.event.staff
{
   import flash.events.Event;
   
   public class GetStaffsEvent extends Event
   {
      
      public static const GET_STAFFS:String = "getStaffs";
      
      public function GetStaffsEvent(param1:String)
      {
         super(param1);
      }
      
      override public function clone() : Event
      {
         return new GetStaffsEvent(type);
      }
   }
}

