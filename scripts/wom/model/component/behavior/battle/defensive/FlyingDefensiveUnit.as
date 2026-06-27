package wom.model.component.behavior.battle.defensive
{
   import peak.cuckoo.game.dto.Point3;
   import wom.model.component.WomGameRoot;
   import wom.model.component.behavior.ParticleManager;
   import wom.model.component.behavior.battle.tower.CombineDefenseBuilding;
   import wom.model.component.behavior.movement.MovementAir;
   import wom.model.component.entity.gamesprite.Particle;
   import wom.model.component.entity.gamesprite.Unit;
   import wom.model.game.unit.UnitStatusType;
   
   public class FlyingDefensiveUnit extends DefensiveUnit
   {
      
      private var particleManager:ParticleManager;
      
      protected var HIT_WAIT_DURATION:Number = 60;
      
      public function FlyingDefensiveUnit(param1:CombineDefenseBuilding)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         super.init();
         var _loc1_:WomGameRoot = owner.root as WomGameRoot;
         particleManager = _loc1_.particleManager;
         rangeSquare = 900;
         particleAssetId = ownerUnit.data.typeDIO.particleAsset;
         if(ownerUnit.data.isBeast && ownerUnit.data.typeDIO.id == 25)
         {
            HIT_WAIT_DURATION = 8;
         }
      }
      
      override public function update() : void
      {
         wait -= sync.precise;
         if(wait > 0)
         {
            return;
         }
         ownerUnit.movement.faceTo(target.position.point);
         if((ownerUnit.position.point.x - target.position.point.x) * (ownerUnit.position.point.x - target.position.point.x) + (ownerUnit.position.point.y - target.position.point.y) * (ownerUnit.position.point.y - target.position.point.y) > rangeSquare + 25)
         {
            ownerUnit.movement.addWaypoint(target.position.point);
            ownerUnit.movement.rangeSquare = rangeSquare;
            (ownerUnit.movement as MovementAir).highFlight = true;
            ownerUnit.movement.generalTarget = target.position.point;
            ownerUnit.movement.movementFinished.addFunctionOnce(reachedToTargetSecondTime);
            disable();
            return;
         }
         wait = HIT_WAIT_DURATION;
         var _loc1_:Particle = new Particle(new Point3(ownerUnit.position.projected.x + ownerUnit.viewManager.middlePoint.x,ownerUnit.position.projected.y + ownerUnit.viewManager.middlePoint.y),target.position.projected,new Point3(target.viewManager.middlePoint.x,target.viewManager.middlePoint.y),30,particleAssetId,false,false);
         _loc1_.hit.addFunctionOnce(hitToTarget);
         particleManager.throwParticle(_loc1_);
      }
      
      private function hitToTarget() : void
      {
         hit.hitUnit(target);
         if(!target || !target.data || target.data.info.healthPoints <= 0)
         {
            stopAttack();
         }
      }
      
      override public function startAttack() : void
      {
         if(ownerUnit.data.info.healthPoints <= 0 || ownerUnit.data.info.status == UnitStatusType.IN_WATCH_POST)
         {
            watchPost.returnToHome(ownerUnit);
            return;
         }
         ownerUnit.movement.clearWaypoint();
         disable();
         if(!target)
         {
            trace("attack started target lost");
            watchPost.returnToHome(ownerUnit);
            return;
         }
         if(ownerUnit.position.point.z < 15)
         {
            ownerUnit.position.point.z = 15;
            ownerUnit.position.refreshPosition();
         }
         ownerUnit.movement.addWaypoint(target.position.point);
         ownerUnit.movement.rangeSquare = rangeSquare;
         (ownerUnit.movement as MovementAir).highFlight = true;
         ownerUnit.movement.generalTarget = target.position.point;
         ownerUnit.movement.movementFinished.addFunctionOnce(reachedToTarget);
      }
      
      override protected function reachedToTarget(param1:Unit) : void
      {
         if(target.data.info.healthPoints <= 0)
         {
            stopAttack();
            return;
         }
         if(target.data.typeDIO.flying || target.movement && target.movement.ranged != 0)
         {
            target.attack.defendYourself(ownerUnit);
         }
         ownerUnit.movement.faceTo(target.position.point);
         ownerUnit.animation.state = 2;
         enable();
      }
      
      private function reachedToTargetSecondTime(param1:Unit) : void
      {
         ownerUnit.movement.faceTo(target.position.point);
         ownerUnit.animation.state = 2;
         enable();
      }
   }
}

