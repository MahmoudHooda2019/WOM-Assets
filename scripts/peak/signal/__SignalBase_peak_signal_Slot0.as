package peak.signal
{
   public class __SignalBase_peak_signal_Slot0
   {
      
      public var readLock:Boolean = false;
      
      public var handlersOnce:__SlotList_peak_signal_Slot0 = new __SlotList_peak_signal_Slot0();
      
      public var handlers:__SlotList_peak_signal_Slot0 = new __SlotList_peak_signal_Slot0();
      
      public var dispatchesInProgress:int = 0;
      
      public function __SignalBase_peak_signal_Slot0()
      {
      }
      
      public function removeFunction(param1:Function) : Boolean
      {
         var _loc2_:* = null as __SlotList_peak_signal_Slot0;
         var _loc3_:* = null as __SlotList_peak_signal_Slot0;
         var _loc4_:* = null as __SlotNode_peak_signal_Slot0;
         var _loc5_:* = null as __SlotNode_peak_signal_Slot0;
         var _loc6_:* = null as __SlotNode_peak_signal_Slot0;
         if(readLock)
         {
            §§push(§§findproperty(handlers));
            _loc2_ = handlers;
            _loc3_ = new __SlotList_peak_signal_Slot0();
            _loc4_ = _loc2_.head;
            _loc5_ = _loc2_.tail;
            _loc6_ = _loc3_.head;
            while(_loc4_ != _loc5_)
            {
               _loc4_ = _loc4_.next;
               _loc6_.next = new __SlotNode_peak_signal_Slot0(_loc4_.handler,_loc4_.next);
               _loc6_ = _loc6_.next;
            }
            _loc3_.tail = _loc6_;
            §§pop().handlers = _loc3_;
            readLock = false;
         }
         _loc2_ = handlers;
         var _loc8_:Function = param1;
         _loc4_ = _loc2_.head;
         var _loc9_:Boolean = false;
         while(_loc4_.next != null)
         {
            if(_loc4_.next.handler is FunctionSlot && (_loc4_.next.handler as FunctionSlot).func == _loc8_)
            {
               _loc9_ = true;
               if((_loc4_.next = _loc4_.next.next) == null)
               {
                  _loc2_.tail = _loc4_;
                  break;
               }
            }
            _loc4_ = _loc4_.next;
         }
         var _loc7_:Boolean = false;
         _loc2_ = handlersOnce;
         _loc8_ = param1;
         _loc4_ = _loc2_.head;
         var _loc10_:Boolean = false;
         while(_loc4_.next != null)
         {
            if(_loc4_.next.handler is FunctionSlot && (_loc4_.next.handler as FunctionSlot).func == _loc8_)
            {
               _loc10_ = true;
               if((_loc4_.next = _loc4_.next.next) == null)
               {
                  _loc2_.tail = _loc4_;
                  break;
               }
            }
            _loc4_ = _loc4_.next;
         }
         _loc9_ = false;
         return _loc7_ || _loc9_;
      }
      
      public function removeAll() : void
      {
         handlers = new __SlotList_peak_signal_Slot0();
         handlersOnce = new __SlotList_peak_signal_Slot0();
         readLock = false;
      }
      
      public function remove(param1:Slot0) : Boolean
      {
         var _loc2_:* = null as __SlotList_peak_signal_Slot0;
         var _loc3_:* = null as __SlotList_peak_signal_Slot0;
         var _loc4_:* = null as __SlotNode_peak_signal_Slot0;
         var _loc5_:* = null as __SlotNode_peak_signal_Slot0;
         var _loc6_:* = null as __SlotNode_peak_signal_Slot0;
         if(readLock)
         {
            §§push(§§findproperty(handlers));
            _loc2_ = handlers;
            _loc3_ = new __SlotList_peak_signal_Slot0();
            _loc4_ = _loc2_.head;
            _loc5_ = _loc2_.tail;
            _loc6_ = _loc3_.head;
            while(_loc4_ != _loc5_)
            {
               _loc4_ = _loc4_.next;
               _loc6_.next = new __SlotNode_peak_signal_Slot0(_loc4_.handler,_loc4_.next);
               _loc6_ = _loc6_.next;
            }
            _loc3_.tail = _loc6_;
            §§pop().handlers = _loc3_;
            readLock = false;
         }
         _loc2_ = handlers;
         _loc4_ = _loc2_.head;
         var _loc8_:Boolean = false;
         while(_loc4_.next != null)
         {
            if(_loc4_.next.handler == param1)
            {
               _loc8_ = true;
               if((_loc4_.next = _loc4_.next.next) == null)
               {
                  _loc2_.tail = _loc4_;
                  break;
               }
            }
            _loc4_ = _loc4_.next;
         }
         var _loc7_:Boolean = _loc8_;
         _loc2_ = handlersOnce;
         _loc4_ = _loc2_.head;
         var _loc9_:Boolean = false;
         while(_loc4_.next != null)
         {
            if(_loc4_.next.handler == param1)
            {
               _loc9_ = true;
               if((_loc4_.next = _loc4_.next.next) == null)
               {
                  _loc2_.tail = _loc4_;
                  break;
               }
            }
            _loc4_ = _loc4_.next;
         }
         _loc8_ = _loc9_;
         return _loc7_ || _loc8_;
      }
      
      public function hasHandler(param1:Slot0) : Boolean
      {
         var _loc2_:* = null as __SlotNode_peak_signal_Slot0;
         var _loc3_:Boolean = false;
         §§push(true);
         _loc2_ = handlers.head;
         _loc3_ = false;
         while(_loc2_.next != null)
         {
            if(_loc2_.next.handler == param1)
            {
               _loc3_ = true;
               break;
            }
            _loc2_ = _loc2_.next;
         }
         §§pop();
         _loc2_ = handlersOnce.head;
         _loc3_ = false;
         while(_loc2_.next != null)
         {
            if(_loc2_.next.handler == param1)
            {
               _loc3_ = true;
               break;
            }
            _loc2_ = _loc2_.next;
         }
         return false;
      }
      
      public function hasFunctionHandler(param1:Function) : Boolean
      {
         var _loc2_:* = null as Function;
         var _loc3_:* = null as __SlotNode_peak_signal_Slot0;
         var _loc4_:Boolean = false;
         §§push(true);
         _loc2_ = param1;
         _loc3_ = handlers.head;
         _loc4_ = false;
         while(_loc3_.next != null)
         {
            if(_loc3_.next.handler is FunctionSlot && (_loc3_.next.handler as FunctionSlot).func == _loc2_)
            {
               _loc4_ = true;
               break;
            }
            _loc3_ = _loc3_.next;
         }
         §§pop();
         _loc2_ = param1;
         _loc3_ = handlersOnce.head;
         _loc4_ = false;
         while(_loc3_.next != null)
         {
            if(_loc3_.next.handler is FunctionSlot && (_loc3_.next.handler as FunctionSlot).func == _loc2_)
            {
               _loc4_ = true;
               break;
            }
            _loc3_ = _loc3_.next;
         }
         return false;
      }
      
      public function hasAnyHandler() : Boolean
      {
         var _loc1_:* = null as __SlotList_peak_signal_Slot0;
         §§push(false);
         _loc1_ = handlers;
         if(_loc1_.head == _loc1_.tail)
         {
            §§pop();
            _loc1_ = handlersOnce;
            §§push(_loc1_.head == _loc1_.tail);
         }
         return !§§pop();
      }
      
      public function addOnce(param1:Slot0) : void
      {
         var _loc2_:__SlotList_peak_signal_Slot0 = handlersOnce;
         var _loc3_:__SlotNode_peak_signal_Slot0 = new __SlotNode_peak_signal_Slot0(param1,null);
         _loc2_.tail.next = _loc3_;
         _loc2_.tail = _loc3_;
      }
      
      public function add(param1:Slot0) : void
      {
         var _loc2_:__SlotList_peak_signal_Slot0 = handlers;
         var _loc3_:__SlotNode_peak_signal_Slot0 = new __SlotNode_peak_signal_Slot0(param1,null);
         _loc2_.tail.next = _loc3_;
         _loc2_.tail = _loc3_;
      }
   }
}

