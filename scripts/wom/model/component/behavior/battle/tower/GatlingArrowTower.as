package wom.model.component.behavior.battle.tower
{
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.utils.Dictionary;
   import peak.cuckoo.game.dto.Point3;
   import peak.signal.FunctionSlot0;
   import peak.util.ValidationRecorder;
   import peak.util.ValidationVerifier;
   import wom.model.component.attribute.SfxManager;
   import wom.model.component.attribute.data.BuildingData;
   import wom.model.component.behavior.ParticleManager;
   import wom.model.component.behavior.battle.BattleManager;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.component.entity.gamesprite.Particle;
   import wom.model.component.entity.gamesprite.Unit;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   
   public class GatlingArrowTower extends TowerDefense
   {
      
      public static const RANDOM_RADIUS:Number = 25;
      
      private var buildingSpecificInfo:Dictionary;
      
      private var levelIndex:int;
      
      private var damage:Number;
      
      public var particleManager:ParticleManager;
      
      private var reloadTime:Number;
      
      private var wait:Number;
      
      private var shotsFired:int;
      
      private var shotsFiredPerCharge:int;
      
      private var attackStarted:Boolean;
      
      private const ARROW_VELOCITY:int = 15;
      
      private const WAIT_BETWEEN_SHOTS:int = 6;
      
      private const ATTACKING_RANGE_EXTENSION:int = 15;
      
      private var particle:Particle;
      
      private var sfx:SfxManager;
      
      private var towerSound:Sound;
      
      private var sfxChannel:SoundChannel;
      
      private var particleAssetId:String;
      
      public function GatlingArrowTower(param1:BattleManager, param2:Number)
      {
         super(param1,param2);
      }
      
      override public function init() : void
      {
         particleAssetId = "GatlingDart";
         var _loc1_:BuildingData = (owner as Building).data;
         buildingSpecificInfo = _loc1_.buildingTypeDIO.buildingSpecificInfo;
         levelIndex = _loc1_.buildingInfo.level == 0 ? 0 : _loc1_.buildingInfo.level - 1;
         r = buildingSpecificInfo[BuildingSpecificInfoType.RANGES_PER_LEVEL_IN_PX.id][levelIndex] / 5;
         shotsFiredPerCharge = buildingSpecificInfo[BuildingSpecificInfoType.SHOTS_FIRED_PER_CHARGE_PER_LEVEL.id][levelIndex];
         calculateDamage();
         super.init();
         particleManager = womRoot.particleManager;
         reloadTime = buildingSpecificInfo[BuildingSpecificInfoType.RELOAD_TIME_IN_SECS.id] * 60;
         attackStarted = false;
         wait = 0;
         shotsFired = 0;
         sfx = womRoot.sfxManager;
         towerSound = sfx.assetRepository.getSoundAssetReference("GatlingArrowTowerAttack").soundAsset.sound;
      }
      
      override public function checkUnitToAttack(param1:Unit) : int
      {
         var _loc3_:Number = (param1.position.point.x - position.x) * (param1.position.point.x - position.x) + (param1.position.point.y - position.y) * (param1.position.point.y - position.y);
         var _loc2_:int = attackStarted ? r + 15 : r;
         if(_loc3_ > _loc2_ * _loc2_)
         {
            var _loc4_:WorkerThread = womRoot.tdrd;
            return _loc4_._value;
         }
         if(param1.data.info.typeId == 22 && param1.movement.enabled)
         {
            var _loc5_:WorkerThread = womRoot.tdrd;
            return _loc5_._value;
         }
         if(!tu || _loc3_ < td)
         {
            tu = param1;
            td = _loc3_;
         }
         var _loc6_:WorkerThread = womRoot.tdrg;
         return _loc6_._value;
      }
      
      override public function startAttack() : void
      {
         tu.underAttack.startTowerUnderAttack(ownerBuilding);
         enable();
      }
      
      override public function update() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         super.update();
         var _loc3_:WorkerThread = rm;
         var _loc4_:WorkerThread;
         if(_loc3_._value == (_loc4_ = womRoot.tdrd)._value)
         {
            if(tu)
            {
               if(!attackStarted)
               {
                  sfxChannel = sfx.towerEffect(towerSound,ownerBuilding);
               }
               attackStarted = true;
               wait -= sync.elapsed;
               if(wait <= 0)
               {
                  wait = 6;
                  _loc1_ = 25 * (2 * womRoot.pseudoRandomGenerator.nextDouble() - 1);
                  _loc2_ = 25 * (2 * womRoot.pseudoRandomGenerator.nextDouble() - 1);
                  particle = new Particle(new Point3(ownerBuilding.position.projected.x + 70 + _loc1_,ownerBuilding.position.projected.y - 120 + _loc2_),tu.position.projected,new Point3(tu.viewManager.middlePoint.x + _loc1_,tu.viewManager.middlePoint.y + _loc2_),15,particleAssetId,true,true);
                  particle.hit.add(new HitHandler(tu,damage));
                  particleManager.throwParticle(particle);
                  shotsFired = shotsFired + 1;
                  if(shotsFired >= shotsFiredPerCharge)
                  {
                     var _temp_9:* = rm;
                     var _loc6_:WorkerThread;
                     var _loc10_:Number = (_loc6_ = womRoot.tdrg)._value;
                     var _loc7_:WorkerThread = _temp_9;
                     _loc7_._value = _loc10_;
                     reloadWait = reloadTime;
                     wait = 0;
                     attackStarted = false;
                     shotsFired = 0;
                     particle.hit.add(new FunctionSlot0(lastArrowHit));
                  }
               }
            }
            else
            {
               var _temp_16:* = rm;
               var _loc8_:WorkerThread;
               var _loc11_:Number = (_loc8_ = womRoot.tdrg)._value;
               var _loc9_:WorkerThread = _temp_16;
               _loc9_._value = _loc11_;
               reloadWait = reloadTime;
               wait = 0;
               attackStarted = false;
               shotsFired = 0;
               particle && particle.hit.add(new FunctionSlot0(lastArrowHit));
            }
         }
      }
      
      private function lastArrowHit() : void
      {
         if(sfxChannel)
         {
            sfxChannel.stop();
         }
      }
      
      override public function calculateDamage() : void
      {
         damage = buildingSpecificInfo[BuildingSpecificInfoType.DAMAGES_PER_SHOT_PER_LEVEL.id][levelIndex] * d;
      }
   }
}

import peak.signal.Slot0;
import wom.model.component.entity.gamesprite.Unit;

class HitHandler implements Slot0
{
   
   public var targetUnit:Unit;
   
   public var damage:Number;
   
   public function HitHandler(param1:Unit, param2:Number)
   {
      super();
      this.targetUnit = param1;
      this.damage = param2;
   }
   
   public function onSignal0() : void
   {
      if(targetUnit)
      {
         targetUnit.underAttack.hit(damage);
      }
   }
}
