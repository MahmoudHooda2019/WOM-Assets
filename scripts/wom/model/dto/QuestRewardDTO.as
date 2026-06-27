package wom.model.dto
{
   import wom.model.game.quest.QuestRewardType;
   
   public class QuestRewardDTO extends RewardDTO
   {
      
      private var _rewardType:QuestRewardType;
      
      private var _subTypeId:int;
      
      public function QuestRewardDTO(param1:QuestRewardType, param2:int, param3:int)
      {
         super(param3);
         _rewardType = param1;
         _subTypeId = param2;
      }
      
      public function get rewardType() : QuestRewardType
      {
         return _rewardType;
      }
      
      public function get subTypeId() : int
      {
         return _subTypeId;
      }
   }
}

