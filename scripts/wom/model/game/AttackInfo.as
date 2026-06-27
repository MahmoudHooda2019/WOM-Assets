package wom.model.game
{
   import flash.utils.Dictionary;
   import wom.model.dto.combat.TriggeredExplosiveInfo;
   import wom.model.game.beast.BeastInfo;
   import wom.model.game.store.ItemEffectInfo;
   import wom.model.game.unit.UnitInfo;
   
   public interface AttackInfo
   {
      
      function reset() : void;
      
      function get guid() : Number;
      
      function set guid(param1:Number) : void;
      
      function get unitTypes() : Dictionary;
      
      function set unitTypes(param1:Dictionary) : void;
      
      function get units() : Vector.<UnitInfo>;
      
      function set units(param1:Vector.<UnitInfo>) : void;
      
      function get catapultLevel() : int;
      
      function set catapultLevel(param1:int) : void;
      
      function get attackStartTime() : Number;
      
      function set attackStartTime(param1:Number) : void;
      
      function get attackEndTime() : Number;
      
      function set attackEndTime(param1:Number) : void;
      
      function get deployPassed() : Boolean;
      
      function set deployPassed(param1:Boolean) : void;
      
      function get attackEnded() : Boolean;
      
      function set attackEnded(param1:Boolean) : void;
      
      function get attackEndTimeExtended() : Boolean;
      
      function set attackEndTimeExtended(param1:Boolean) : void;
      
      function get defender() : Profile;
      
      function set defender(param1:Profile) : void;
      
      function get attacker() : Profile;
      
      function set attacker(param1:Profile) : void;
      
      function get lootedHarvestedResources() : Array;
      
      function set lootedHarvestedResources(param1:Array) : void;
      
      function get lootedUnharvestedResources() : Dictionary;
      
      function set lootedUnharvestedResources(param1:Dictionary) : void;
      
      function get attackingUserResources() : Array;
      
      function set attackingUserResources(param1:Array) : void;
      
      function get attackingUserResourceCapacity() : int;
      
      function set attackingUserResourceCapacity(param1:int) : void;
      
      function get beast() : BeastInfo;
      
      function set beast(param1:BeastInfo) : void;
      
      function get usedTrapInstanceIds() : Vector.<int>;
      
      function set usedTrapInstanceIds(param1:Vector.<int>) : void;
      
      function get combatItemEffects() : Vector.<ItemEffectInfo>;
      
      function set combatItemEffects(param1:Vector.<ItemEffectInfo>) : void;
      
      function get unitArmorModifier() : Number;
      
      function get unitDamageModifier() : Number;
      
      function get unitSpeedModifier() : Number;
      
      function get barracksSpaceModifier() : Number;
      
      function get towerDamageModifier() : Number;
      
      function get salvosUsed() : Dictionary;
      
      function set salvosUsed(param1:Dictionary) : void;
      
      function get lootedParts() : Dictionary;
      
      function set lootedParts(param1:Dictionary) : void;
      
      function get mostNeededPartId() : int;
      
      function set mostNeededPartId(param1:int) : void;
      
      function get attackerBeastFledTime() : Number;
      
      function set attackerBeastFledTime(param1:Number) : void;
      
      function get defenderBeastFledTime() : Number;
      
      function set defenderBeastFledTime(param1:Number) : void;
      
      function get buildingDamagedLogs() : Dictionary;
      
      function set buildingDamagedLogs(param1:Dictionary) : void;
      
      function get troopsReleasedFromWatchPostLogs() : Dictionary;
      
      function set troopsReleasedFromWatchPostLogs(param1:Dictionary) : void;
      
      function get explosivesTriggeredLogs() : Vector.<TriggeredExplosiveInfo>;
      
      function set explosivesTriggeredLogs(param1:Vector.<TriggeredExplosiveInfo>) : void;
      
      function get isQuickAttack() : Boolean;
      
      function set isQuickAttack(param1:Boolean) : void;
      
      function get totalCatapultDamageDone() : Number;
      
      function set totalCatapultDamageDone(param1:Number) : void;
      
      function get isAttackOngoing() : Boolean;
      
      function set isAttackOngoing(param1:Boolean) : void;
      
      function get ccco() : Number;
      
      function get spco() : Number;
      
      function get pfpfp() : Number;
      
      function get pfpfn() : Number;
      
      function get ottomanSoundPlayed() : Boolean;
      
      function set ottomanSoundPlayed(param1:Boolean) : void;
      
      function get seedNumber() : int;
      
      function set seedNumber(param1:int) : void;
      
      function set beastRetreatFrameNumber(param1:int) : void;
      
      function get beastRetreatFrameNumber() : int;
      
      function get eventItemCounts() : Dictionary;
      
      function set eventItemCounts(param1:Dictionary) : void;
      
      function get bpGainEnabled() : Boolean;
      
      function set bpGainEnabled(param1:Boolean) : void;
      
      function set isTournamentAttack(param1:Boolean) : void;
      
      function get isTournamentAttack() : Boolean;
   }
}

