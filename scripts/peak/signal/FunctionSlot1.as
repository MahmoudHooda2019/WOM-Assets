package peak.signal
{
   public class FunctionSlot1 extends FunctionSlot implements Slot1
   {
      
      public function FunctionSlot1(param1:Function)
      {
         super(param1);
      }
      
      public function onSignal1(param1:*) : void
      {
         func(param1);
      }
   }
}

