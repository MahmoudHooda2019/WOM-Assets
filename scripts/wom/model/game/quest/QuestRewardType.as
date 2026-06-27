package wom.model.game.quest
{
   import peak.logging.log;
   import wom.service.logging.WomLoggerContexts;
   
   public class QuestRewardType
   {
      
      public static const QRT_UNKNOWN:QuestRewardType = new QuestRewardType(-1);
      
      public static const QRT_RESOURCE:QuestRewardType = new QuestRewardType(0);
      
      public static const QRT_GOLD:QuestRewardType = new QuestRewardType(1);
      
      public static const QRT_UNIT:QuestRewardType = new QuestRewardType(2);
      
      public static const QRT_XP:QuestRewardType = new QuestRewardType(3);
      
      private var _id:int;
      
      public function QuestRewardType(param1:int)
      {
         super();
         _id = param1;
      }
      
      public static function determineRewardType(param1:String) : QuestRewardType
      {
         var _loc2_:QuestRewardType = QRT_UNKNOWN;
         switch(param1)
         {
            case "Resource":
               _loc2_ = QRT_RESOURCE;
               break;
            case "Gold":
               _loc2_ = QRT_GOLD;
               break;
            case "Troop":
            case "Unit":
               _loc2_ = QRT_UNIT;
               break;
            case "ExperiencePoint":
               _loc2_ = QRT_XP;
               break;
            default:
               log(WomLoggerContexts.GAME,"Quest Reward id to be determined is invalid: " + param1);
         }
         return _loc2_;
      }
   }
}

