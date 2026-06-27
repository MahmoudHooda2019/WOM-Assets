package wom.controller.event.ui
{
   import flash.events.Event;
   
   public class CancelActiveHiringEvent extends Event
   {
      
      public static const CANCEL_ACTIVE_UNIT:String = "cancelActiveUnit";
      
      private var _instanceId:int;
      
      private var _unitId:int;
      
      private var _validate:Boolean;
      
      public function CancelActiveHiringEvent(param1:String, param2:int, param3:int, param4:Boolean)
      {
         super(param1);
         _instanceId = param2;
         _unitId = param3;
         _validate = param4;
      }
      
      override public function clone() : Event
      {
         return new CancelActiveHiringEvent(type,_instanceId,_unitId,_validate);
      }
      
      public function get instanceId() : int
      {
         return _instanceId;
      }
      
      public function get unitId() : int
      {
         return _unitId;
      }
      
      public function get validate() : Boolean
      {
         return _validate;
      }
   }
}

