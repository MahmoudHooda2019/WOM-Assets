package wom.controller.event.mobile
{
   import flash.events.Event;
   
   public class MobileCatapultCombatRechargeStartedEvent extends Event
   {
      
      public static const COMBAT_CATAPULT_RECHARGE_STARTED:String = "combatCatapultRechargeStarted";
      
      private var _catapultType:int;
      
      public function MobileCatapultCombatRechargeStartedEvent(param1:int)
      {
         super("combatCatapultRechargeStarted");
         _catapultType = param1;
      }
      
      public function get catapultType() : int
      {
         return _catapultType;
      }
   }
}

