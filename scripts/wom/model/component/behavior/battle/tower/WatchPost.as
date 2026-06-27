package wom.model.component.behavior.battle.tower
{
   import peak.cuckoo.game.behavior.animation.ActionAnimation;
   import peak.cuckoo.game.dto.Point3;
   import wom.model.component.WomGameRoot;
   import wom.model.component.behavior.Particle3DAnimationManager;
   import wom.model.component.behavior.battle.BattleManager;
   import wom.model.component.behavior.battle.defensive.BlowingDefensiveUnit;
   import wom.model.component.behavior.battle.defensive.DefensiveUnit;
   import wom.model.component.behavior.battle.hit.SingleHit;
   import wom.model.component.behavior.battle.hit.SplashHit;
   import wom.model.component.behavior.battle.underatack.UnderAttackUnit;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.component.entity.gamesprite.Unit;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.game.unit.UnitInfo;
   import wom.model.game.unit.UnitStatusType;
   import wom.model.game.unit.UnitTypeInfo;
   
   public class WatchPost extends CombineDefenseBuilding
   {
      
      protected var blood:Particle3DAnimationManager;
      
      private var bloodPoint:Point3;
      
      private var doorOpened:Boolean;
      
      private var targetStatus:UnitStatusType;
      
      public function WatchPost(param1:BattleManager)
      {
         super(param1,1);
         startEnabled = false;
      }
      
      override public function init() : void
      {
         var _loc6_:int = 0;
         var _loc2_:UnitInfo = null;
         var _loc4_:UnitTypeInfo = null;
         var _loc1_:Unit = null;
         var _loc3_:DefensiveUnit = null;
         var _loc5_:UnderAttackUnit = null;
         doorOpened = false;
         units = new Vector.<Unit>();
         ownerBuilding = owner as Building;
         targetStatus = UnitStatusType.IN_WATCH_POST;
         var _loc7_:int = ownerBuilding.data.buildingInfo.level == 0 ? 0 : ownerBuilding.data.buildingInfo.level - 1;
         r = ownerBuilding.data.buildingTypeDIO.buildingSpecificInfo[BuildingSpecificInfoType.RANGES_PER_LEVEL_IN_PX.id][_loc7_] / 5;
         blood = (owner.root as WomGameRoot).particle3DAnimationManager;
         bloodPoint = new Point3();
         super.init();
         _loc6_ = 0;
         while(_loc6_ < womRoot.cityInfo.units.length)
         {
            _loc2_ = womRoot.cityInfo.units[_loc6_];
            if(_loc2_.status == targetStatus && _loc2_.buildingId == ownerBuilding.data.buildingInfo.instanceId)
            {
               _loc4_ = womRoot.cityInfo.unitTypes[_loc2_.typeId];
               _loc1_ = womRoot.unitFactory.createUnit(_loc2_,_loc4_,ownerBuilding.position.point.x + 6,ownerBuilding.position.point.y + ownerBuilding.data.buildingTypeDIO.baseSize / 2,0);
               if(_loc1_.data.info.typeId == 14)
               {
                  _loc3_ = new BlowingDefensiveUnit(this,b);
               }
               else
               {
                  _loc3_ = new DefensiveUnit(this);
               }
               if(_loc1_.data.typeDIO.splashRange == 0)
               {
                  _loc1_.componentManager.add(_loc1_.hit = new SingleHit());
               }
               else
               {
                  _loc1_.componentManager.add(_loc1_.hit = new SplashHit());
               }
               _loc1_.componentManager.add(_loc1_.defence = _loc3_);
               _loc5_ = new UnderAttackUnit(b,true);
               _loc1_.componentManager.add(_loc1_.underAttack = _loc5_);
               _loc1_.hit.init();
               _loc3_.init();
               _loc5_.init();
               units.push(_loc1_);
            }
            _loc6_++;
         }
         if(units.length == 0)
         {
            var _temp_14:* = tm;
            var _loc9_:WorkerThread;
            var _loc11_:Number = (_loc9_ = womRoot.tdst)._value;
            var _loc10_:WorkerThread = _temp_14;
            _loc10_._value = _loc11_;
         }
         checkAirAttackAvailable();
      }
      
      private function checkAirAttackAvailable() : void
      {
         attacksAir = false;
         for each(var _loc1_ in units)
         {
            if(_loc1_.movement.ranged != 0 && (_loc1_.data.info.status == UnitStatusType.DEFENDING && !_loc1_.defence.target || _loc1_.data.info.status == targetStatus && !_loc1_.movement.enabled))
            {
               attacksAir = true;
            }
         }
      }
      
      override public function startAttack() : void
      {
         var _loc2_:ActionAnimation = null;
         var _loc1_:Unit = null;
         var _loc3_:Unit = null;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         if(!doorOpened)
         {
            if(ownerBuilding.viewManager.animation && ownerBuilding.viewManager.animation is ActionAnimation)
            {
               _loc2_ = ownerBuilding.viewManager.animation as ActionAnimation;
               _loc2_.setStopFrame(2);
               _loc2_.setForward(true);
               _loc2_.startAnimation();
               doorOpened = false;
            }
         }
         _loc6_ = 0;
         while(_loc6_ < units.length)
         {
            _loc3_ = units[_loc6_];
            if(!tu.data.typeDIO.flying || tu.data.typeDIO.flying && _loc3_.movement.ranged != 0)
            {
               if(_loc3_.data.info.status == UnitStatusType.DEFENDING && !_loc3_.defence.target)
               {
                  _loc1_ = _loc3_;
               }
            }
            _loc6_++;
         }
         if(!_loc1_)
         {
            _loc6_ = 0;
            while(_loc6_ < units.length)
            {
               _loc3_ = units[_loc6_];
               if(!tu.data.typeDIO.flying || tu.data.typeDIO.flying && _loc3_.movement.ranged != 0)
               {
                  if(_loc3_.data.info.status == targetStatus)
                  {
                     _loc1_ = _loc3_;
                  }
               }
               _loc6_++;
            }
         }
         if(!_loc1_)
         {
            var _temp_9:* = tm;
            var _loc7_:WorkerThread;
            var _loc11_:Number = (_loc7_ = womRoot.tdst)._value;
            var _loc8_:WorkerThread = _temp_9;
            _loc8_._value = _loc11_;
            return;
         }
         _loc1_.defence.target = tu;
         if(_loc1_.data.info.status == UnitStatusType.DEFENDING)
         {
            arrivedWatchPostDoorToOut(_loc1_);
            var _temp_12:* = tm;
            var _loc9_:WorkerThread;
            var _loc12_:Number = (_loc9_ = womRoot.tds)._value;
            var _loc10_:WorkerThread = _temp_12;
            _loc10_._value = _loc12_;
            td = 0;
            tu = null;
         }
         else
         {
            _loc5_ = ownerBuilding.position.point.x + 6;
            _loc4_ = ownerBuilding.position.point.y + ownerBuilding.data.buildingTypeDIO.baseSize;
            owner.root.layers[3].add(_loc1_);
            _loc1_.movement.clearWaypoint();
            _loc1_.movement.addWaypoint(new Point3(_loc5_,_loc4_,0));
            _loc1_.movement.movementFinished.addFunctionOnce(arrivedWatchPostDoorToOut);
            b.notifier.watchPostUnitDeployed(ownerBuilding);
         }
         checkAirAttackAvailable();
      }
      
      public function arrivedWatchPostDoorToOut(param1:Unit) : void
      {
         param1.data.info.status = UnitStatusType.DEFENDING;
         if(!tu)
         {
            returnToHome(param1);
            return;
         }
         param1.defence.startAttack();
         stopAttack(false);
      }
      
      override public function returnToHome(param1:Unit) : void
      {
         if(param1.data.info.status == UnitStatusType.DEAD)
         {
            return;
         }
         stopAttack();
         if(param1.data.info.status == targetStatus)
         {
            arrivedWatchPostDoorToIn(param1);
            return;
         }
         var _loc2_:Point3 = new Point3(ownerBuilding.position.point.x + 6,ownerBuilding.position.point.y + ownerBuilding.data.buildingTypeDIO.baseSize);
         param1.movement.clearWaypoint();
         param1.movement.generalTarget = _loc2_;
         param1.movement.rangeSquare = 0;
         param1.movement.addWaypoint(_loc2_);
         param1.movement.enable();
         param1.movement.movementFinished.addFunctionOnce(arrivedWatchPostDoorToIn);
      }
      
      private function arrivedWatchPostDoorToIn(param1:Unit) : void
      {
         if(ownerBuilding.data.buildingInfo.healthPoint <= 0)
         {
            param1.data.info.healthPoints = 0;
            param1.data.info.status = UnitStatusType.DEAD;
            b.battleFieldControl.defendingUnitDied(param1);
            return;
         }
         param1.movement.clearWaypoint();
         param1.movement.addWaypoint(new Point3(ownerBuilding.position.point.x + 6,ownerBuilding.position.point.y + ownerBuilding.data.buildingTypeDIO.baseSize / 2,0));
         param1.movement.movementFinished.addFunctionOnce(arrived);
      }
      
      private function arrived(param1:Unit) : void
      {
         if(ownerBuilding.data.buildingInfo.healthPoint <= 0)
         {
            bloodPoint.x = param1.position.projected.x + param1.bounds.width / 2;
            bloodPoint.y = param1.position.projected.y + param1.bounds.height / 2;
            blood.spillBlood(bloodPoint);
         }
         param1.data.info.status = targetStatus;
         param1.viewManager.clearHealthProgressBar();
         owner.root.layers[3].remove(param1);
      }
      
      override public function checkUnitToAttack(param1:Unit) : int
      {
         if(param1.data.info.status == UnitStatusType.RETREATED)
         {
            var _loc2_:WorkerThread = womRoot.tdrd;
            return _loc2_._value;
         }
         checkAirAttackAvailable();
         return super.checkUnitToAttack(param1);
      }
      
      override public function stopAttack(param1:Boolean = true) : void
      {
         if(units.length == 0)
         {
            var _temp_1:* = tm;
            var _loc4_:Number = womRoot.tdst._value;
            var _loc3_:WorkerThread = _temp_1;
            _loc3_._value = _loc4_;
         }
         super.stopAttack(param1);
      }
   }
}

