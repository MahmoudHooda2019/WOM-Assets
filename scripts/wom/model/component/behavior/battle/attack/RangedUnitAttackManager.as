package wom.model.component.behavior.battle.attack
{
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.dto.Point3;
   import peak.util.ValidationRecorder;
   import peak.util.ValidationVerifier;
   import wom.model.component.WomGameRoot;
   import wom.model.component.behavior.ParticleManager;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.component.entity.gamesprite.Particle;
   import wom.model.component.entity.gamesprite.Unit;
   
   public class RangedUnitAttackManager extends UnitAttackManager
   {
      
      public var arrowThrower:Boolean = false;
      
      private var particleManager:ParticleManager;
      
      private var rotationGuide:Boolean;
      
      private var particleAssetId:String;
      
      public function RangedUnitAttackManager()
      {
         super();
      }
      
      override public function init() : void
      {
         super.init();
         var _loc1_:WomGameRoot = owner.root as WomGameRoot;
         particleManager = _loc1_.particleManager;
         particleAssetId = ownerUnit.data.typeDIO.particleAsset;
         rotationGuide = ownerUnit.data.typeDIO.particleRotate;
         if(ownerUnit.data.typeDIO.particleSound)
         {
            attackSound = sfx.assetRepository.getSoundAssetReference(ownerUnit.data.typeDIO.particleSound).soundAsset.sound;
         }
      }
      
      override public function update() : void
      {
         var _loc1_:Particle = null;
         wait.value -= sync.precise;
         var _loc2_:WorkerThread = wait;
         if(_loc2_._value > womRoot.zcmp._value)
         {
            return;
         }
         var _temp_5:* = wait;
         var _loc5_:WorkerThread = womRoot.uhwd;
         var _loc4_:WorkerThread = womRoot.bhwd;
         var _loc9_:Number = ownerUnit.data.isBeast && ownerUnit.data.typeDIO.id == 25 ? _loc4_._value : _loc5_._value;
         var _loc6_:WorkerThread = _temp_5;
         _loc6_._value = _loc9_;
         if(targetBuilding)
         {
            _loc1_ = new Particle(new Point3(ownerUnit.position.projected.x + ownerUnit.viewManager.middlePoint.x,ownerUnit.position.projected.y + ownerUnit.viewManager.middlePoint.y),targetBuilding.position.projected,new Point3(targetBuilding.data.buildingTypeDIO.baseSize * 5,-100),30,particleAssetId,rotationGuide,rotationGuide);
            _loc1_.hit.addOnce(new ParticleHitHandler(this,true,targetBuilding));
            particleManager.throwParticle(_loc1_);
         }
         else if(targetUnit)
         {
            _loc1_ = new Particle(new Point3(ownerUnit.position.projected.x + ownerUnit.viewManager.middlePoint.x,ownerUnit.position.projected.y + ownerUnit.viewManager.middlePoint.y),targetUnit.position.projected,new Point3(targetUnit.viewManager.middlePoint.x,targetUnit.viewManager.middlePoint.y),30,particleAssetId,rotationGuide,rotationGuide);
            _loc1_.hit.addOnce(new ParticleHitHandler(this,false,targetUnit));
            particleManager.throwParticle(_loc1_);
         }
      }
      
      public function particleHit(param1:Boolean, param2:GameSprite) : void
      {
         var _loc3_:Unit = null;
         if(param1)
         {
            hit.hitBuilding(param2 as Building);
         }
         else
         {
            _loc3_ = param2 as Unit;
            hit.hitUnit(_loc3_);
            if(!_loc3_ || !_loc3_.data || _loc3_.data.info.healthPoints <= 0)
            {
               ownerUnit.data.cluster.chooseTargetAndFight();
            }
         }
         sfx.unitAttack(attackSound,ownerUnit);
      }
   }
}

import peak.cuckoo.game.GameSprite;
import peak.signal.Slot0;

class ParticleHitHandler implements Slot0
{
   
   public var owner:RangedUnitAttackManager;
   
   public var building:Boolean;
   
   public var target:GameSprite;
   
   public function ParticleHitHandler(param1:RangedUnitAttackManager, param2:Boolean, param3:GameSprite)
   {
      super();
      this.owner = param1;
      this.building = param2;
      this.target = param3;
   }
   
   public function onSignal0() : void
   {
      owner.particleHit(building,target);
   }
}
