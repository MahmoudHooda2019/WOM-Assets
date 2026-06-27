package wom.model.component.behavior.battle.underatack
{
   import flash.geom.Point;
   import flash.media.Sound;
   import peak.cuckoo.core.Component;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.dto.Point3;
   import peak.util.ValidationRecorder;
   import peak.util.ValidationVerifier;
   import wom.model.component.WomGameRoot;
   import wom.model.component.attribute.SfxManager;
   import wom.model.component.attribute.data.UnitData;
   import wom.model.component.attribute.viewManager.UnitViewManager;
   import wom.model.component.behavior.Particle3DAnimationManager;
   import wom.model.component.behavior.battle.BattleManager;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.component.entity.gamesprite.Unit;
   import wom.model.component.structure.FloatingTextStack;
   import wom.model.game.unit.UnitStatusType;
   
   public class UnderAttackUnit extends UnderAttack
   {
      
      protected var unitData:UnitData;
      
      protected var viewManager:UnitViewManager;
      
      public var towers:Vector.<Building>;
      
      protected var blood:Particle3DAnimationManager;
      
      protected var bloodPoint:Point3;
      
      private var sortPoint:Point;
      
      protected var projectedPoint:Point3;
      
      public var defending:Boolean;
      
      protected var projectedPosition:Point3;
      
      protected var _womGameRoot:WomGameRoot;
      
      protected var ownerUnit:Unit;
      
      protected var sfx:SfxManager;
      
      protected var deathSound:Sound;
      
      private var healTextStacker:FloatingTextStack;
      
      protected var hitTextStacker:FloatingTextStack;
      
      public var aboutToDie:Boolean;
      
      public function UnderAttackUnit(param1:BattleManager, param2:Boolean = false)
      {
         super(param1);
         this.defending = param2;
      }
      
      override public function init() : void
      {
         super.init();
         ownerUnit = owner as Unit;
         towers = new Vector.<Building>(0);
         blood = (owner.root as WomGameRoot).particle3DAnimationManager;
         bloodPoint = new Point3();
         healTextStacker = new FloatingTextStack();
         hitTextStacker = new FloatingTextStack();
         viewManager = (owner as Unit).viewManager;
         unitData = (owner as Unit).data;
         sortPoint = unitData.typeDIO.animationSortPoint;
         projectedPoint = (owner as GameSprite).position.projected;
         _womGameRoot = owner.root as WomGameRoot;
         projectedPosition = (owner as GameSprite).position.projected;
         sfx = (owner.root as WomGameRoot).sfxManager;
         deathSound = sfx.getDeathSound(unitData);
      }
      
      public function startTowerUnderAttack(param1:Building) : void
      {
         towers.push(param1);
      }
      
      public function stopTowerUnderAttack(param1:Building) : void
      {
         var _loc2_:int = towers.indexOf(param1);
         if(_loc2_ != -1)
         {
            towers.splice(_loc2_,1);
         }
      }
      
      public function hit(param1:Number) : Boolean
      {
         param1 *= unitData.armor._value;
         unitData.info.healthPoints -= param1;
         unitData.unitLog.totalDamageTaken += param1;
         _womGameRoot.displayFloatingText(new Point(projectedPosition.x + ownerUnit.bounds.width / 2,projectedPosition.y),1,"" + (param1 << 0),null,hitTextStacker);
         viewManager.manageHealthProgressBar();
         var _loc4_:WorkerThread = _womGameRoot.zcmp;
         if(_loc4_._value >= unitData.info.healthPoints)
         {
            if(ownerUnit.data.typeDIO.flying)
            {
               if(!aboutToDie)
               {
                  ownerUnit.movement.clearWaypoint(true);
                  ownerUnit.movement.movementFinished.addFunction(hitGround);
                  ownerUnit.movement.speedFactor = 5;
                  ownerUnit.data.info.status = UnitStatusType.DEAD;
                  ownerUnit.movement.addWaypoint(new Point3(ownerUnit.position.point.x,ownerUnit.position.point.y,0));
                  aboutToDie = true;
                  if(defending)
                  {
                     battleManager.battleFieldControl.defendingUnitDied(ownerUnit);
                  }
                  else
                  {
                     battleManager.battleFieldControl.attackingUnitDied(ownerUnit);
                  }
               }
            }
            else
            {
               bloodPoint.x = projectedPoint.x + ownerUnit.bounds.width / 2;
               bloodPoint.y = projectedPoint.y + ownerUnit.bounds.height / 2;
               blood.spillBlood(bloodPoint);
               if(defending)
               {
                  battleManager.battleFieldControl.defendingUnitDied(ownerUnit);
               }
               else
               {
                  battleManager.battleFieldControl.attackingUnitDied(ownerUnit);
               }
            }
            return true;
         }
         return false;
      }
      
      private function hitGround(param1:Unit) : void
      {
         bloodPoint.x = projectedPoint.x + param1.bounds.width / 2;
         bloodPoint.y = projectedPoint.y + param1.bounds.height / 2;
         blood.spillBlood(bloodPoint);
         owner.root.layers[3].remove(param1);
         owner.root.removeChild(owner);
         owner.destroyAll();
      }
      
      public function unitDestroy() : void
      {
         if(!owner.root)
         {
            return;
         }
         sfx.unitDeath(deathSound,ownerUnit);
         unitData.info.status = UnitStatusType.DEAD;
         if(!defending && unitData.cluster)
         {
            unitData.cluster.removeUnit(ownerUnit);
         }
         if(!aboutToDie)
         {
            owner.root.layers[3].remove(ownerUnit);
            owner.root.removeChild(owner);
            owner.destroyAll();
         }
         else
         {
            if(ownerUnit.data.info.typeId == 24)
            {
               ownerUnit.attack.disable();
            }
            if("AreaBuffDispenserAndFollower" in ownerUnit.componentManager)
            {
               (ownerUnit.componentManager["AreaBuffDispenserAndFollower"] as Component).disable();
            }
         }
      }
      
      public function heal(param1:Number) : void
      {
         if(unitData.info.healthPoints <= 0)
         {
            return;
         }
         _womGameRoot.displayFloatingText(new Point(projectedPosition.x + ownerUnit.bounds.width / 2,projectedPosition.y),2,"" + (param1 << 0),null,healTextStacker);
         unitData.info.healthPoints += param1;
         unitData.unitLog.totalHealTaken += param1;
         if(unitData.info.healthPoints > unitData.maxHealthPoint._value)
         {
            var _loc4_:WorkerThread;
            unitData.unitLog.totalHealTaken -= unitData.info.healthPoints - (_loc4_ = unitData.maxHealthPoint)._value;
            var _loc5_:WorkerThread;
            unitData.info.healthPoints = (_loc5_ = unitData.maxHealthPoint)._value;
         }
         viewManager.manageHealthProgressBar();
      }
   }
}

