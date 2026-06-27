package wom.model.game.resource
{
   public class GoldCapacityInfo
   {
      
      private var _remainingTime:Number;
      
      private var _updatedTimer:Number;
      
      public function GoldCapacityInfo(param1:Number, param2:Number)
      {
         super();
         _remainingTime = param1;
         _updatedTimer = param2;
      }
      
      public function get remainingTime() : Number
      {
         return _remainingTime;
      }
      
      public function set remainingTime(param1:Number) : void
      {
         _remainingTime = param1;
      }
      
      public function get updatedTimer() : Number
      {
         return _updatedTimer;
      }
      
      public function set updatedTimer(param1:Number) : void
      {
         _updatedTimer = param1;
      }
   }
}

