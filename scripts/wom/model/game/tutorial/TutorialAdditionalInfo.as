package wom.model.game.tutorial
{
   public class TutorialAdditionalInfo
   {
      
      public static const BUILDING_TYPE_ID:String = "buildingTypeId";
      
      public static const BUILDING_INSTANCE_ID:String = "buildingInstanceId";
      
      public static const MAP_MEMBER_ID:String = "mapMemberId";
      
      public static const MAP_MEMBER_OPTIONS_MENU:String = "mapMemberOptionsMenu";
      
      public static const UNIT_TYPE_ID:String = "unitTypeId";
      
      public static const UNIT_TYPE_IDS:String = "unitTypeIds";
      
      public static const AMOUNT_OF_UNITS:String = "amountOfUnits";
      
      public static const WAIT_MILISECONDS:String = "waitMiliseconds";
      
      public static const START_TIMER:String = "startTimer";
      
      public static const POP_UP_SHOWN:String = "popUpShown";
      
      public static const PART_TYPE_ID:String = "partTypeId";
      
      public static const QUEST_ID:String = "questId";
      
      public static const QUEST_TASK_ID:String = "taskId";
      
      public static const PROGRESS:String = "progress";
      
      public static const AMOUNT_OF_TOOLTIPS:String = "amountOfTooltips";
      
      public static const STATE_INDEX_HIRE_UNIT:String = "stateIndexHireUnit";
      
      public static const STATE_INDEX_SELECT_FRIENDS:String = "stateIndexSelectFriends";
      
      public static const STATE_INDEX_SEND_REQUEST:String = "stateIndexSendRequest";
      
      public static const STATE_INDEX_EXPLAIN_BATTLE_PROGRESS:String = "stateIndexExplainBattleProgress";
      
      public static const STATE_INDEX_DEPLOY_UNIT:String = "stateIndexDeployUnit";
      
      public static const STATE_INDEX_MAP_MEMBER:String = "stateIndexMapMember";
      
      public static const STATE_INDEX_GO_TO_QUEST:String = "stateIndexGoToQuest";
      
      public static const TAB_BAR_INDEX:String = "tabBarIndex";
      
      public static const TARGET_VALUE:String = "targetVal";
      
      public static const BEAST_CAVE_NOT_BUILT:int = 0;
      
      public static const BEAST_CAVE_ALREADY_BUILT:int = 10;
      
      public var openPopupCount:int;
      
      public var openSecondaryPopupCount:int;
      
      public var lastOpenedPopup:Object;
      
      public var lastOpenedSecondaryPopup:Object;
      
      public var tempVar1:Boolean;
      
      public var firstNpcBattle:Boolean;
      
      public var firstPvPBattle:Boolean;
      
      public var autoSelectCommand:Boolean;
      
      public var beastCageStatus:int;
      
      public var deployHandAnimationCompleted:Boolean;
      
      public var completedAchievements:Array;
      
      public function TutorialAdditionalInfo()
      {
         super();
         openPopupCount = 0;
         openSecondaryPopupCount = 0;
         lastOpenedPopup = null;
         lastOpenedSecondaryPopup = null;
         tempVar1 = false;
         firstNpcBattle = false;
         firstPvPBattle = false;
         autoSelectCommand = false;
         beastCageStatus = 0;
         deployHandAnimationCompleted = false;
         completedAchievements = [];
      }
   }
}

