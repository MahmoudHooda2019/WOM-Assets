package wom.model.dto.combat
{
   import flash.utils.Dictionary;
   
   public class ReceivedTroopsReleasedFromWatchPostLog
   {
      
      private var _troopCounts:Dictionary;
      
      private var _occurrenceTimeInMillis:Number;
      
      public function ReceivedTroopsReleasedFromWatchPostLog()
      {
         super();
         _troopCounts = new Dictionary();
         _occurrenceTimeInMillis = 0;
      }
      
      public function get troopCounts() : Dictionary
      {
         return _troopCounts;
      }
      
      public function set troopCounts(param1:Dictionary) : void
      {
         _troopCounts = param1;
      }
      
      public function get occurrenceTimeInMillis() : Number
      {
         return _occurrenceTimeInMillis;
      }
      
      public function set occurrenceTimeInMillis(param1:Number) : void
      {
         _occurrenceTimeInMillis = param1;
      }
   }
}

