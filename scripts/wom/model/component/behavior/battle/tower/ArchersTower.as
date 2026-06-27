package wom.model.component.behavior.battle.tower
{
   import flash.media.Sound;
   import flash.utils.Dictionary;
   import peak.cuckoo.game.dto.Point3;
   import peak.util.ValidationRecorder;
   import peak.util.ValidationVerifier;
   import wom.model.component.attribute.SfxManager;
   import wom.model.component.attribute.data.BuildingData;
   import wom.model.component.behavior.ParticleManager;
   import wom.model.component.behavior.battle.BattleManager;
   import wom.model.component.behavior.catapult.CatapultAnimationFrame;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.component.entity.gamesprite.Particle;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   
   public class ArchersTower extends CatapultAnimationFrame
   {
      
      private var buildingSpecificInfo:Dictionary;
      
      private var levelIndex:int;
      
      internal var damage:Number;
      
      public var particleManager:ParticleManager;
      
      private var reloadTime:Number;
      
      private const ARROW_VELOCITY:int = 30;
      
      private var sfx:SfxManager;
      
      private var towerSound:Sound;
      
      private var particleAssetId:String;
      
      public function ArchersTower(param1:BattleManager, param2:Number)
      {
         super(param1,param2);
      }
      
      override public function init() : void
      {
         particleAssetId = "ArchersArrow";
         ownerBuilding = owner as Building;
         var _loc1_:BuildingData = ownerBuilding.data;
         buildingSpecificInfo = _loc1_.buildingTypeDIO.buildingSpecificInfo;
         levelIndex = _loc1_.buildingInfo.level == 0 ? 0 : _loc1_.buildingInfo.level - 1;
         r = buildingSpecificInfo[BuildingSpecificInfoType.RANGES_PER_LEVEL_IN_PX.id][levelIndex] / 5;
         calculateDamage();
         super.init();
         particleManager = womRoot.particleManager;
         reloadTime = buildingSpecificInfo[BuildingSpecificInfoType.RELOAD_TIME_IN_SECS.id] * 60;
         sfx = womRoot.sfxManager;
         towerSound = sfx.assetRepository.getSoundAssetReference("ArchersTowerAttack").soundAsset.sound;
      }
      
      override public function startAttack() : void
      {
         tu.underAttack.startTowerUnderAttack(ownerBuilding);
         enable();
      }
      
      override public function update() : void
      {
         var _loc1_:Particle = null;
         super.update();
         var _loc2_:WorkerThread = rm;
         if(_loc2_._value == womRoot.tdrd._value)
         {
            if(tu)
            {
               _loc1_ = new Particle(new Point3(ownerBuilding.position.projected.x + 70,ownerBuilding.position.projected.y - 120),tu.position.projected,new Point3(tu.viewManager.middlePoint.x,tu.viewManager.middlePoint.y),30,particleAssetId,true,true);
               _loc1_.hit.add(new HitHandler(tu,damage));
               particleManager.throwParticle(_loc1_);
               var _temp_2:* = rm;
               var _loc5_:WorkerThread;
               var _loc7_:Number = (_loc5_ = womRoot.tdrg)._value;
               var _loc6_:WorkerThread = _temp_2;
               _loc6_._value = _loc7_;
               reloadWait = reloadTime;
               sfx.towerEffect(towerSound,ownerBuilding);
            }
            else
            {
               disable();
            }
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
      if(targetUnit && targetUnit.parent)
      {
         targetUnit.underAttack.hit(damage);
      }
   }
}
