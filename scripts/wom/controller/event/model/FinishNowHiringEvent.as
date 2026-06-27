package wom.controller.event.model
{
   import flash.events.Event;
   
   public class FinishNowHiringEvent extends Event
   {
      
      public static const CALCULATE_FINISH_NOW_PRICE:String = "calculateFinishNowPrice";
      
      public static const FINISH_ALL_HIRES:String = "finishAllHires";
      
      private var _instanceId:int;
      
      private var _centralHiring:Boolean;
      
      public function FinishNowHiringEvent(param1:String, param2:int, param3:Boolean)
      {
         super(param1);
         _instanceId = param2;
         _centralHiring = param3;
      }
      
      override public function clone() : Event
      {
         return new FinishNowHiringEvent(type,_instanceId,_centralHiring);
      }
      
      public function get instanceId() : int
      {
         return _instanceId;
      }
      
      public function get centralHiring() : Boolean
      {
         return _centralHiring;
      }
   }
}

