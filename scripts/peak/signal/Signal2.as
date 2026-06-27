package peak.signal
{
   public class Signal2 extends __SignalBase_peak_signal_Slot2
   {
      
      public function Signal2()
      {
         super();
      }
      
      public function dispatch(param1:*, param2:*) : void
      {
         var _loc3_:* = null as __SlotList_peak_signal_Slot2;
         var _loc4_:* = null as __SlotNode_peak_signal_Slot2;
         var _loc5_:* = null as __SlotNode_peak_signal_Slot2;
         ++dispatchesInProgress;
         readLock = true;
         _loc3_ = handlers;
         _loc4_ = _loc3_.head;
         _loc5_ = _loc3_.tail;
         while(_loc4_ != _loc5_)
         {
            _loc4_ = _loc4_.next;
            _loc4_.handler.onSignal2(param1,param2);
         }
         _loc3_ = handlersOnce;
         if(_loc3_.head != _loc3_.tail)
         {
            _loc3_ = handlersOnce;
            handlersOnce = new __SlotList_peak_signal_Slot2();
            _loc4_ = _loc3_.head;
            _loc5_ = _loc3_.tail;
            while(_loc4_ != _loc5_)
            {
               _loc4_ = _loc4_.next;
               _loc4_.handler.onSignal2(param1,param2);
            }
         }
         if((dispatchesInProgress = dispatchesInProgress - 1) == 0)
         {
            readLock = false;
         }
      }
      
      public function addFunctionOnce(param1:Function) : void
      {
         var _loc2_:__SlotList_peak_signal_Slot2 = handlersOnce;
         var _loc3_:__SlotNode_peak_signal_Slot2 = new __SlotNode_peak_signal_Slot2(new FunctionSlot2(param1),null);
         _loc2_.tail.next = _loc3_;
         _loc2_.tail = _loc3_;
      }
      
      public function addFunction(param1:Function) : void
      {
         var _loc2_:__SlotList_peak_signal_Slot2 = handlers;
         var _loc3_:__SlotNode_peak_signal_Slot2 = new __SlotNode_peak_signal_Slot2(new FunctionSlot2(param1),null);
         _loc2_.tail.next = _loc3_;
         _loc2_.tail = _loc3_;
      }
   }
}

