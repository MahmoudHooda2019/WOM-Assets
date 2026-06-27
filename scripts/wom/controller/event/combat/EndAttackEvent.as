package wom.controller.event.combat
{
   import flash.events.Event;
   
   public class EndAttackEvent extends Event
   {
      
      public static const END_ATTACK:String = "endAttack";
      
      public function EndAttackEvent(param1:String)
      {
         super(param1);
      }
      
      override public function clone() : Event
      {
         return new EndAttackEvent(type);
      }
   }
}

