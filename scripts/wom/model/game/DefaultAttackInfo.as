package wom.model.game
{
   import flash.utils.Dictionary;
   import peak.thread.WorkerThread;
   import wom.model.dto.combat.TriggeredExplosiveInfo;
   import wom.model.game.beast.BeastInfo;
   import wom.model.game.resource.ResourceType;
   import wom.model.game.store.ItemEffectInfo;
   import wom.model.game.store.ItemEffectType;
   import wom.model.game.store.StoreUtil;
   import wom.model.game.unit.UnitInfo;
   
   public class DefaultAttackInfo implements AttackInfo
   {
      
      public static const ATTACK_LENGTH:Number = 420000;
      
      public static const DEPLOYMENT_LENGTH:Number = 300000;
      
      private var _guid:Number;
      
      private var _unitTypes:Dictionary;
      
      private var _units:Vector.<UnitInfo>;
      
      private var _catapultLevel:int;
      
      private var _attackStartTime:Number;
      
      private var _attackEndTime:Number;
      
      private var _deployPassed:Boolean;
      
      private var _attackEnded:Boolean;
      
      private var _attackEndTimeExtended:Boolean;
      
      private var _defender:Profile;
      
      private var _attacker:Profile;
      
      private var _lootedHarvestedResources:Array;
      
      private var _attackingUserResources:Array;
      
      private var _attackingUserResourceCapacity:int;
      
      private var _salvosUsed:Dictionary;
      
      private var _lootedUnharvestedResources:Dictionary;
      
      private var _lootedParts:Dictionary;
      
      private var _beast:BeastInfo;
      
      private var _usedTrapInstanceIds:Vector.<int>;
      
      private var _totalCatapultDamageDone:Number;
      
      private var _combatItemEffects:Vector.<ItemEffectInfo>;
      
      private var _mostNeededPartId:int;
      
      private var _attackerBeastFledTime:Number;
      
      private var _defenderBeastFledTime:Number;
      
      private var _buildingDamagedLogs:Dictionary;
      
      private var _troopsReleasedFromWatchPostLogs:Dictionary;
      
      private var _explosivesTriggeredLogs:Vector.<TriggeredExplosiveInfo>;
      
      private var _isQuickAttack:Boolean;
      
      private var _isAttackOngoing:Boolean;
      
      private var _bpGainEnabled:Boolean;
      
      private var _ottomanSoundPlayed:Boolean;
      
      private var _ccco:WorkerThread;
      
      private var _spco:WorkerThread;
      
      private var _pfpfp:WorkerThread;
      
      private var _pfpfn:WorkerThread;
      
      private var _seedNumber:int;
      
      private var _beastRetreatFrameNumber:int;
      
      private var _eventItemCounts:Dictionary;
      
      private var _isTournamentAttack:Boolean;
      
      public function DefaultAttackInfo()
      {
         super();
      }
      
      public function reset() : void
      {
         _guid = NaN;
         _deployPassed = false;
         _attackEnded = false;
         _attackEndTimeExtended = false;
         _lootedHarvestedResources = [];
         for each(var _loc1_ in ResourceType.resourceTypes)
         {
            _lootedHarvestedResources[_loc1_.id] = 0;
         }
         _salvosUsed = new Dictionary();
         _lootedUnharvestedResources = new Dictionary();
         _lootedParts = new Dictionary();
         _usedTrapInstanceIds = new Vector.<int>();
         _totalCatapultDamageDone = 0;
         _attackerBeastFledTime = -1;
         _defenderBeastFledTime = -1;
         _buildingDamagedLogs = new Dictionary();
         _troopsReleasedFromWatchPostLogs = new Dictionary();
         _explosivesTriggeredLogs = new Vector.<TriggeredExplosiveInfo>();
         _isQuickAttack = false;
         _isAttackOngoing = false;
         _bpGainEnabled = false;
         _ottomanSoundPlayed = false;
         _ccco = new WorkerThread(0.08);
         _spco = new WorkerThread(0.05);
         _pfpfp = new WorkerThread(5);
         _pfpfn = new WorkerThread(2);
         _seedNumber = 1;
         _beastRetreatFrameNumber = -1;
      }
      
      public function get guid() : Number
      {
         return _guid;
      }
      
      public function set guid(param1:Number) : void
      {
         _guid = param1;
      }
      
      public function get unitTypes() : Dictionary
      {
         return _unitTypes;
      }
      
      public function set unitTypes(param1:Dictionary) : void
      {
         _unitTypes = param1;
      }
      
      public function get units() : Vector.<UnitInfo>
      {
         return _units;
      }
      
      public function set units(param1:Vector.<UnitInfo>) : void
      {
         _units = param1;
      }
      
      public function get deployingUnits() : Vector.<UnitInfo>
      {
         return _units;
      }
      
      public function set deployingUnits(param1:Vector.<UnitInfo>) : void
      {
         _units = param1;
      }
      
      public function get catapultLevel() : int
      {
         return _catapultLevel;
      }
      
      public function set catapultLevel(param1:int) : void
      {
         _catapultLevel = param1;
      }
      
      public function get attackStartTime() : Number
      {
         return _attackStartTime;
      }
      
      public function set attackStartTime(param1:Number) : void
      {
         _attackStartTime = param1;
      }
      
      public function get attackEndTime() : Number
      {
         return _attackEndTime;
      }
      
      public function set attackEndTime(param1:Number) : void
      {
         _attackEndTime = param1;
      }
      
      public function get deployPassed() : Boolean
      {
         return _deployPassed;
      }
      
      public function set deployPassed(param1:Boolean) : void
      {
         _deployPassed = param1;
      }
      
      public function get attackEnded() : Boolean
      {
         return _attackEnded;
      }
      
      public function set attackEnded(param1:Boolean) : void
      {
         _attackEnded = param1;
      }
      
      public function get attackEndTimeExtended() : Boolean
      {
         return _attackEndTimeExtended;
      }
      
      public function set attackEndTimeExtended(param1:Boolean) : void
      {
         _attackEndTimeExtended = param1;
      }
      
      public function get defender() : Profile
      {
         return _defender;
      }
      
      public function set defender(param1:Profile) : void
      {
         _defender = param1;
      }
      
      public function get attacker() : Profile
      {
         return _attacker;
      }
      
      public function set attacker(param1:Profile) : void
      {
         _attacker = param1;
      }
      
      public function get lootedHarvestedResources() : Array
      {
         return _lootedHarvestedResources;
      }
      
      public function set lootedHarvestedResources(param1:Array) : void
      {
         _lootedHarvestedResources = param1;
      }
      
      public function get attackingUserResources() : Array
      {
         return _attackingUserResources;
      }
      
      public function set attackingUserResources(param1:Array) : void
      {
         _attackingUserResources = param1;
      }
      
      public function get attackingUserResourceCapacity() : int
      {
         return _attackingUserResourceCapacity;
      }
      
      public function set attackingUserResourceCapacity(param1:int) : void
      {
         _attackingUserResourceCapacity = param1;
      }
      
      public function get beast() : BeastInfo
      {
         return _beast;
      }
      
      public function set beast(param1:BeastInfo) : void
      {
         _beast = param1;
      }
      
      public function get usedTrapInstanceIds() : Vector.<int>
      {
         return _usedTrapInstanceIds;
      }
      
      public function set usedTrapInstanceIds(param1:Vector.<int>) : void
      {
         _usedTrapInstanceIds = param1;
      }
      
      public function get combatItemEffects() : Vector.<ItemEffectInfo>
      {
         return _combatItemEffects;
      }
      
      public function set combatItemEffects(param1:Vector.<ItemEffectInfo>) : void
      {
         _combatItemEffects = param1;
      }
      
      public function get unitArmorModifier() : Number
      {
         return itemEffectModifier(ItemEffectType.MERCENARY_ARMOR_BOOST);
      }
      
      public function get unitDamageModifier() : Number
      {
         return itemEffectModifier(ItemEffectType.MERCENARY_DAMAGE_BOOST);
      }
      
      public function get unitSpeedModifier() : Number
      {
         return itemEffectModifier(ItemEffectType.MERCENARY_SPEED_BOOST);
      }
      
      public function get barracksSpaceModifier() : Number
      {
         return itemEffectModifier(ItemEffectType.EXTRA_BARRACKS);
      }
      
      public function get towerDamageModifier() : Number
      {
         return itemEffectModifier(ItemEffectType.TOWER_DAMAGE_BOOST);
      }
      
      private function itemEffectModifier(param1:ItemEffectType) : Number
      {
         if(!_combatItemEffects)
         {
            return 1;
         }
         return StoreUtil.itemEffectModifier(param1,_combatItemEffects);
      }
      
      public function get salvosUsed() : Dictionary
      {
         return _salvosUsed;
      }
      
      public function set salvosUsed(param1:Dictionary) : void
      {
         _salvosUsed = param1;
      }
      
      public function get lootedUnharvestedResources() : Dictionary
      {
         return _lootedUnharvestedResources;
      }
      
      public function set lootedUnharvestedResources(param1:Dictionary) : void
      {
         _lootedUnharvestedResources = param1;
      }
      
      public function get lootedParts() : Dictionary
      {
         return _lootedParts;
      }
      
      public function set lootedParts(param1:Dictionary) : void
      {
         _lootedParts = param1;
      }
      
      public function get mostNeededPartId() : int
      {
         return _mostNeededPartId;
      }
      
      public function set mostNeededPartId(param1:int) : void
      {
         _mostNeededPartId = param1;
      }
      
      public function get attackerBeastFledTime() : Number
      {
         return _attackerBeastFledTime;
      }
      
      public function set attackerBeastFledTime(param1:Number) : void
      {
         _attackerBeastFledTime = param1;
      }
      
      public function get defenderBeastFledTime() : Number
      {
         return _defenderBeastFledTime;
      }
      
      public function set defenderBeastFledTime(param1:Number) : void
      {
         _defenderBeastFledTime = param1;
      }
      
      public function get buildingDamagedLogs() : Dictionary
      {
         return _buildingDamagedLogs;
      }
      
      public function set buildingDamagedLogs(param1:Dictionary) : void
      {
         _buildingDamagedLogs = param1;
      }
      
      public function get troopsReleasedFromWatchPostLogs() : Dictionary
      {
         return _troopsReleasedFromWatchPostLogs;
      }
      
      public function set troopsReleasedFromWatchPostLogs(param1:Dictionary) : void
      {
         _troopsReleasedFromWatchPostLogs = param1;
      }
      
      public function get explosivesTriggeredLogs() : Vector.<TriggeredExplosiveInfo>
      {
         return _explosivesTriggeredLogs;
      }
      
      public function set explosivesTriggeredLogs(param1:Vector.<TriggeredExplosiveInfo>) : void
      {
         _explosivesTriggeredLogs = param1;
      }
      
      public function get isQuickAttack() : Boolean
      {
         return _isQuickAttack;
      }
      
      public function set isQuickAttack(param1:Boolean) : void
      {
         _isQuickAttack = param1;
      }
      
      public function get totalCatapultDamageDone() : Number
      {
         return _totalCatapultDamageDone;
      }
      
      public function set totalCatapultDamageDone(param1:Number) : void
      {
         _totalCatapultDamageDone = param1;
      }
      
      public function get isAttackOngoing() : Boolean
      {
         return _isAttackOngoing;
      }
      
      public function set isAttackOngoing(param1:Boolean) : void
      {
         _isAttackOngoing = param1;
      }
      
      public function get ccco() : Number
      {
         var _loc1_:WorkerThread = _ccco;
         return _loc1_._value;
      }
      
      public function get spco() : Number
      {
         var _loc1_:WorkerThread = _spco;
         return _loc1_._value;
      }
      
      public function get pfpfp() : Number
      {
         var _loc1_:WorkerThread = _pfpfp;
         return _loc1_._value;
      }
      
      public function get pfpfn() : Number
      {
         var _loc1_:WorkerThread = _pfpfn;
         return _loc1_._value;
      }
      
      public function get ottomanSoundPlayed() : Boolean
      {
         return _ottomanSoundPlayed;
      }
      
      public function set ottomanSoundPlayed(param1:Boolean) : void
      {
         _ottomanSoundPlayed = param1;
      }
      
      public function get seedNumber() : int
      {
         return _seedNumber;
      }
      
      public function set seedNumber(param1:int) : void
      {
         _seedNumber = param1;
      }
      
      public function set beastRetreatFrameNumber(param1:int) : void
      {
         _beastRetreatFrameNumber = param1;
      }
      
      public function get beastRetreatFrameNumber() : int
      {
         return _beastRetreatFrameNumber;
      }
      
      public function get eventItemCounts() : Dictionary
      {
         return _eventItemCounts;
      }
      
      public function set eventItemCounts(param1:Dictionary) : void
      {
         _eventItemCounts = param1;
      }
      
      public function get bpGainEnabled() : Boolean
      {
         return _bpGainEnabled;
      }
      
      public function set bpGainEnabled(param1:Boolean) : void
      {
         _bpGainEnabled = param1;
      }
      
      public function set isTournamentAttack(param1:Boolean) : void
      {
         _isTournamentAttack = param1;
      }
      
      public function get isTournamentAttack() : Boolean
      {
         return _isTournamentAttack;
      }
   }
}

