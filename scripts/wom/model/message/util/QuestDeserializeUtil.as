package wom.model.message.util
{
   import peak.logging.LoggerContexts;
   import peak.logging.log;
   import peak.serialization.json.PJSON;
   import wom.model.dto.QuestDTO;
   import wom.model.dto.QuestRewardDTO;
   import wom.model.dto.TaskDTO;
   import wom.model.game.quest.QuestRewardType;
   import wom.model.game.window.WindowEnumeration;
   
   public class QuestDeserializeUtil
   {
      
      public function QuestDeserializeUtil()
      {
         super();
      }
      
      public static function createQuestDTO(param1:Object, param2:String = "definition") : QuestDTO
      {
         var _loc6_:int = 0;
         var _loc10_:QuestRewardType = null;
         var _loc4_:Vector.<QuestRewardDTO> = new Vector.<QuestRewardDTO>();
         var _loc7_:Vector.<TaskDTO> = new Vector.<TaskDTO>();
         var _loc5_:Boolean = true;
         for each(var _loc8_ in param1[param2].rewards)
         {
            if("unitTypeId" in _loc8_)
            {
               _loc6_ = int(_loc8_.unitTypeId);
            }
            else if("resourceTypeId" in _loc8_)
            {
               _loc6_ = int(_loc8_.resourceTypeId);
            }
            _loc10_ = QuestRewardType.determineRewardType(_loc8_.rewardType);
            if(_loc10_ != QuestRewardType.QRT_UNKNOWN && _loc10_ != QuestRewardType.QRT_XP)
            {
               _loc4_.push(new QuestRewardDTO(QuestRewardType.determineRewardType(_loc8_.rewardType),_loc6_,_loc8_.amount));
            }
         }
         if("state" in param1)
         {
            _loc5_ = Boolean(param1.state.completed);
            for each(var _loc9_ in param1.state.tasks)
            {
               for each(var _loc3_ in param1[param2].tasks)
               {
                  if(_loc9_.taskDefinitionId == _loc3_.id)
                  {
                     _loc7_.push(new TaskDTO(_loc9_.taskDefinitionId,param1[param2].id,_loc9_.completed,_loc9_.skipped,_loc9_.progressValue,_loc3_.retro,_loc3_.maxVal,_loc3_.skippable,_loc3_.skipCost,createHighlight(_loc3_.highlight)));
                  }
               }
            }
         }
         return new QuestDTO(param1[param2].id,param1[param2].order,param1[param2].family,_loc4_,param1[param2].visualId,_loc5_,_loc7_);
      }
      
      private static function createHighlight(param1:String = "") : WindowEnumeration
      {
         var _loc4_:Object = null;
         var _loc2_:Array = null;
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         var _loc3_:String = "{";
         try
         {
            _loc2_ = param1.split(",");
            _loc6_ = 0;
            while(_loc6_ < _loc2_.length)
            {
               _loc5_ = _loc2_[_loc6_].split(":",2);
               _loc3_ += "\"" + trim(_loc5_[0]) + "\":\"" + trim(_loc5_[1]) + "\"" + (_loc6_ < _loc2_.length - 1 ? "," : "");
               _loc6_++;
            }
            _loc3_ += "}";
            _loc4_ = PJSON.decode(_loc3_);
         }
         catch(e:Error)
         {
            log(LoggerContexts.NETWORK,"Quest task definition does not contain valid attribute for highlight: " + param1);
            return null;
         }
         if("w" in _loc4_)
         {
            return new WindowEnumeration(_loc4_.w,_loc4_);
         }
         return null;
      }
      
      private static function trim(param1:String) : String
      {
         return param1.replace(/^([\s|\t|\n]+)?(.*)([\s|\t|\n]+)?$/gm,"$2");
      }
   }
}

