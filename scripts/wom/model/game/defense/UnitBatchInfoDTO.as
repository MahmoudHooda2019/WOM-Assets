package wom.model.game.defense
{
   import wom.model.dto.UnitTypeAmountDTO;
   
   public class UnitBatchInfoDTO
   {
      
      private var _batch:UnitTypeAmountDTO;
      
      private var _direction:NPCAttackDirection;
      
      public function UnitBatchInfoDTO(param1:UnitTypeAmountDTO, param2:NPCAttackDirection)
      {
         super();
         _batch = param1;
         _direction = param2;
      }
      
      public function get batch() : UnitTypeAmountDTO
      {
         return _batch;
      }
      
      public function get direction() : NPCAttackDirection
      {
         return _direction;
      }
   }
}

