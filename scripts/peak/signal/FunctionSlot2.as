package peak.signal
{
   public class FunctionSlot2 extends FunctionSlot implements Slot2
   {
      
      public function FunctionSlot2(param1:Function)
      {
         super(param1);
      }
      
      public function onSignal2(param1:*, param2:*) : void
      {
         func(param1,param2);
      }
   }
}

