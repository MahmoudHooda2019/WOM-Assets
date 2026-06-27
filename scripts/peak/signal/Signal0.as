package peak.signal
{
   public class Signal0 extends __SignalBase_peak_signal_Slot0
   {
      
      public function Signal0()
      {
         super();
      }
      
      public function dispatch() : void
      {
         var _loc1_:* = null as __SlotList_peak_signal_Slot0;
         var _loc2_:* = null as __SlotNode_peak_signal_Slot0;
         var _loc3_:* = null as __SlotNode_peak_signal_Slot0;
         ++dispatchesInProgress;
         readLock = true;
         _loc1_ = handlers;
         _loc2_ = _loc1_.head;
         _loc3_ = _loc1_.tail;
         while(_loc2_ != _loc3_)
         {
            _loc2_ = _loc2_.next;
            _loc2_.handler.onSignal0();
         }
         _loc1_ = handlersOnce;
         if(_loc1_.head != _loc1_.tail)
         {
            _loc1_ = handlersOnce;
            handlersOnce = new __SlotList_peak_signal_Slot0();
            _loc2_ = _loc1_.head;
            _loc3_ = _loc1_.tail;
            while(_loc2_ != _loc3_)
            {
               _loc2_ = _loc2_.next;
               _loc2_.handler.onSignal0();
            }
         }
         if((dispatchesInProgress = dispatchesInProgress - 1) == 0)
         {
            readLock = false;
         }
      }
      
      public function addFunctionOnce(param1:Function) : void
      {
         var _loc2_:__SlotList_peak_signal_Slot0 = handlersOnce;
         var _loc3_:__SlotNode_peak_signal_Slot0 = new __SlotNode_peak_signal_Slot0(new FunctionSlot0(param1),null);
         _loc2_.tail.next = _loc3_;
         _loc2_.tail = _loc3_;
      }
      
      public function addFunction(param1:Function) : void
      {
         var _loc2_:__SlotList_peak_signal_Slot0 = handlers;
         var _loc3_:__SlotNode_peak_signal_Slot0 = new __SlotNode_peak_signal_Slot0(new FunctionSlot0(param1),null);
         _loc2_.tail.next = _loc3_;
         _loc2_.tail = _loc3_;
      }
   }
}

