package wom.model.component.behavior.battle.tower
{
   import flash.media.Sound;
   import flash.utils.Dictionary;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.attribute.Position;
   import peak.cuckoo.game.attribute.projection.IsoOffsetProjection;
   import peak.cuckoo.game.attribute.view.AnimationAssetView;
   import peak.cuckoo.game.attribute.view.LoadingAssetView;
   import peak.cuckoo.game.behavior.animation.ActionAnimation;
   import peak.cuckoo.game.dto.Point3;
   import peak.util.ValidationRecorder;
   import peak.util.ValidationVerifier;
   import wom.model.component.WomGameRoot;
   import wom.model.component.attribute.SfxManager;
   import wom.model.component.attribute.data.BuildingData;
   import wom.model.component.behavior.ParticleManager;
   import wom.model.component.behavior.TowerAnimationManager;
   import wom.model.component.behavior.battle.BattleManager;
   import wom.model.component.behavior.catapult.CatapultAnimationFrame;
   import wom.model.component.entity.gamesprite.Particle;
   import wom.model.component.entity.gamesprite.Unit;
   import wom.model.component.structure.BattleField;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   
   public class BombardTower extends CatapultAnimationFrame implements FiringTower
   {
      
      private var buildingSpecificInfo:Dictionary;
      
      private var levelIndex:int;
      
      private var damage:Number;
      
      private var explosionRange:Number;
      
      private var battleFields:Array;
      
      public var particleManager:ParticleManager;
      
      private var reloadTime:Number;
      
      private const BOMB_VELOCITY:int = 30;
      
      private var towerAnimationManager:TowerAnimationManager;
      
      private var sfx:SfxManager;
      
      private var towerSound:Vector.<Sound> = new Vector.<Sound>();
      
      private var particleAssetId:String;
      
      public function BombardTower(param1:BattleManager, param2:Number)
      {
         super(param1,param2);
      }
      
      override public function init() : void
      {
         var _loc1_:WomGameRoot = owner.root as WomGameRoot;
         particleAssetId = "B32CannonBall";
         var _loc2_:BuildingData = owner.componentManager["BuildingData"] as BuildingData;
         levelIndex = _loc2_.buildingInfo.level == 0 ? 0 : _loc2_.buildingInfo.level - 1;
         buildingSpecificInfo = _loc2_.buildingTypeDIO.buildingSpecificInfo;
         towerAnimationManager = owner.componentManager["TowerAnimationManager"] as TowerAnimationManager;
         r = buildingSpecificInfo[BuildingSpecificInfoType.RANGES_PER_LEVEL_IN_PX.id][levelIndex] * 0.2;
         calculateDamage();
         explosionRange = buildingSpecificInfo[BuildingSpecificInfoType.EXPLOSION_RANGES_PER_LEVEL_IN_PX.id][levelIndex] / 5;
         battleFields = b.battleFieldControl.battleFields;
         super.init();
         particleManager = _loc1_.particleManager;
         reloadTime = buildingSpecificInfo[BuildingSpecificInfoType.RELOAD_TIME_IN_SECS.id] * 60;
         sfx = _loc1_.sfxManager;
         towerSound[0] = sfx.assetRepository.getSoundAssetReference("BombardTowerAttack1").soundAsset.sound;
         towerSound[1] = sfx.assetRepository.getSoundAssetReference("BombardTowerAttack2").soundAsset.sound;
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
            if(tu)
            {
               if(towerAnimationManager.turn(tu.position.point,this,tu))
               {
                  fire(tu);
               }
            }
            else
            {
               disable();
            }
         }
      }
      
      public function fire(param1:Unit) : void
      {
         if((!tu || !param1) && tu != param1)
         {
            return;
         }
         var _loc3_:Point3 = new Point3(tu.position.projected.x,tu.position.projected.y);
         var _loc2_:Particle = new Particle(new Point3(ownerBuilding.position.projected.x + 70,ownerBuilding.position.projected.y - 120),_loc3_,new Point3(tu.viewManager.middlePoint.x,tu.viewManager.middlePoint.y),30,particleAssetId,false,false);
         _loc2_.hit.add(new HitHandler(this,tu.position.point.x,tu.position.point.y));
         particleManager.throwParticle(_loc2_);
         sfx.towerEffect(towerSound[Math.random() * 4 > 1 ? 0 : 1],ownerBuilding);
         var _temp_4:* = rm;
         var _loc5_:WorkerThread;
         var _loc7_:Number = (_loc5_ = womRoot.tdrg)._value;
         var _loc6_:WorkerThread = _temp_4;
         _loc6_._value = _loc7_;
         reloadWait = reloadTime;
      }
      
      public function hit(param1:int, param2:int) : void
      {
         var _loc5_:int = 0;
         var _loc3_:Unit = null;
         createExplosionAnimation(param1,param2);
         var _loc4_:Vector.<Unit> = getTargetUnits(param1,param2,explosionRange);
         _loc5_ = _loc4_.length - 1;
         while(_loc5_ >= 0)
         {
            _loc3_ = _loc4_[_loc5_];
            _loc3_.underAttack.hit(damage);
            _loc5_--;
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
                     if(!_loc10_.data.typeDIO.flying)
                     {
                        _loc11_ = (_loc10_.position.point.x - param1) * (_loc10_.position.point.x - param1) + (_loc10_.position.point.y - param2) * (_loc10_.position.point.y - param2);
                        if(_loc11_ <= param3 * param3)
                        {
                           _loc13_.push(_loc10_);
                        }
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
      
      public function createExplosionAnimation(param1:int, param2:int) : void
      {
         var _loc6_:GameSprite = new GameSprite();
         var _loc5_:ActionAnimation = new womRoot.render.renderSpecificActionAnimation(5,57);
         _loc6_.componentManager.add(_loc5_);
         _loc6_.componentManager.add(_loc6_.view = new AnimationAssetView("B32Explosion",4));
         _loc6_.componentManager.add(_loc6_.position = new Position(new Point3(param1,param2)));
         var _loc7_:IsoOffsetProjection = new IsoOffsetProjection();
         _loc6_.componentManager.add(_loc7_);
         _loc5_.animationFinished.add(new AnimationFinishedHandler(womRoot,_loc6_));
         owner.root.addChild(_loc6_);
         _loc7_.offset = new Point3(-28,-55);
         _loc6_.init();
         _loc5_.setStartFrame(0);
         _loc5_.setStopFrame(7);
         owner.root.layers[4].add(_loc6_);
         _loc5_.startAnimation();
         var _loc4_:GameSprite = new GameSprite();
         _loc4_.componentManager.add(_loc4_.position = new Position(new Point3(param1,param2)));
         var _loc3_:IsoOffsetProjection = new IsoOffsetProjection();
         _loc4_.componentManager.add(_loc3_);
         _loc3_.offset = new Point3(-22,-23);
         _loc4_.componentManager.add(_loc4_.view = new LoadingAssetView(2,womRoot.assetRepository.getBitmapAssetReference("B32Crater"),"B32Crater"));
         womRoot.addChild(_loc4_);
         _loc4_.init();
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
         damage = buildingSpecificInfo[BuildingSpecificInfoType.DAMAGES_PER_SHOT_PER_LEVEL.id][levelIndex] * d;
      }
   }
}

import peak.cuckoo.game.GameSprite;
import peak.cuckoo.game.Root;
import peak.signal.Slot0;

class HitHandler implements Slot0
{
   
   public var owner:BombardTower;
   
   public var x:Number;
   
   public var y:Number;
   
   public function HitHandler(param1:BombardTower, param2:Number, param3:Number)
   {
      super();
      this.owner = param1;
      this.x = param2;
      this.y = param3;
   }
   
   public function onSignal0() : void
   {
      owner.hit(x,y);
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
