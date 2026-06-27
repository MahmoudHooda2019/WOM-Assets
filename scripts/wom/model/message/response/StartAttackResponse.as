package wom.model.message.response
{
   import flash.utils.Dictionary;
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.game.CityInfoDTO;
   import wom.model.game.Profile;
   import wom.model.game.attack.CatapultTimeUtil;
   
   public class StartAttackResponse extends AbstractIncomingMessage
   {
      
      public static const SUCCESS:int = 0;
      
      public static const GENERAL_FAILURE:int = 1;
      
      public static const NO_SUCH_USER:int = 2;
      
      public static const NO_SUCH_ATTACKER:int = 3;
      
      public static const NO_SUCH_DEFENDER:int = 4;
      
      public static const DEFENDER_IS_ONLINE:int = 5;
      
      public static const DEFENDER_CITY_IS_ALREADY_UNDER_ATTACK:int = 6;
      
      public static const DEFENDER_CITY_IS_UNDER_PROTECTION:int = 7;
      
      public static const ATTACKER_CITY_IS_ALREADY_IN_BATTLE:int = 8;
      
      public static const ATTACKER_AND_DEFENDER_ARE_SAME:int = 9;
      
      public static const NO_ATTACKER_DEFENDER_INFO:int = 10;
      
      public static const ATTACKER_CITY_DOES_NOT_EXIST:int = 11;
      
      public static const DEFENDER_CITY_DOES_NOT_EXIST:int = 12;
      
      public static const DESTINATION_HAS_BATTLE_PROTECTION_ITEM:int = 13;
      
      public static const ATTACKER_HAS_NO_ASSEMBLY_AREA:int = 14;
      
      public static const DEFENDER_LEVEL_TOO_LOW:int = 15;
      
      public static const TRUCE_EXISTS_WITH_PLAYER:int = 16;
      
      public static const INVALID_NPC_ATTACK_CHOICE:int = 17;
      
      public static const NPC_ATTACK_NOT_TIMELY:int = 18;
      
      public static const NPC_ATTACK_ALREADY_DELAYED:int = 19;
      
      public static const NPC_ARMY_NOT_GENERATED_YET:int = 20;
      
      public static const DEFENDER_TUTORIAL_IN_PROGRESS:int = 21;
      
      public static const SERVER_IN_MAINTENANCE:int = 22;
      
      public static const ACCESS_TO_DEFENDER_TIMED_OUT:int = 23;
      
      public static const DEFENDER_ALREADY_COMPLETELY_DESTROYED:int = 24;
      
      public static const DEFENDER_NOT_MAP_MEMBER:int = 26;
      
      public static const QUICK_ATTACK_INSUFFICIENT_GOLD:int = 29;
      
      public static const QUICK_ATTACK_NO_ELIGIBLE_TARGET:int = 30;
      
      public static const SPY_IMPOSSIBLE_DUE_TO_NON_ATTACKABLITY:int = 31;
      
      public static const TARGET_BEING_SPIED:int = 32;
      
      public static const SPY_INSUFFICIENT_GOLD:int = 33;
      
      public static const DEFENDER_IN_OWN_ALLIANCE:int = 35;
      
      public static const DEFENDER_LEVEL_TOO_HIGH:int = 36;
      
      public static const CANNOT_ATTACK_FRIEND:int = 37;
      
      public static const NPC_ATTACK_DISABLED:int = 38;
      
      public static const TOURNAMENT_NOT_READY:int = 39;
      
      public static const NO_ACTIVE_TOURNAMENT:int = 40;
      
      public static const LEVEL_TOO_LOW_FOR_TOURNAMENT:int = 41;
      
      public static const ATTACKER_NOT_IN_ALLIANCE:int = 42;
      
      public static const DEFENDER_CITY_DAMAGED:int = 43;
      
      public static const TOURNAMENT_ENDING:int = 44;
      
      public static const DONT_HAVE_ANYTHING_TO_ATTACK:int = 1000;
      
      private var _resultCode:int;
      
      private var _resultMessage:String;
      
      private var _defender:Profile;
      
      private var _guid:Number;
      
      private var _isQuickAttack:Boolean;
      
      private var _bpGainEnabled:Boolean;
      
      private var _lastCatapultFiredTimes:Dictionary;
      
      private var _city:CityInfoDTO;
      
      private var _beastHealth:Number;
      
      private var _seedNumber:uint;
      
      private var _isTournamentAttack:Boolean;
      
      public function StartAttackResponse()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         var _loc2_:Object = null;
         _resultMessage = param1.resultMessage;
         _resultCode = param1.resultCode;
         _guid = NaN;
         if(_resultCode == 0)
         {
            if("guid" in param1 && param1.guid)
            {
               _guid = param1.guid;
            }
            _lastCatapultFiredTimes = CatapultTimeUtil.deserializeCatapultTimes(param1.lastCatapultFiredTimes);
            _isQuickAttack = param1.quickAttack;
            _bpGainEnabled = true;
            if("bpGainEnabled" in param1)
            {
               _bpGainEnabled = param1.bpGainEnabled;
            }
            if("npcDefender" in param1 && param1.npcDefender != null)
            {
               _defender = new Profile(null,null,null,param1.npcDefender,param1.defenderNpcClanId);
            }
            else
            {
               _defender = new Profile(param1.defender[0],param1.defender[1],param1.defender[2]);
            }
            if(param1.defenderCity)
            {
               _loc2_ = param1.defenderCity;
               _city = new CityInfoDTO();
               _city.deserialize(_loc2_);
            }
            if("beastHealth" in param1)
            {
               _beastHealth = param1.beastHealth;
            }
            else
            {
               _beastHealth = -1;
            }
            _seedNumber = uint(param1.seedNumber);
            _isTournamentAttack = param1.tournamentAttack;
         }
      }
      
      public function get defender() : Profile
      {
         return _defender;
      }
      
      public function get resultCode() : int
      {
         return _resultCode;
      }
      
      public function get city() : CityInfoDTO
      {
         return _city;
      }
      
      public function get resultMessage() : String
      {
         return _resultMessage;
      }
      
      public function get guid() : Number
      {
         return _guid;
      }
      
      public function get lastCatapultFiredTimes() : Dictionary
      {
         return _lastCatapultFiredTimes;
      }
      
      public function get isQuickAttack() : Boolean
      {
         return _isQuickAttack;
      }
      
      public function get beastHealth() : Number
      {
         return _beastHealth;
      }
      
      public function get seedNumber() : uint
      {
         return _seedNumber;
      }
      
      public function get bpGainEnabled() : Boolean
      {
         return _bpGainEnabled;
      }
      
      public function get isTournamentAttack() : Boolean
      {
         return _isTournamentAttack;
      }
   }
}

