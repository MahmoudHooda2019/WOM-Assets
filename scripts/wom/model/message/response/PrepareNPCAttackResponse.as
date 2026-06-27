package wom.model.message.response
{
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.dto.UnitTypeAmountDTO;
   import wom.model.game.defense.NPCAttackDirection;
   import wom.model.game.defense.UnitBatchInfoDTO;
   
   public class PrepareNPCAttackResponse extends AbstractIncomingMessage
   {
      
      private var _npcName:String;
      
      private var _batches:Vector.<UnitBatchInfoDTO>;
      
      public function PrepareNPCAttackResponse()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _npcName = param1.npcName;
         _batches = new Vector.<UnitBatchInfoDTO>();
         for each(var _loc2_ in param1.batches)
         {
            _batches.push(new UnitBatchInfoDTO(new UnitTypeAmountDTO(_loc2_.batch.id,_loc2_.batch.amount),NPCAttackDirection.determineDirectionFromServerDirectionId(_loc2_.direction)));
         }
      }
      
      public function get npcName() : String
      {
         return _npcName;
      }
      
      public function get batches() : Vector.<UnitBatchInfoDTO>
      {
         return _batches;
      }
   }
}

