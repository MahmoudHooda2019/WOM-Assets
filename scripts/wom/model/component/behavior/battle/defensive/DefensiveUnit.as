package wom.model.component.behavior.battle.defensive
{
   import flash.media.Sound;
   import peak.cuckoo.core.Behavior;
   import peak.cuckoo.game.behavior.FpsSync;
   import peak.cuckoo.game.dto.Point3;
   import wom.model.component.WomGameRoot;
   import wom.model.component.attribute.SfxManager;
   import wom.model.component.behavior.ParticleManager;
   import wom.model.component.behavior.battle.hit.BaseHit;
   import wom.model.component.behavior.battle.tower.CombineDefenseBuilding;
   import wom.model.component.entity.gamesprite.Particle;
   import wom.model.component.entity.gamesprite.Unit;
   import wom.model.component.structure.BattleField;
   import wom.model.game.beast.BeastInfo;
   import wom.model.game.unit.UnitStatusType;
   
   public class DefensiveUnit extends Behavior
   {
      
      public static const TYPE_ID:String = "DefensiveUnit";
      
      protected var state:uint;
      
      public var target:Unit;
      
      protected var watchPost:CombineDefenseBuilding;
      
      private var position:Point3;
      
      private var RNP:Point3;
      
      protected var ownerUnit:Unit;
      
      protected var wait:Number = 0;
      
      protected var sync:FpsSync;
      
      private var sfx:SfxManager;
      
      private var targetWaypoints:Vector.<Point3>;
      
      public var field:BattleField;
      
      protected var rangeSquare:int = 9;
      
      private var ownerRange:int;
      
      protected const DIRECT_WALKING:uint = 1;
      
      protected const WAY_FOLLOWING:uint = 2;
      
      protected const FIGHTING:uint = 3;
      
      protected const DISABLED:uint = 4;
      
      private var particle:Particle;
      
      private var particleManager:ParticleManager;
      
      public var hit:BaseHit;
      
      private var rotationGuide:Boolean;
      
      private var attackSound:Sound;
      
      protected var particleAssetId:String;
      
      public function DefensiveUnit(param1:CombineDefenseBuilding)
      {
         super();
         this.watchPost = param1;
      }
      
      override public function get typeId() : String
      {
         return "DefensiveUnit";
      }
      
      override public function init() : void
      {
         super.init();
         sync = owner.root.sync;
         ownerUnit = owner as Unit;
         position = ownerUnit.position.point;
         sfx = (ownerUnit.root as WomGameRoot).sfxManager;
         startEnabled = false;
         hit = ownerUnit.hit;
         attackSound = sfx.getAttackSound(ownerUnit.data);
         if(ownerUnit.movement.ranged != 0)
         {
            ownerRange = ownerUnit.movement.ranged * ownerUnit.movement.ranged;
            particleAssetId = ownerUnit.data.typeDIO.particleAsset;
            rotationGuide = ownerUnit.data.typeDIO.particleRotate;
            if(ownerUnit.data.typeDIO.particleSound)
            {
               attackSound = sfx.assetRepository.getSoundAssetReference(ownerUnit.data.typeDIO.particleSound).soundAsset.sound;
            }
            particleManager = (ownerUnit.root as WomGameRoot).particleManager;
         }
      }
      
      public function startAttack() : void
      {
         var _loc9_:int = 0;
         var _loc7_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc11_:int = 0;
         var _loc6_:Point3 = null;
         var _loc2_:Point3 = null;
         var _loc10_:Number = NaN;
         var _loc5_:int = 0;
         var _loc1_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc8_:Point3 = null;
         if(ownerUnit.data.info.healthPoints <= 0 || ownerUnit.data.info.status == UnitStatusType.IN_WATCH_POST)
         {
            watchPost.returnToHome(ownerUnit);
            return;
         }
         clearQuickCalculation();
         if(!target)
         {
            watchPost.returnToHome(ownerUnit);
            return;
         }
         rangeSquare = 16;
         if(ownerUnit.movement.ranged != 0)
         {
            rangeSquare += ownerRange;
         }
         if(target.isBeast && ownerUnit.data.info.typeId != 14)
         {
            rangeSquare += (target.data.info as BeastInfo).level * (target.data.info as BeastInfo).level * 9;
         }
         if(target.movement)
         {
            targetWaypoints = target.movement._waypoints.concat();
         }
         else
         {
            targetWaypoints = new Vector.<Point3>();
         }
         if(targetWaypoints.length == 0)
         {
            RNP = target.position.point;
            quickCalculation();
            return;
         }
         _loc9_ = -1;
         _loc7_ = 0;
         _loc11_ = 0;
         while(_loc11_ < targetWaypoints.length)
         {
            _loc4_ = (position.x - targetWaypoints[_loc11_].x) * (position.x - targetWaypoints[_loc11_].x) + (position.y - targetWaypoints[_loc11_].y) * (position.y - targetWaypoints[_loc11_].y);
            if(_loc4_ < _loc7_ || _loc9_ == -1)
            {
               _loc7_ = _loc4_;
               _loc9_ = _loc11_;
            }
            _loc11_++;
         }
         RNP = targetWaypoints[_loc9_];
         _loc6_ = new Point3(position.x - RNP.x,position.y - RNP.y);
         _loc2_ = new Point3();
         if(_loc9_ == 0)
         {
            _loc2_.x = target.position.point.x - RNP.x;
            _loc2_.y = target.position.point.y - RNP.y;
         }
         else
         {
            _loc2_.x = targetWaypoints[_loc9_ - 1].x - RNP.x;
            _loc2_.y = targetWaypoints[_loc9_ - 1].y - RNP.y;
         }
         _loc10_ = (_loc6_.x * _loc2_.x + _loc6_.y * _loc2_.y) / (_loc2_.x * _loc2_.x + _loc2_.y * _loc2_.y);
         _loc6_.x = _loc2_.x * _loc10_ + RNP.x;
         _loc6_.y = _loc2_.y * _loc10_ + RNP.y;
         _loc2_.x += RNP.x;
         _loc5_ = 0;
         _loc1_ = _loc2_.x - _loc6_.x;
         _loc3_ = RNP.x - _loc6_.x;
         if(_loc1_ >= 0)
         {
            _loc5_++;
         }
         else
         {
            _loc5_--;
         }
         if(_loc3_ >= 0)
         {
            _loc5_++;
         }
         else
         {
            _loc5_--;
         }
         if(_loc5_ == 0)
         {
            _loc8_ = _loc6_;
         }
         else
         {
            _loc2_.y += RNP.y;
            _loc1_ = _loc1_ < 0 ? -_loc1_ : _loc1_;
            _loc3_ = _loc3_ < 0 ? -_loc3_ : _loc3_;
            if(_loc1_ > _loc3_)
            {
               _loc8_ = RNP;
            }
            else if(_loc1_ != _loc3_)
            {
               _loc8_ = _loc2_;
            }
            else
            {
               _loc1_ = _loc2_.y - _loc6_.y;
               _loc3_ = RNP.y - _loc6_.y;
               _loc1_ = _loc1_ < 0 ? -_loc1_ : _loc1_;
               _loc3_ = _loc3_ < 0 ? -_loc3_ : _loc3_;
               if(_loc1_ >= _loc3_)
               {
                  _loc8_ = _loc2_;
               }
               else
               {
                  _loc8_ = RNP;
               }
            }
         }
         quickCalculation();
      }
      
      private function clearQuickCalculation() : void
      {
         ownerUnit.movement.clearWaypoint(true);
         disable();
      }
      
      private function quickCalculation() : void
      {
         ownerUnit.movement.addWaypoint(target.position.point);
         ownerUnit.movement.rangeSquare = rangeSquare;
         ownerUnit.movement.generalTarget = target.position.point;
         ownerUnit.movement.movementFinished.addFunctionOnce(reachedToTarget);
         state = 1;
         enable();
      }
      
      private function reachedOnWayPoint(param1:Point3) : void
      {
         clearQuickCalculation();
         if(target && target.movement._waypoints.length != 0 && param1.x == target.movement._waypoints[target.movement._waypoints.length - 1].x && param1.y == target.movement._waypoints[target.movement._waypoints.length - 1].y)
         {
            if(target.movement._waypoints[0] == RNP)
            {
               ownerUnit.movement.clearWaypoint();
               ownerUnit.movement.addWaypoint(target.position.point);
               ownerUnit.movement.rangeSquare = rangeSquare;
               ownerUnit.movement.generalTarget = target.position.point;
               ownerUnit.movement.movementFinished.addFunctionOnce(reachedToTarget);
            }
            else if(target.movement._waypoints.indexOf(RNP) == -1)
            {
               targetWaypoints = targetWaypoints.splice(targetWaypoints.indexOf(RNP),targetWaypoints.length - 1);
               ownerUnit.movement.clearWaypoint();
               ownerUnit.movement._waypoints = targetWaypoints;
               ownerUnit.movement.rangeSquare = rangeSquare;
               ownerUnit.movement.generalTarget = target.position.point;
               ownerUnit.movement.movementFinished.addFunctionOnce(reachedToTarget);
               ownerUnit.movement.enable();
            }
            else
            {
               targetWaypoints = targetWaypoints.splice(0,targetWaypoints.indexOf(RNP));
               targetWaypoints.reverse();
               targetWaypoints.push(target.position.point);
               ownerUnit.movement.clearWaypoint();
               ownerUnit.movement._waypoints = targetWaypoints;
               ownerUnit.movement.rangeSquare = rangeSquare;
               ownerUnit.movement.generalTarget = target.position.point;
               ownerUnit.movement.movementFinished.addFunctionOnce(reachedToTarget);
               ownerUnit.movement.enable();
            }
            return;
         }
         stopAttack();
      }
      
      protected function reachedToTarget(param1:Unit) : void
      {
         clearQuickCalculation();
         if(!target || target.data.info.healthPoints <= 0 || target.data.info.status == UnitStatusType.RETREATED || (position.x - target.position.point.x) * (position.x - target.position.point.x) + (position.y - target.position.point.y) * (position.y - target.position.point.y) > rangeSquare * rangeSquare - 9)
         {
            stopAttack();
            return;
         }
         target.attack.defendYourself(ownerUnit);
         if(ownerUnit.isBeast)
         {
            wait = 60;
         }
         else if(target.isBeast)
         {
            wait = 0;
         }
         if(owner.root)
         {
            ownerUnit.movement.faceTo(target.position.point);
            ownerUnit.animation.state = 2;
            state = 3;
            enable();
         }
      }
      
      override public function update() : void
      {
         wait -= sync.precise;
         if(wait > 0)
         {
            return;
         }
         wait = 60;
         switch(int(state) - 1)
         {
            case 0:
               ownerUnit.movement.faceTo(target.position.point);
            case 1:
               if(target.data.info.healthPoints <= 0 || target.data.info.status == UnitStatusType.RETREATED)
               {
                  stopAttack();
               }
               break;
            case 2:
               if(ownerUnit.movement.ranged != 0)
               {
                  particle = new Particle(new Point3(ownerUnit.position.projected.x + ownerUnit.viewManager.middlePoint.x,ownerUnit.position.projected.y + ownerUnit.viewManager.middlePoint.y),target.position.projected,new Point3(target.viewManager.middlePoint.x,target.viewManager.middlePoint.y),30,particleAssetId,rotationGuide,rotationGuide);
                  particle.hit.addFunctionOnce(particleHit);
                  particleManager.throwParticle(particle);
                  break;
               }
               hit.hitUnit(target);
               if(!target || !target.data || target.data.info.healthPoints <= 0)
               {
                  stopAttack();
               }
               sfx.unitAttack(attackSound,ownerUnit);
         }
      }
      
      private function particleHit() : void
      {
         hit.hitUnit(target);
         if(!target || !target.data || target.data.info.healthPoints <= 0)
         {
            stopAttack();
         }
         sfx.unitAttack(attackSound,ownerUnit);
      }
      
      public function stopAttack() : void
      {
         target = null;
         ownerUnit.movement.clearWaypoint(true);
         ownerUnit.animation.state = 0;
         disable();
         watchPost.returnToHome(ownerUnit);
      }
      
      override public function disable() : void
      {
         super.disable();
         state = 4;
      }
   }
}

