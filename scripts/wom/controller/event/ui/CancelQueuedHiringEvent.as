package wom.controller.event.ui
{
   import flash.events.Event;
   
   public class CancelQueuedHiringEvent extends Event
   {
      
      public static const CANCEL_UNIT:String = "cancelUnit";
      
      private var _instanceId:int;
      
      private var _unitId:int;
      
      private var _slotIndex:int;
      
      private var _amount:int;
      
      private var _validate:Boolean;
      
      public function CancelQueuedHiringEvent(param1:String, param2:int, param3:int, param4:int, param5:int, param6:Boolean)
      {
         super(param1);
         _instanceId = param2;
         _unitId = param3;
         _slotIndex = param4;
         _amount = param5;
         _validate = param6;
      }
      
      override public function clone() : Event
      {
         return new CancelQueuedHiringEvent(type,_instanceId,_unitId,_slotIndex,_amount,_validate);
      }
      
      public function get instanceId() : int
      {
         return _instanceId;
      }
      
      public function get unitId() : int
      {
         return _unitId;
      }
      
      public function get slotIndex() : int
      {
         return _slotIndex;
      }
      
      public function get amount() : int
      {
         return _amount;
      }
   }
}

