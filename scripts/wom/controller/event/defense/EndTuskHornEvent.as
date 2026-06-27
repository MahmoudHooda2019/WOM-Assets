package wom.controller.event.defense
{
   import flash.events.Event;
   
   public class EndTuskHornEvent extends Event
   {
      
      public static const END_ATTACK:String = "endAttack";
      
      public function EndTuskHornEvent(param1:String)
      {
         super(param1);
      }
      
      override public function clone() : Event
      {
         return new EndTuskHornEvent(type);
      }
   }
}

