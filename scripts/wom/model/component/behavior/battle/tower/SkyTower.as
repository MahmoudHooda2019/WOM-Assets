package wom.model.component.behavior.battle.tower
{
   import flash.media.Sound;
   import flash.utils.Dictionary;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.attribute.Position;
   import peak.cuckoo.game.attribute.projection.IsoOffsetProjection;
   import peak.cuckoo.game.attribute.view.AnimationAssetView;
   import peak.cuckoo.game.behavior.animation.ActionAnimation;
   import peak.cuckoo.game.dto.Point3;
   import peak.util.ValidationRecorder;
   import peak.util.ValidationVerifier;
   import wom.model.component.attribute.SfxManager;
   import wom.model.component.attribute.data.BuildingData;
   import wom.model.component.behavior.ParticleManager;
   import wom.model.component.behavior.TowerAnimationManager;
   import wom.model.component.behavior.battle.BattleManager;
   import wom.model.component.entity.gamesprite.Particle;
   import wom.model.component.entity.gamesprite.Unit;
   import wom.model.component.structure.BattleField;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   
   public class SkyTower extends TowerDefense implements FiringTower
   {
      
      public static const RANDOM_RADIUS:Number = 100;
      
      private var buildingSpecificInfo:Dictionary;
      
      private var levelIndex:int;
      
      private var damage:Number;
      
      private var explosionRange:Number;
      
      private var battleFields:Array;
      
      public var particleManager:ParticleManager;
      
      private var totalWait:Number;
      
      private var attackPeriod:Number;
      
      private var wait:Number;
      
      private var shotsFired:int;
      
      private var shotsFiredPerCharge:int;
      
      private var attackStarted:Boolean;
      
      private var periodStarted:Boolean;
      
      private const ARROW_VELOCITY:int = 30;
      
      private const WAIT_BETWEEN_SHOTS:int = 10;
      
      private var towerAnimationManager:TowerAnimationManager;
      
      private var sfx:SfxManager;
      
      private var towerSound:Sound;
      
      private var particleAssetId:String;
      
      public function SkyTower(param1:BattleManager, param2:Number)
      {
         super(param1,param2);
      }
      
      override public function init() : void
      {
         particleAssetId = "Arrow1";
         var _loc1_:BuildingData = owner.componentManager["BuildingData"] as BuildingData;
         levelIndex = _loc1_.buildingInfo.level == 0 ? 0 : _loc1_.buildingInfo.level - 1;
         buildingSpecificInfo = _loc1_.buildingTypeDIO.buildingSpecificInfo;
         towerAnimationManager = owner.componentManager["TowerAnimationManager"] as TowerAnimationManager;
         r = buildingSpecificInfo[BuildingSpecificInfoType.RANGES_PER_LEVEL_IN_PX.id][levelIndex] / 5;
         shotsFiredPerCharge = buildingSpecificInfo[BuildingSpecificInfoType.SHOTS_FIRED_PER_CHARGE_PER_LEVEL.id][levelIndex];
         calculateDamage();
         explosionRange = buildingSpecificInfo[BuildingSpecificInfoType.EXPLOSION_RANGES_PER_LEVEL_IN_PX.id][levelIndex];
         battleFields = b.battleFieldControl.battleFields;
         super.init();
         particleManager = womRoot.particleManager;
         attackPeriod = buildingSpecificInfo[BuildingSpecificInfoType.RELOAD_TIME_IN_SECS.id] * 60;
         shotsFired = 0;
         wait = 0;
         attackStarted = false;
         periodStarted = false;
         sfx = womRoot.sfxManager;
         towerSound = sfx.assetRepository.getSoundAssetReference("SkyTowerAttack").soundAsset.sound;
      }
      
      override public function startAttack() : void
      {
         tu.underAttack.startTowerUnderAttack(ownerBuilding);
         enable();
      }
      
      override public function update() : void
      {
         super.update();
         var _loc1_:WorkerThread = rm;
         if(_loc1_._value == womRoot.tdrd._value)
         {
            totalWait -= sync.precise;
            if(!periodStarted)
            {
               periodStarted = true;
               totalWait = attackPeriod;
            }
            if(tu)
            {
               wait -= sync.elapsed;
               if(wait <= 0)
               {
                  if(attackStarted)
                  {
                     towerAnimationManager.immediateTurn(tu.position.point);
                     fire(tu);
                  }
                  else if(towerAnimationManager.turn(tu.position.point,this,tu))
                  {
                     fire(tu);
                  }
               }
            }
            else
            {
               var _temp_5:* = rm;
               var _loc5_:Number = womRoot.tdrg._value;
               var _loc4_:WorkerThread = _temp_5;
               _loc4_._value = _loc5_;
               reloadWait = totalWait;
               wait = 0;
               attackStarted = false;
               periodStarted = false;
               shotsFired = 0;
            }
         }
      }
      
      public function fire(param1:Unit) : void
      {
         var _loc2_:Particle = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if((!tu || !param1) && tu != param1)
         {
            return;
         }
         attackStarted = true;
         _loc3_ = 100 * (2 * womRoot.pseudoRandomGenerator.nextDouble() - 1);
         _loc4_ = 100 * (2 * womRoot.pseudoRandomGenerator.nextDouble() - 1);
         _loc2_ = new Particle(new Point3(ownerBuilding.position.projected.x + 70,ownerBuilding.position.projected.y - 120),new Point3(tu.position.projected.x,tu.position.projected.y,0),new Point3(tu.viewManager.middlePoint.x / 2 + _loc3_,tu.viewManager.middlePoint.y / 2 + _loc4_),30,particleAssetId,true,false);
         _loc2_.hit.add(new HitHandler(this,tu.position.point.x,tu.position.point.y,tu.position.point.z));
         particleManager.throwParticle(_loc2_);
         sfx.towerEffect(towerSound,ownerBuilding);
         wait = 10;
         shotsFired = shotsFired + 1;
         if(shotsFired >= shotsFiredPerCharge)
         {
            var _temp_7:* = rm;
            var _loc6_:WorkerThread;
            var _loc8_:Number = (_loc6_ = womRoot.tdrg)._value;
            var _loc7_:WorkerThread = _temp_7;
            _loc7_._value = _loc8_;
            reloadWait = totalWait;
            periodStarted = false;
            wait = 0;
            attackStarted = false;
            shotsFired = 0;
         }
      }
      
      public function hit(param1:int, param2:int, param3:int) : void
      {
         var _loc6_:int = 0;
         var _loc4_:Unit = null;
         createExplosionAnimation(param1,param2,param3);
         var _loc5_:Vector.<Unit> = getTargetUnits(param1,param2,explosionRange);
         _loc6_ = _loc5_.length - 1;
         while(_loc6_ >= 0)
         {
            _loc4_ = _loc5_[_loc6_];
            if(_loc4_.data.typeDIO.flying)
            {
               _loc4_.underAttack.hit(damage);
            }
            _loc6_--;
         }
      }
      
      private function getTargetUnits(param1:Number, param2:Number, param3:Number) : Vector.<Unit>
      {
         var _loc9_:* = 0;
         var _loc8_:* = 0;
         var _loc6_:int = 0;
         var _loc15_:BattleField = null;
         var _loc14_:int = 0;
         var _loc10_:Unit = null;
         var _loc11_:Number = NaN;
         var _loc13_:Vector.<Unit> = new Vector.<Unit>();
         var _loc4_:int = (param1 - param3) / 10;
         var _loc7_:int = (param1 + param3) / 10;
         var _loc5_:int = (param2 - param3) / 10;
         var _loc12_:int = (param2 + param3) / 10;
         if(_loc4_ < 0)
         {
            _loc4_--;
         }
         if(_loc7_ > 0)
         {
            _loc7_++;
         }
         if(_loc5_ < 0)
         {
            _loc5_--;
         }
         if(_loc12_ > 0)
         {
            _loc12_++;
         }
         _loc9_ = _loc4_;
         while(_loc9_ <= _loc7_)
         {
            _loc8_ = _loc5_;
            while(_loc8_ <= _loc12_)
            {
               _loc6_ = (_loc9_ << 10) + (_loc8_ << 0);
               _loc15_ = battleFields[_loc6_];
               if(_loc15_)
               {
                  _loc14_ = 0;
                  while(_loc14_ < _loc15_.units.length)
                  {
                     _loc10_ = _loc15_.units[_loc14_];
                     _loc11_ = (_loc10_.position.point.x - param1) * (_loc10_.position.point.x - param1) + (_loc10_.position.point.y - param2) * (_loc10_.position.point.y - param2);
                     if(_loc11_ <= param3 * param3)
                     {
                        _loc13_.push(_loc10_);
                     }
                     _loc14_++;
                  }
               }
               _loc8_++;
            }
            _loc9_++;
         }
         return _loc13_;
      }
      
      public function createExplosionAnimation(param1:int, param2:int, param3:int) : void
      {
         var _loc5_:GameSprite = new GameSprite();
         var _loc4_:ActionAnimation = new womRoot.render.renderSpecificActionAnimation(5,64);
         _loc5_.componentManager.add(_loc4_);
         _loc5_.componentManager.add(_loc5_.view = new AnimationAssetView("Explosion2",4));
         _loc5_.componentManager.add(_loc5_.position = new Position(new Point3(param1 + (Math.random() * 10 - 5 << 0),param2 + (Math.random() * 10 - 5 << 0),param3)));
         var _loc6_:IsoOffsetProjection = new IsoOffsetProjection();
         _loc5_.componentManager.add(_loc6_);
         _loc4_.animationFinished.add(new AnimationFinishedHandler(womRoot,_loc5_));
         owner.root.addChild(_loc5_);
         _loc6_.offset = new Point3(-32,-32);
         _loc4_.setStartFrame(0);
         _loc4_.setStopFrame(3);
         _loc5_.init();
         owner.root.layers[4].add(_loc5_);
         _loc4_.startAnimation();
      }
      
      public function removeExplosion(param1:GameSprite) : void
      {
         owner.root.destroyChild(param1);
         owner.root.layers[4].remove(param1);
      }
      
      override public function stopAttack(param1:Boolean = true) : void
      {
         super.stopAttack(param1);
         towerAnimationManager.exitAttackMode();
      }
      
      override public function calculateDamage() : void
      {
         var _loc2_:BuildingData = owner.componentManager["BuildingData"] as BuildingData;
         var _loc1_:int = _loc2_.buildingInfo.level == 0 ? 0 : _loc2_.buildingInfo.level - 1;
         damage = _loc2_.buildingTypeDIO.buildingSpecificInfo[BuildingSpecificInfoType.DAMAGES_PER_SHOT_PER_LEVEL.id][_loc1_] * d;
      }
   }
}

import peak.cuckoo.game.GameSprite;
import peak.cuckoo.game.Root;
import peak.signal.Slot0;

class HitHandler implements Slot0
{
   
   public var owner:SkyTower;
   
   public var x:Number;
   
   public var y:Number;
   
   public var z:Number;
   
   public function HitHandler(param1:SkyTower, param2:Number, param3:Number, param4:Number)
   {
      super();
      this.owner = param1;
      this.x = param2;
      this.y = param3;
      this.z = param4;
   }
   
   public function onSignal0() : void
   {
      owner.hit(x,y,z);
   }
}

class AnimationFinishedHandler implements Slot0
{
   
   public var womRoot:Root;
   
   public var explosion:GameSprite;
   
   public function AnimationFinishedHandler(param1:Root, param2:GameSprite)
   {
      super();
      this.womRoot = param1;
      this.explosion = param2;
   }
   
   public function onSignal0() : void
   {
      womRoot.layers[4].remove(explosion);
      womRoot.destroyChild(explosion);
   }
}
