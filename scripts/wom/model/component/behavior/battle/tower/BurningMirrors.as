package wom.model.component.behavior.battle.tower
{
   import flash.media.Sound;
   import flash.utils.Dictionary;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.attribute.Position;
   import peak.cuckoo.game.attribute.bounds.compositeBased.CompositeChildRenderBounds;
   import peak.cuckoo.game.attribute.projection.IsoProjection;
   import peak.cuckoo.game.attribute.view.AnimationAssetView;
   import peak.cuckoo.game.attribute.view.CompositeView;
   import peak.cuckoo.game.behavior.Validator;
   import peak.cuckoo.game.behavior.animation.ActionAnimation;
   import peak.cuckoo.game.behavior.sort.ZSort;
   import peak.cuckoo.game.dto.Point3;
   import peak.util.ValidationRecorder;
   import peak.util.ValidationVerifier;
   import wom.model.component.WomGameRoot;
   import wom.model.component.attribute.SfxManager;
   import wom.model.component.attribute.data.BuildingData;
   import wom.model.component.attribute.data.Laser;
   import wom.model.component.attribute.projection.HeightRevertedBuildingPartProjectionDeprecated;
   import wom.model.component.behavior.LineAnimationManager;
   import wom.model.component.behavior.TowerAnimationManager;
   import wom.model.component.behavior.battle.BattleManager;
   import wom.model.component.behavior.catapult.CatapultAnimationFrame;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.component.entity.gamesprite.Unit;
   import wom.model.component.structure.BattleField;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   
   public class BurningMirrors extends CatapultAnimationFrame implements FiringTower
   {
      
      private var buildingSpecificInfo:Dictionary;
      
      private var levelIndex:int;
      
      private var compositeView:CompositeView;
      
      private var damage:Number;
      
      private var battleFields:Array;
      
      private const LASER_THICKNESS:Number = 2;
      
      private var laserManager:LineAnimationManager;
      
      private var remainingWait:Number;
      
      private var attackPeriod:Number;
      
      private var periodStarted:Boolean;
      
      private var maxX:Number;
      
      private var maxY:Number;
      
      private var rootISOProjection:IsoProjection;
      
      private const VIEWPORT_BOUND_MODIFIER:int = 2;
      
      private var towerAnimationManager:TowerAnimationManager;
      
      private var lightSourceSprite:GameSprite;
      
      public var actionAnimation:ActionAnimation;
      
      public var laser:Laser;
      
      private var validator:Validator;
      
      private var LASER_THICKNESS_SQUARE:Number;
      
      private var FORMULE_DIVIDER:Number;
      
      private var FORMULE_DIFF_Y:Number;
      
      private var FORMULE_DIFF_X:Number;
      
      private var sfx:SfxManager;
      
      private var towerSound:Sound;
      
      public function BurningMirrors(param1:BattleManager, param2:Number)
      {
         super(param1,param2);
      }
      
      override public function init() : void
      {
         ownerBuilding = owner as Building;
         actionAnimation = new owner.root.render.renderSpecificActionAnimation(4,36);
         owner.componentManager.add(actionAnimation);
         actionAnimation.init();
         validator = owner.root.validator;
         lightSourceSprite = new GameSprite();
         lightSourceSprite.componentManager.add(actionAnimation);
         var _loc1_:AnimationAssetView = new AnimationAssetView("LightSource",3);
         lightSourceSprite.componentManager.add(lightSourceSprite.view = _loc1_);
         lightSourceSprite.componentManager.add(lightSourceSprite.position = new Position(new Point3()));
         lightSourceSprite.componentManager.add(lightSourceSprite.bounds = new CompositeChildRenderBounds());
         lightSourceSprite.componentManager.add(new HeightRevertedBuildingPartProjectionDeprecated());
         lightSourceSprite.composite = ownerBuilding;
         lightSourceSprite.position.point.x = 50;
         lightSourceSprite.position.point.y = 65;
         owner.addChild(lightSourceSprite);
         lightSourceSprite.init();
         var _loc2_:BuildingData = owner.componentManager["BuildingData"] as BuildingData;
         levelIndex = _loc2_.buildingInfo.level == 0 ? 0 : _loc2_.buildingInfo.level - 1;
         buildingSpecificInfo = _loc2_.buildingTypeDIO.buildingSpecificInfo;
         laserManager = (owner.root as WomGameRoot).lineAnimationManager;
         towerAnimationManager = owner.componentManager["TowerAnimationManager"] as TowerAnimationManager;
         r = buildingSpecificInfo[BuildingSpecificInfoType.RANGES_PER_LEVEL_IN_PX.id][levelIndex] / 5;
         calculateDamage();
         battleFields = b.battleFieldControl.battleFields;
         attackPeriod = buildingSpecificInfo[BuildingSpecificInfoType.RELOAD_TIME_IN_SECS.id] * 60;
         super.init();
         rootISOProjection = womRoot.projection as IsoProjection;
         maxX = 2 * owner.root.viewport.bounds.right / rootISOProjection.pitchX;
         maxY = 2 * owner.root.viewport.bounds.bottom / rootISOProjection.pitchY;
         sfx = womRoot.sfxManager;
         towerSound = sfx.assetRepository.getSoundAssetReference("BurningMirrorsAttack").soundAsset.sound;
         compositeView = ownerBuilding.view as CompositeView;
      }
      
      override public function startAttack() : void
      {
         tu.underAttack.startTowerUnderAttack(owner as Building);
         enable();
      }
      
      override public function update() : void
      {
         super.update();
         var _loc1_:WorkerThread = rm;
         if(_loc1_._value == womRoot.tdrd._value)
         {
            remainingWait -= sync.precise;
            if(tu)
            {
               if(!periodStarted)
               {
                  periodStarted = true;
                  remainingWait = attackPeriod;
               }
               if(towerAnimationManager.turn(tu.position.point,this,tu))
               {
                  fire(tu);
               }
            }
            else
            {
               var _temp_4:* = rm;
               var _loc5_:Number = womRoot.tdrg._value;
               var _loc4_:WorkerThread = _temp_4;
               _loc4_._value = _loc5_;
               reloadWait = remainingWait;
               periodStarted = false;
            }
         }
      }
      
      public function fire(param1:Unit) : void
      {
         var laserStartX:Number;
         var laserStartY:Number;
         var laserEndX:Number;
         var laserEndY:Number;
         var x1:Number;
         var y1:Number;
         var xDiff:Number;
         var yDiff:Number;
         var xDirection:int;
         var yDirection:int;
         var tangent:Number;
         var possibleY:Number;
         var lineStart:Point3;
         var lineEnd:Point3;
         var unit:Unit = param1;
         if((!tu || !unit) && tu != unit)
         {
            return;
         }
         laserStartX = position.x;
         laserStartY = position.y;
         x1 = tu.position.point.x;
         y1 = tu.position.point.y;
         xDiff = x1 - laserStartX;
         yDiff = y1 - laserStartY;
         xDirection = xDiff > 0 ? 1 : (xDiff < 0 ? -1 : 0);
         yDirection = yDiff > 0 ? 1 : (yDiff < 0 ? -1 : 0);
         if(xDirection != 0)
         {
            tangent = yDiff / xDiff;
            possibleY = laserStartY + tangent * (maxX * xDirection - laserStartX);
            if(possibleY * possibleY <= maxY * maxY)
            {
               laserEndX = maxX * xDirection;
               laserEndY = possibleY;
            }
            else
            {
               laserEndY = maxY * yDirection;
               laserEndX = (laserEndY - laserStartY) / tangent + laserStartX;
            }
         }
         else
         {
            laserEndX = laserStartX;
            laserEndY = yDirection * maxY;
         }
         lineStart = new Point3();
         lineEnd = new Point3();
         rootISOProjection.transform(new Point3(laserStartX,laserStartY),lineStart);
         rootISOProjection.transform(new Point3(laserEndX,laserEndY),lineEnd);
         lineStart.y -= 50;
         laser = new Laser(ownerBuilding,laserManager,lineStart,lineEnd);
         startGrowing();
         sfx.towerEffect(towerSound,ownerBuilding);
         laser.hit.addFunctionOnce(function():void
         {
            hit(laserStartX,laserStartY,laserEndX,laserEndY);
         });
         laser.shrink.addFunctionOnce(startShrinking);
         laserManager.newLine(laser);
         var _temp_23:* = rm;
         var _loc5_:Number = womRoot.tdrg._value;
         var _loc4_:WorkerThread = _temp_23;
         _loc4_._value = _loc5_;
         reloadWait = remainingWait;
         periodStarted = false;
      }
      
      public function hit(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         var _loc16_:int = 0;
         var _loc12_:int = 0;
         var _loc5_:int = 0;
         var _loc22_:BattleField = null;
         var _loc18_:BattleField = null;
         var _loc20_:Unit = null;
         var _loc13_:Boolean = false;
         var _loc14_:int = param1 / 10 << 0;
         var _loc9_:int = param2 / 10 << 0;
         var _loc17_:int = param3 / 10 << 0;
         var _loc11_:int = param4 / 10 << 0;
         var _loc7_:int = _loc17_ > _loc14_ ? _loc17_ - _loc14_ : _loc14_ - _loc17_;
         var _loc8_:int = _loc11_ > _loc9_ ? _loc11_ - _loc9_ : _loc9_ - _loc11_;
         var _loc24_:int = _loc14_;
         var _loc23_:int = _loc9_;
         var _loc10_:int = 1 + _loc7_ + _loc8_;
         var _loc19_:int = _loc17_ > _loc14_ ? 1 : -1;
         var _loc21_:int = _loc11_ > _loc9_ ? 1 : -1;
         var _loc6_:int = _loc7_ - _loc8_;
         _loc7_ <<= 1;
         _loc8_ <<= 1;
         var _loc15_:Vector.<BattleField> = new Vector.<BattleField>();
         while(_loc10_ > 0)
         {
            _loc16_ = _loc24_ - 1;
            while(_loc16_ <= _loc24_ + 1)
            {
               _loc12_ = _loc23_ - 1;
               while(_loc12_ <= _loc23_ + 1)
               {
                  _loc5_ = (_loc16_ << 10) + _loc12_;
                  _loc22_ = battleFields[_loc5_];
                  if(_loc22_ != null)
                  {
                     if(_loc15_.indexOf(_loc22_) == -1)
                     {
                        _loc15_.push(_loc22_);
                     }
                  }
                  _loc12_++;
               }
               _loc16_++;
            }
            if(_loc6_ > 0)
            {
               _loc24_ += _loc19_;
               _loc6_ -= _loc8_;
            }
            else if(_loc6_ < 0)
            {
               _loc23_ += _loc21_;
               _loc6_ += _loc7_;
            }
            else
            {
               _loc24_ += _loc19_;
               _loc6_ -= _loc8_;
               _loc23_ += _loc21_;
               _loc6_ += _loc7_;
               _loc10_--;
            }
            _loc10_--;
         }
         LASER_THICKNESS_SQUARE = 2 * 2;
         FORMULE_DIFF_Y = param4 - param2;
         FORMULE_DIFF_X = param3 - param1;
         FORMULE_DIVIDER = FORMULE_DIFF_X * FORMULE_DIFF_X + FORMULE_DIFF_Y * FORMULE_DIFF_Y;
         _loc16_ = 0;
         while(_loc16_ < _loc15_.length)
         {
            _loc18_ = _loc15_[_loc16_];
            _loc12_ = _loc18_.units.length - 1;
            while(_loc12_ >= 0)
            {
               _loc20_ = _loc18_.units[_loc12_];
               if(!_loc20_.data.typeDIO.flying)
               {
                  _loc13_ = laserUnitCheck(_loc20_,param1,param2);
                  if(_loc13_)
                  {
                     _loc20_.underAttack.hit(damage);
                  }
               }
               _loc12_--;
            }
            _loc16_++;
         }
      }
      
      override public function stopAttack(param1:Boolean = true) : void
      {
         super.stopAttack(param1);
         towerAnimationManager.exitAttackMode();
      }
      
      private function laserUnitCheck(param1:GameSprite, param2:Number, param3:Number) : Boolean
      {
         return LASER_THICKNESS_SQUARE >= ((param1.position.point.x - param2) * FORMULE_DIFF_Y - (param1.position.point.y - param3) * FORMULE_DIFF_X) * ((param1.position.point.x - param2) * FORMULE_DIFF_Y - (param1.position.point.y - param3) * FORMULE_DIFF_X) / FORMULE_DIVIDER;
      }
      
      override public function calculateDamage() : void
      {
         damage = buildingSpecificInfo[BuildingSpecificInfoType.DAMAGES_PER_SHOT_PER_LEVEL.id][levelIndex] * d;
      }
      
      public function startGrowing() : void
      {
         var _loc1_:Number = laser.testAngle / 3.14 * 180;
         if(_loc1_ < 180 && _loc1_ > 0)
         {
            lightSourceSprite.position.projected.z = -1;
         }
         else
         {
            lightSourceSprite.position.projected.z = 1000;
         }
         compositeView.addChild(lightSourceSprite);
         compositeView.children.sort(ZSort.compareZ);
         validator.add(lightSourceSprite);
         actionAnimation.setFrame(0);
         actionAnimation.setStopFrame(2);
         actionAnimation.fpsChangeRate = 5;
         actionAnimation.setForward(true);
         actionAnimation.startAnimation();
      }
      
      public function startShrinking() : void
      {
         actionAnimation.setFrame(2);
         actionAnimation.setStopFrame(0);
         actionAnimation.fpsChangeRate = 5;
         actionAnimation.setForward(false);
         actionAnimation.animationFinished.addFunctionOnce(fireStopped);
         actionAnimation.startAnimation();
      }
      
      private function fireStopped() : void
      {
         compositeView.clearChild(lightSourceSprite);
      }
      
      override public function towerDestroyed() : void
      {
         super.towerDestroyed();
         startShrinking();
      }
   }
}

