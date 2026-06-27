package wom.controller.event.ui
{
   import flash.events.Event;
   
   public class CatapultRechargeEvent extends Event
   {
      
      public static const CATAPULT_RECHARGED:String = "catapultRecharged";
      
      private var _catapultId:int;
      
      public function CatapultRechargeEvent(param1:String, param2:int)
      {
         super(param1);
         _catapultId = param2;
      }
      
      override public function clone() : Event
      {
         return new CatapultRechargeEvent(type,_catapultId);
      }
      
      public function get catapultId() : int
      {
         return _catapultId;
      }
   }
}

