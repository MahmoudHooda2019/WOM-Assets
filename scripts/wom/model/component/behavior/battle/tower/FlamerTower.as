package wom.model.component.behavior.battle.tower
{
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.media.Sound;
   import flash.utils.Dictionary;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.attribute.Position;
   import peak.cuckoo.game.attribute.view.AnimationAssetView;
   import peak.cuckoo.game.behavior.Validator;
   import peak.cuckoo.game.behavior.animation.ActionAnimation;
   import peak.cuckoo.game.dto.Point3;
   import peak.resource.atlas.starling.StarlingAtlasReference;
   import peak.util.ValidationRecorder;
   import peak.util.ValidationVerifier;
   import wom.model.component.WomGameRoot;
   import wom.model.component.attribute.SfxManager;
   import wom.model.component.attribute.data.BuildingData;
   import wom.model.component.behavior.battle.BattleManager;
   import wom.model.component.behavior.catapult.CatapultAnimationFrame;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.component.entity.gamesprite.Unit;
   import wom.model.component.structure.BattleField;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   
   public class FlamerTower extends CatapultAnimationFrame
   {
      
      public static const READY:int = 0;
      
      public static const GROWING:int = 1;
      
      public static const LOOPING:int = 2;
      
      public static const SHRINKING:int = 3;
      
      public static const UPDATES_PER_DAMAGE:Number = 5;
      
      private static var _rotationCenterPoint:Point = new Point(-57,0);
      
      private var buildingSpecificInfo:Dictionary;
      
      private var levelIndex:int;
      
      private var damage:Number;
      
      private var explosionRange:Number;
      
      private var battleFields:Array;
      
      private var validator:Validator;
      
      public var actionAnimation:ActionAnimation;
      
      private var reloadTime:Number;
      
      private var loopTime:Number;
      
      public var state:int;
      
      public var flameSprite:GameSprite;
      
      public var wait:int = 0;
      
      public var damageWait:Number;
      
      public var cumulativeDamage:Number;
      
      public var targetX:Number;
      
      public var targetY:Number;
      
      private var sfx:SfxManager;
      
      private var towerSound:Sound;
      
      private var flameSpriteWidth:int;
      
      private var flameSpriteHeight:int;
      
      private var reference:StarlingAtlasReference;
      
      public function FlamerTower(param1:BattleManager, param2:Number)
      {
         super(param1,param2);
      }
      
      public function cacheOriginalFrames() : void
      {
      }
      
      override public function init() : void
      {
         actionAnimation = new owner.root.render.renderSpecificActionAnimation(4,114);
         owner.componentManager.add(actionAnimation);
         actionAnimation.init();
         reference = owner.root.atlasManager.getAtlasReference("B33Animation-0");
         flameSpriteWidth = reference.atlasWidth;
         flameSpriteHeight = reference.atlasHeight;
         validator = owner.root.validator;
         flameSprite = new GameSprite();
         flameSprite.componentManager.add(actionAnimation);
         var _loc2_:AnimationAssetView = new AnimationAssetView("B33Animation",4,true);
         _loc2_.assetLoaded.addFunctionOnce(cacheOriginalFrames);
         flameSprite.componentManager.add(flameSprite.view = _loc2_);
         flameSprite.componentManager.add(flameSprite.position = new Position(new Point3()));
         (owner.root as WomGameRoot).addChild(flameSprite);
         flameSprite.init();
         var _loc1_:BuildingData = (owner as Building).data;
         buildingSpecificInfo = _loc1_.buildingTypeDIO.buildingSpecificInfo;
         levelIndex = _loc1_.buildingInfo.level == 0 ? 0 : _loc1_.buildingInfo.level - 1;
         explosionRange = buildingSpecificInfo[BuildingSpecificInfoType.EXPLOSION_RANGES_PER_LEVEL_IN_PX.id][levelIndex] / 5;
         r = buildingSpecificInfo[BuildingSpecificInfoType.RANGES_PER_LEVEL_IN_PX.id][levelIndex] / 5;
         calculateDamage();
         battleFields = b.battleFieldControl.battleFields;
         super.init();
         reloadTime = 60;
         loopTime = 90;
         state = 0;
         sfx = womRoot.sfxManager;
         towerSound = sfx.assetRepository.getSoundAssetReference("FlamerTowerAttack").soundAsset.sound;
      }
      
      public function fireStopped() : void
      {
         owner.root.layers[4].remove(flameSprite);
         state = 0;
         var _temp_2:* = rm;
         var _loc3_:Number = womRoot.tdrg._value;
         var _loc2_:WorkerThread = _temp_2;
         _loc2_._value = _loc3_;
         reloadWait = reloadTime;
         wait = 0;
      }
      
      override public function startAttack() : void
      {
         tu.underAttack.startTowerUnderAttack(ownerBuilding);
         enable();
      }
      
      override public function update() : void
      {
         var _loc3_:Point3 = null;
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         super.update();
         var _loc4_:WorkerThread = rm;
         var _loc5_:WorkerThread;
         if(_loc4_._value == (_loc5_ = womRoot.tdrd)._value)
         {
            wait -= sync.precise;
            if(state == 0)
            {
               var _loc6_:WorkerThread = tm;
               var _loc7_:WorkerThread;
               if(_loc6_._value == (_loc7_ = womRoot.tda)._value)
               {
                  _loc3_ = ownerBuilding.position.projected;
                  _loc2_ = _loc3_.x + 75;
                  _loc1_ = _loc3_.y - 90;
                  targetX = tu.position.point.x;
                  targetY = tu.position.point.y;
                  startFire(_loc2_,_loc1_,tu.position.projected.x + tu.viewManager.middlePoint.x,tu.position.projected.y + tu.viewManager.middlePoint.y);
                  startGrowing();
                  sfx.towerEffect(towerSound,ownerBuilding);
               }
               else
               {
                  disable();
               }
            }
            else if(state == 2)
            {
               damageWait -= sync.precise;
               cumulativeDamage += damage * sync.precise / 5;
               if(damageWait <= 0)
               {
                  hit(targetX,targetY,cumulativeDamage);
                  cumulativeDamage = 0;
                  damageWait = 5;
               }
               if(wait <= 0)
               {
                  startShrinking();
               }
            }
         }
      }
      
      public function hit(param1:int, param2:int, param3:Number) : void
      {
         var _loc5_:int = 0;
         var _loc4_:Vector.<Unit> = getTargetUnits(param1,param2,explosionRange);
         _loc5_ = _loc4_.length - 1;
         while(_loc5_ >= 0)
         {
            _loc4_[_loc5_].underAttack.hit(param3);
            _loc5_--;
         }
      }
      
      public function isFiring() : Boolean
      {
         return state == 1 || state == 2 || state == 3;
      }
      
      override public function stopAttack(param1:Boolean = true) : void
      {
         super.stopAttack(param1);
      }
      
      override public function calculateDamage() : void
      {
         damage = buildingSpecificInfo[BuildingSpecificInfoType.DAMAGES_PER_SHOT_PER_LEVEL.id][levelIndex] * d;
      }
      
      public function rotateFrames(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc5_:int = reference.height;
      }
      
      public function startFire(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc16_:Number = reference.width - 1;
         var _loc7_:Number = param3 - param1;
         var _loc8_:Number = param2 - param4;
         var _loc5_:Number = _loc7_ == 0 ? 0 : _loc7_ / Math.abs(_loc7_);
         var _loc9_:Number = _loc8_ == 0 ? 0 : -_loc8_ / Math.abs(_loc8_);
         var _loc6_:Number = Math.atan(_loc8_ / _loc7_);
         if(_loc5_ == -1)
         {
            _loc6_ += 3.141592653589793;
         }
         else if(_loc9_ == 1)
         {
            _loc6_ += 2 * 3.141592653589793;
         }
         var _loc15_:Number = _loc16_ * Math.cos(_loc6_);
         var _loc14_:Number = -_loc16_ * Math.sin(_loc6_);
         var _loc13_:Number = _loc15_ < 0 ? _loc15_ : 0;
         var _loc17_:Number = _loc14_ < 0 ? _loc14_ : 0;
         var _loc12_:Matrix = new Matrix();
         _loc12_.translate(reference.width / 2,0);
         _loc12_.rotate(-_loc6_);
         _loc12_.translate(-reference.width / 2,0);
         _loc12_.translate(_loc16_ + _loc16_ / 2 + _loc15_ / 3,_loc16_ + _loc16_ / 2 + _loc14_ / 3 - reference.height / 2);
         actionAnimation.setForward(true);
         actionAnimation.setMatrix(_loc12_);
         var _loc11_:int = param1 - 3 * _loc16_ / 2;
         var _loc10_:int = param2 - 3 * _loc16_ / 2;
         flameSprite.position.projected.x = _loc11_;
         flameSprite.position.projected.y = _loc10_;
         owner.root.layers[4].add(flameSprite);
         validator.add(flameSprite);
      }
      
      public function startGrowing() : void
      {
         if(!actionAnimation || !actionAnimation.owner)
         {
            init();
         }
         actionAnimation.setFrame(0);
         actionAnimation.setStopFrame(2);
         actionAnimation.loop = false;
         actionAnimation.fpsChangeRate = 4;
         actionAnimation.animationFinished.addFunctionOnce(startLooping);
         actionAnimation.startAnimation();
         state = 1;
      }
      
      public function startLooping() : void
      {
         damageWait = 5;
         cumulativeDamage = 0;
         actionAnimation.setStartFrame(2);
         actionAnimation.setStopFrame(3);
         actionAnimation.loop = true;
         actionAnimation.fpsChangeRate = 5;
         actionAnimation.startAnimation();
         state = 2;
         wait = loopTime;
      }
      
      public function startShrinking() : void
      {
         actionAnimation.setStopFrame(6);
         actionAnimation.loop = false;
         actionAnimation.fpsChangeRate = 4;
         actionAnimation.animationFinished.addFunctionOnce(fireStopped);
         actionAnimation.startAnimation();
         state = 3;
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
      
      override public function towerDestroyed() : void
      {
         super.towerDestroyed();
         startShrinking();
      }
   }
}

