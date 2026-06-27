package wom.model.component.behavior.battle.attack
{
   import flash.media.Sound;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.attribute.Position;
   import peak.cuckoo.game.attribute.projection.IsoOffsetProjection;
   import peak.cuckoo.game.attribute.view.AnimationAssetView;
   import peak.cuckoo.game.attribute.view.LoadingAssetView;
   import peak.cuckoo.game.behavior.animation.ActionAnimation;
   import peak.cuckoo.game.dto.Point3;
   import peak.thread.WorkerThread;
   import peak.util.ValidationRecorder;
   import peak.util.ValidationVerifier;
   import wom.model.component.WomGameRoot;
   import wom.model.component.behavior.ParticleManager;
   import wom.model.component.behavior.battle.BattleFieldControl;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.component.entity.gamesprite.Particle;
   import wom.model.component.entity.gamesprite.Unit;
   import wom.model.component.structure.BattleField;
   
   public class SiegeTowerAttackManager extends UnitAttackManager
   {
      
      private const BOMB_VELOCITY:int = 30;
      
      private const EXPLOSION_RANGE:Number = 12;
      
      private var baseSize:int;
      
      private var iS:int;
      
      private var iF:int;
      
      private var jS:int;
      
      private var jF:int;
      
      private var bfc:BattleFieldControl;
      
      private var rangeSquare:Number;
      
      private var x:int;
      
      private var y:int;
      
      private var particleManager:ParticleManager;
      
      private var towerSound:Vector.<Sound> = new Vector.<Sound>();
      
      private var range:int;
      
      private var particleAssetId:String;
      
      public function SiegeTowerAttackManager(param1:int)
      {
         super();
         this.baseSize = param1;
         wait = new WorkerThread();
      }
      
      override public function init() : void
      {
         initialized = true;
         womRoot = owner.root as WomGameRoot;
         ownerUnit = owner as Unit;
         sync = womRoot.sync;
         bfc = womRoot.battleManager.battleFieldControl;
         hit = ownerUnit.hit;
         othersHitting = new Vector.<Unit>();
         range = ownerUnit.data.range;
         rangeSquare = range * range;
         x = ownerUnit.position.point.x;
         y = ownerUnit.position.point.y;
         iS = (x - range) / 10;
         iF = (x + range) / 10;
         jS = (y - range) / 10;
         jF = (y + range) / 10;
         if(iS < 0)
         {
            iS = iS - 1;
         }
         if(iF > 0)
         {
            iF = iF + 1;
         }
         if(jS < 0)
         {
            jS = jS - 1;
         }
         if(jF > 0)
         {
            jF = jF + 1;
         }
         particleManager = womRoot.particleManager;
         sfx = womRoot.sfxManager;
         towerSound[0] = sfx.assetRepository.getSoundAssetReference("BombardTowerAttack1").soundAsset.sound;
         towerSound[1] = sfx.assetRepository.getSoundAssetReference("BombardTowerAttack2").soundAsset.sound;
         particleAssetId = "B32CannonBall";
      }
      
      override public function update() : void
      {
         var _loc3_:Point3 = null;
         var _loc1_:Particle = null;
         var _loc2_:Point3 = null;
         wait.value -= sync.precise;
         var _loc4_:WorkerThread = wait;
         var _loc5_:WorkerThread;
         if(_loc4_._value > (_loc5_ = womRoot.zcmp)._value)
         {
            return;
         }
         var _temp_5:* = wait;
         var _loc6_:WorkerThread;
         var _loc9_:Number = (_loc6_ = womRoot.uhwd)._value;
         var _loc7_:WorkerThread = _temp_5;
         _loc7_._value = _loc9_;
         if(!targetBuilding || targetBuilding.data.buildingInfo.healthPoint <= 0)
         {
            targetBuilding = selectNearestBuilding();
         }
         if(targetBuilding)
         {
            _loc3_ = new Point3(targetBuilding.position.projected.x + targetBuilding.data.buildingTypeDIO.baseSize * 6,targetBuilding.position.projected.y - targetBuilding.data.buildingTypeDIO.baseSize * 3);
            _loc1_ = new Particle(new Point3(ownerUnit.position.projected.x + 30,ownerUnit.position.projected.y + 30),_loc3_,new Point3(),30,particleAssetId,false,false);
            _loc2_ = new Point3();
            womRoot.projection.reverse(_loc3_,_loc2_);
            _loc1_.hit.add(new HitHandler(this,_loc2_));
            particleManager.throwParticle(_loc1_);
            sfx.towerEffect(towerSound[Math.random() * 4 > 1 ? 0 : 1],ownerUnit);
         }
         else
         {
            disable();
            if(!womRoot.battleManager.battleFieldControl.checkAllBuildingsDestryoed())
            {
               womRoot.battleManager.battleFieldControl.checkAllUnitDied();
            }
         }
      }
      
      private function selectNearestBuilding() : Building
      {
         var _loc11_:int = 0;
         var _loc9_:int = 0;
         var _loc1_:BattleField = null;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc10_:int = 0;
         var _loc3_:Building = null;
         var _loc7_:Boolean = false;
         var _loc6_:Number = rangeSquare + 1000;
         var _loc8_:Building = null;
         _loc11_ = iS;
         while(_loc11_ <= iF)
         {
            _loc9_ = jS;
            while(_loc9_ <= jF)
            {
               _loc1_ = bfc.battleFields[(_loc11_ << 10) + (_loc9_ << 0)] as BattleField;
               if(_loc1_ && _loc1_.buildings)
               {
                  _loc5_ = _loc11_ * 10 - x;
                  _loc4_ = _loc9_ * 10 - y;
                  _loc2_ = _loc5_ * _loc5_ + _loc4_ * _loc4_;
                  if(_loc2_ < rangeSquare)
                  {
                     _loc10_ = 0;
                     for(; _loc10_ < _loc1_.buildings.length; _loc10_++)
                     {
                        _loc3_ = _loc1_.buildings[_loc10_];
                        if(!_loc3_.data.buildingTypeDIO.indestructable)
                        {
                           if(_loc6_ > _loc2_)
                           {
                              if(_loc7_)
                              {
                                 if(!("TowerDefense" in _loc3_.componentManager))
                                 {
                                    continue;
                                 }
                                 _loc6_ = _loc2_;
                                 _loc8_ = _loc3_;
                              }
                              else
                              {
                                 _loc6_ = _loc2_;
                                 _loc8_ = _loc3_;
                                 _loc7_ = "TowerDefense" in _loc3_.componentManager;
                              }
                           }
                           else if(!_loc7_ && "TowerDefense" in _loc3_.componentManager)
                           {
                              _loc6_ = _loc2_;
                              _loc8_ = _loc3_;
                              _loc7_ = true;
                           }
                        }
                     }
                  }
               }
               _loc9_++;
            }
            _loc11_++;
         }
         return _loc8_;
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
         womRoot.addChild(_loc6_);
         _loc7_.offset = new Point3(-28,-55);
         _loc6_.init();
         _loc5_.setStartFrame(0);
         _loc5_.setStopFrame(7);
         womRoot.layers[4].add(_loc6_);
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
      
      override public function stopAttackBuilding(param1:Boolean = false) : void
      {
      }
      
      override public function defendYourself(param1:Unit = null) : void
      {
      }
      
      override public function startAttackBuilding(param1:Building) : void
      {
      }
      
      override public function retreatAttack() : void
      {
      }
      
      override public function enemyUnitDied(param1:Unit) : void
      {
      }
   }
}

import peak.cuckoo.game.GameSprite;
import peak.cuckoo.game.Root;
import peak.cuckoo.game.dto.Point3;
import peak.signal.Slot0;

class HitHandler implements Slot0
{
   
   public var owner:SiegeTowerAttackManager;
   
   public var x:Number;
   
   public var y:Number;
   
   public function HitHandler(param1:SiegeTowerAttackManager, param2:Point3)
   {
      super();
      this.owner = param1;
      this.x = param2.x;
      this.y = param2.y;
   }
   
   public function onSignal0() : void
   {
      owner.createExplosionAnimation(x,y);
      owner.hit.hit(x,y);
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
