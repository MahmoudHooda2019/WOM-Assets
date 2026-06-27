package peak.signal
{
   public class Signal1 extends __SignalBase_peak_signal_Slot1
   {
      
      public function Signal1()
      {
         super();
      }
      
      public function dispatch(param1:*) : void
      {
         var _loc2_:* = null as __SlotList_peak_signal_Slot1;
         var _loc3_:* = null as __SlotNode_peak_signal_Slot1;
         var _loc4_:* = null as __SlotNode_peak_signal_Slot1;
         ++dispatchesInProgress;
         readLock = true;
         _loc2_ = handlers;
         _loc3_ = _loc2_.head;
         _loc4_ = _loc2_.tail;
         while(_loc3_ != _loc4_)
         {
            _loc3_ = _loc3_.next;
            _loc3_.handler.onSignal1(param1);
         }
         _loc2_ = handlersOnce;
         if(_loc2_.head != _loc2_.tail)
         {
            _loc2_ = handlersOnce;
            handlersOnce = new __SlotList_peak_signal_Slot1();
            _loc3_ = _loc2_.head;
            _loc4_ = _loc2_.tail;
            while(_loc3_ != _loc4_)
            {
               _loc3_ = _loc3_.next;
               _loc3_.handler.onSignal1(param1);
            }
         }
         if((dispatchesInProgress = dispatchesInProgress - 1) == 0)
         {
            readLock = false;
         }
      }
      
      public function addFunctionOnce(param1:Function) : void
      {
         var _loc2_:__SlotList_peak_signal_Slot1 = handlersOnce;
         var _loc3_:__SlotNode_peak_signal_Slot1 = new __SlotNode_peak_signal_Slot1(new FunctionSlot1(param1),null);
         _loc2_.tail.next = _loc3_;
         _loc2_.tail = _loc3_;
      }
      
      public function addFunction(param1:Function) : void
      {
         var _loc2_:__SlotList_peak_signal_Slot1 = handlers;
         var _loc3_:__SlotNode_peak_signal_Slot1 = new __SlotNode_peak_signal_Slot1(new FunctionSlot1(param1),null);
         _loc2_.tail.next = _loc3_;
         _loc2_.tail = _loc3_;
      }
   }
}

