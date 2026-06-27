package wom.model.game.tutorial
{
   import flash.utils.Dictionary;
   import wom.model.game.ABMode;
   import wom.model.game.Profile;
   import wom.model.game.TutorialDefender;
   
   public class TutorialListInfo
   {
      
      public static const AB_MODE_KEY:String = "tutorial-funnel-test";
      
      public static const TUTORIAL_ID_UNKNOWN:String = "unk";
      
      public static const TUTORIAL_ID_ARCHERS_TOWER:String = "twr";
      
      public static const TUTORIAL_ID_NPC_DEFENSE:String = "def";
      
      public static const TUTORIAL_ID_NPC_REVENGE:String = "rev";
      
      public static const TUTORIAL_ID_HIRING_QUARTERS:String = "hq";
      
      public static const TUTORIAL_ID_HIRE_BEDOUIN_BRUTES:String = "bed";
      
      public static const TUTORIAL_ID_LUMBER_BLADE:String = "lmb";
      
      public static const TUTORIAL_ID_EXTRA_WORKER:String = "wor";
      
      public static const TUTORIAL_ID_PROTECTION_FLAG:String = "flg";
      
      public static const TUTORIAL_ID_HELP_THORZAIN:String = "hlp";
      
      public static const TUTORIAL_ID_RP_EXPLANATION_TYPE_STORE:String = "rp_s";
      
      public static const TUTORIAL_ID_RP_EXPLANATION_TYPE_GAIN_RP:String = "rp_g";
      
      public static const TUTORIAL_ID_FIRST_ATTACK:String = "fa";
      
      public static const TUTORIAL_ID_FIRST_REPAIR:String = "fr";
      
      public static const TUTORIAL_ID_RESOURCE_FULL:String = "rf";
      
      public static const TUTORIAL_ID_FIRST_LOOTER:String = "fl";
      
      public static const TUTORIAL_ID_EXPLAIN_PART_FROM_ACTIVATE_BUILDING:String = "ep_ab";
      
      public static const TUTORIAL_ID_EXPLAIN_PART_FROM_HIRE_WORKER:String = "ep_hw";
      
      public static const TUTORIAL_ID_EXPLAIN_MAPS:String = "em";
      
      public static const TUTORIAL_ID_FIRST_PVP:String = "fpvp";
      
      public static const TUTORIAL_ID_FIRST_TANK:String = "ft";
      
      public static const TUTORIAL_STATE_ID_LAST_MANDATORY:String = "42";
      
      public static const TUTORIAL_STATE_ID_LEAVE_ME:String = "44";
      
      public static const QUEST_ID_NPC_DEFENSE:int = 20;
      
      public static const QUEST_ID_HIRING_QUARTERS:int = 40;
      
      public static const QUEST_ID_LAST_MANDATORY:int = 70;
      
      public static const WHITE_FLAG_REMAINING_TIME_INITIAL_VALUE:Number = 259199832;
      
      public static const BANK_RESOURCES_RESPONSE_RESULT_CODE_RESOURCE_FULL:int = 22;
      
      public static const DEFAULT_AB_MODE:ABMode = ABMode.MODE_A;
      
      private var _enabled:Boolean;
      
      private var _tutorials:Dictionary;
      
      private var _additionalInfo:TutorialAdditionalInfo;
      
      private var _interactableBuildingTypeIds:Dictionary;
      
      private var _interactableBuildingInstanceIds:Dictionary;
      
      public function TutorialListInfo()
      {
         super();
         _tutorials = new Dictionary();
         _additionalInfo = new TutorialAdditionalInfo();
         _enabled = false;
         _interactableBuildingTypeIds = new Dictionary();
         _interactableBuildingInstanceIds = new Dictionary();
      }
      
      public static function getProfileAccordingToTutorial(param1:Profile, param2:TutorialListInfo) : Profile
      {
         var _loc4_:TutorialInfo = null;
         var _loc5_:TutorialState = null;
         var _loc3_:String = null;
         if(param1.isNpc && param2.enabled)
         {
            _loc4_ = "rev" in param2.tutorials ? param2.tutorials["rev"] : null;
            if(_loc4_ != null && !_loc4_.isCompleted && "stateIndexMapMember" in _loc4_.states[0].additionalInfo)
            {
               _loc5_ = _loc4_.states[_loc4_.states[0].additionalInfo["stateIndexMapMember"]];
               if("mapMemberId" in _loc5_.additionalInfo)
               {
                  _loc3_ = _loc5_.additionalInfo["mapMemberId"];
                  if(_loc3_ == param1.npcId)
                  {
                     return TutorialDefender.PROFILE;
                  }
               }
            }
         }
         return param1;
      }
      
      public static function checkInNpcRevengeTutorial(param1:TutorialListInfo) : Boolean
      {
         var _loc2_:TutorialInfo = null;
         if(param1.enabled)
         {
            _loc2_ = "rev" in param1.tutorials ? param1.tutorials["rev"] : null;
            if(_loc2_ != null && !_loc2_.isCompleted)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get enabled() : Boolean
      {
         return _enabled;
      }
      
      public function set enabled(param1:Boolean) : void
      {
         _enabled = param1;
      }
      
      public function get tutorials() : Dictionary
      {
         return _tutorials;
      }
      
      public function get additionalInfo() : TutorialAdditionalInfo
      {
         return _additionalInfo;
      }
      
      public function get interactableBuildingTypeIds() : Dictionary
      {
         return _interactableBuildingTypeIds;
      }
      
      public function get interactableBuildingInstanceIds() : Dictionary
      {
         return _interactableBuildingInstanceIds;
      }
   }
}

