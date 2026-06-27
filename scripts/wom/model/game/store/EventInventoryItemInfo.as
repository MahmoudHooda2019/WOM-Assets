package wom.model.game.store
{
   import flash.utils.getTimer;
   
   public class EventInventoryItemInfo
   {
      
      private var _id:int;
      
      private var _remainingDuration:int;
      
      private var _expectedFinishTimer:int;
      
      private var _originalDuration:int;
      
      public function EventInventoryItemInfo(param1:int, param2:int, param3:int)
      {
         super();
         _id = param1;
         _remainingDuration = param2;
         _expectedFinishTimer = getTimer() + param3 + param2;
         _originalDuration = -1;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function getRemainingDuration() : int
      {
         var _loc1_:int = _expectedFinishTimer - getTimer();
         return _loc1_ <= 0 ? 0 : _loc1_;
      }
      
      public function isReady() : Boolean
      {
         return getRemainingDuration() == 0;
      }
      
      public function set originalDuration(param1:int) : void
      {
         _originalDuration = param1;
      }
      
      public function get originalDuration() : int
      {
         return _originalDuration;
      }
   }
}

