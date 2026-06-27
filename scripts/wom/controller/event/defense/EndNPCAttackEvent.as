package wom.controller.event.defense
{
   import flash.events.Event;
   
   public class EndNPCAttackEvent extends Event
   {
      
      public static const END_NPC_ATTACK:String = "endNPCAttack";
      
      public function EndNPCAttackEvent(param1:String)
      {
         super(param1);
      }
      
      override public function clone() : Event
      {
         return new EndNPCAttackEvent(type);
      }
   }
}

