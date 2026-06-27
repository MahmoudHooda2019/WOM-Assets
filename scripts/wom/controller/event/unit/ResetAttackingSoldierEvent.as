package wom.controller.event.unit
{
   import flash.events.Event;
   
   public class ResetAttackingSoldierEvent extends Event
   {
      
      public static const RESET:String = "resetSoldiers";
      
      public function ResetAttackingSoldierEvent(param1:String)
      {
         super(param1);
      }
      
      override public function clone() : Event
      {
         return new ResetAttackingSoldierEvent(type);
      }
   }
}

