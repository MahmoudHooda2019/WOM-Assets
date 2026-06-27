package wom.controller.event.ui
{
   import flash.events.Event;
   import wom.model.dto.UnitTypeAmountDTO;
   
   public class MobileHiringQuarterHireEvent extends Event
   {
      
      public static const HIRE_UNIT:String = "hireUnit";
      
      private var _instanceId:int;
      
      private var _unitAmounts:Vector.<UnitTypeAmountDTO>;
      
      public function MobileHiringQuarterHireEvent(param1:String, param2:int, param3:Vector.<UnitTypeAmountDTO>)
      {
         super(param1);
         _instanceId = param2;
         _unitAmounts = param3;
      }
      
      override public function clone() : Event
      {
         return new MobileHiringQuarterHireEvent(type,_instanceId,_unitAmounts);
      }
      
      public function get instanceId() : int
      {
         return _instanceId;
      }
      
      public function get unitAmounts() : Vector.<UnitTypeAmountDTO>
      {
         return _unitAmounts;
      }
   }
}

