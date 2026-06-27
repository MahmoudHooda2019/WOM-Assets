package wom.model.game.quest
{
   import wom.model.dto.TaskDTO;
   
   public class QuestUtil
   {
      
      public function QuestUtil()
      {
         super();
      }
      
      public static function getQuest(param1:Vector.<QuestInfo>, param2:int) : QuestInfo
      {
         for each(var _loc3_ in param1)
         {
            if(_loc3_.questId == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public static function getTask(param1:Vector.<TaskDTO>, param2:int) : TaskDTO
      {
         for each(var _loc3_ in param1)
         {
            if(_loc3_.taskId == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
   }
}

