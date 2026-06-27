package wom.model.game.job
{
   public class BeastTrainingJob
   {
      
      private var _remainingDuration:Number;
      
      private var _executionTime:Number;
      
      private var _originalDuration:Number;
      
      public function BeastTrainingJob(param1:Number, param2:Number, param3:Number)
      {
         super();
         _remainingDuration = param1;
         _executionTime = param2;
         _originalDuration = param3;
      }
      
      public function get remainingDuration() : Number
      {
         return _remainingDuration;
      }
      
      public function get executionTime() : Number
      {
         return _executionTime;
      }
      
      public function get originalDuration() : Number
      {
         return _originalDuration;
      }
   }
}

