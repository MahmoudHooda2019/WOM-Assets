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
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.component.entity.gamesprite.Particle;
   import wom.model.component.entity.gamesprite.Unit;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   
   public class BeastCannon extends TowerDefense
   {
      
      private var particleAssetId:String;
      
      private var levelIndex:int;
      
      private var buildingSpecificInfo:Dictionary;
      
      private var range:Number;
      
      private var percentDamage:Number;
      
      private var numberOfBullets:int;
      
      private var particleManager:ParticleManager;
      
      private var reloadTime:Number;
      
      private var spendTime:Number;
      
      private var wait:Number;
      
      private const CANNON_VELOCITY:Number = 30;
      
      private var sfx:SfxManager;
      
      private var towerSound:Sound;
      
      public function BeastCannon(param1:BattleManager, param2:Number)
      {
         super(param1,param2);
      }
      
      override public function init() : void
      {
         ownerBuilding = owner as Building;
         var _loc1_:BuildingData = ownerBuilding.data;
         particleAssetId = "B32CannonBall";
         levelIndex = _loc1_.buildingInfo.level == 0 ? 0 : _loc1_.buildingInfo.level - 1;
         buildingSpecificInfo = _loc1_.buildingTypeDIO.buildingSpecificInfo;
         range = buildingSpecificInfo[BuildingSpecificInfoType.RANGES_PER_LEVEL_IN_PX.id][levelIndex] * 0.2;
         percentDamage = buildingSpecificInfo[BuildingSpecificInfoType.DAMAGES_PER_SHOT_PER_LEVEL.id][levelIndex];
         calculateDamage();
         super.init();
         particleManager = womRoot.particleManager;
         reloadTime = buildingSpecificInfo[BuildingSpecificInfoType.RELOAD_TIME_IN_SECS.id] * sync.fps;
         numberOfBullets = womRoot.cityInfo.beastCannonInfo.ammoAmount;
         spendTime = 0;
         wait = 60;
         sfx = womRoot.sfxManager;
         towerSound = sfx.assetRepository.getSoundAssetReference("BombardTowerAttack1").soundAsset.sound;
         enable();
      }
      
      override public function update() : void
      {
         var _loc3_:Point3 = null;
         var _loc2_:Particle = null;
         spendTime += sync.precise;
         var _temp_2:* = §§findproperty(wait);
         if((wait = wait - sync.precise) > 0)
         {
            return;
         }
         if(ownerBuilding.data.buildingInfo.healthPoint <= 0 || numberOfBullets <= 0)
         {
            disable();
            return;
         }
         var _loc1_:Unit = b.battleFieldControl.beast;
         if(_loc1_)
         {
            wait = reloadTime;
            if(_loc1_.data.info.healthPoints > 0)
            {
               trace("BeastHealth:" + _loc1_.data.info.healthPoints + " - " + spendTime);
               if((_loc1_.position.point.x - position.x) * (_loc1_.position.point.x - position.x) + (_loc1_.position.point.y - position.y) * (_loc1_.position.point.y - position.y) <= range * range)
               {
                  _loc3_ = new Point3(_loc1_.position.projected.x,_loc1_.position.projected.y);
                  _loc2_ = new Particle(new Point3(ownerBuilding.position.projected.x + 70,ownerBuilding.position.projected.y - 120),_loc3_,new Point3(_loc1_.viewManager.middlePoint.x,_loc1_.viewManager.middlePoint.y),30,particleAssetId,false,false);
                  _loc2_.hit.add(new HitHandler(this));
                  particleManager.throwParticle(_loc2_);
                  sfx.towerEffect(towerSound,ownerBuilding);
               }
            }
            else
            {
               disable();
            }
         }
         else
         {
            wait = 60;
         }
      }
      
      public function hit() : void
      {
         var _loc2_:Number = NaN;
         var _loc1_:Number = NaN;
         if(b.battleFieldControl.beast && numberOfBullets > 0)
         {
            var _loc3_:WorkerThread = b.battleFieldControl.beast.data.maxHealthPoint;
            _loc2_ = _loc3_._value;
            _loc1_ = _loc2_ * percentDamage / 100 * d;
            b.battleFieldControl.beast.underAttack.hit(_loc1_);
            numberOfBullets = numberOfBullets - 1;
            womRoot.cityInfo.beastCannonInfo.ammoAmount = numberOfBullets;
         }
      }
      
      public function freeze() : void
      {
         disable();
      }
      
      public function defreeze() : void
      {
         enable();
      }
   }
}

import peak.signal.Slot0;

class HitHandler implements Slot0
{
   
   public var owner:BeastCannon;
   
   public var x:Number;
   
   public var y:Number;
   
   public function HitHandler(param1:BeastCannon)
   {
      super();
      this.owner = param1;
   }
   
   public function onSignal0() : void
   {
      owner.hit();
   }
}
