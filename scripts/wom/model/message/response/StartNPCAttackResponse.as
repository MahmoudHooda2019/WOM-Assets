package wom.model.message.response
{
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.dto.UnitTypeAmountDTO;
   import wom.model.game.defense.NPCAttackDirection;
   import wom.model.game.defense.UnitBatchInfoDTO;
   
   public class StartNPCAttackResponse extends AbstractIncomingMessage
   {
      
      private var _resultCode:int;
      
      private var _resultMessage:String;
      
      private var _npcName:String;
      
      private var _batches:Vector.<UnitBatchInfoDTO>;
      
      private var _beastHealth:Number;
      
      private var _seedNumber:uint;
      
      public function StartNPCAttackResponse()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _resultCode = param1.resultCode;
         _resultMessage = param1.resultMessage;
         if(_resultCode == 0)
         {
            _npcName = param1.npcName;
            _batches = new Vector.<UnitBatchInfoDTO>();
            for each(var _loc2_ in param1.batches)
            {
               _batches.push(new UnitBatchInfoDTO(new UnitTypeAmountDTO(_loc2_.batch.id,_loc2_.batch.amount),NPCAttackDirection.determineDirectionFromServerDirectionId(_loc2_.direction)));
            }
            if("beastHealth" in param1)
            {
               _beastHealth = param1.beastHealth;
            }
            else
            {
               _beastHealth = -1;
            }
         }
         _seedNumber = uint(param1.seedNumber);
      }
      
      public function get resultCode() : int
      {
         return _resultCode;
      }
      
      public function get resultMessage() : String
      {
         return _resultMessage;
      }
      
      public function get npcName() : String
      {
         return _npcName;
      }
      
      public function get batches() : Vector.<UnitBatchInfoDTO>
      {
         return _batches;
      }
      
      public function get beastHealth() : Number
      {
         return _beastHealth;
      }
      
      public function get seedNumber() : uint
      {
         return _seedNumber;
      }
   }
}

