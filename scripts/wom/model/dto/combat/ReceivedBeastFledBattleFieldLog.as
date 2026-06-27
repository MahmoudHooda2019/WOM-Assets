package wom.model.dto.combat
{
   public class ReceivedBeastFledBattleFieldLog
   {
      
      private var _beastTypeId:int;
      
      private var _occurrenceTimeInMillis:Number;
      
      public function ReceivedBeastFledBattleFieldLog(param1:int, param2:Number)
      {
         super();
         this._beastTypeId = param1;
         this._occurrenceTimeInMillis = param2;
      }
      
      public function get beastTypeId() : int
      {
         return _beastTypeId;
      }
      
      public function get occurrenceTimeInMillis() : Number
      {
         return _occurrenceTimeInMillis;
      }
   }
}

