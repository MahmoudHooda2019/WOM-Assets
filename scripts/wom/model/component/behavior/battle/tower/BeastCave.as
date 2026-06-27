package wom.model.component.behavior.battle.tower
{
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.dto.Point3;
   import wom.model.component.WomGameRoot;
   import wom.model.component.behavior.battle.BattleManager;
   import wom.model.component.behavior.battle.defensive.DefensiveUnit;
   import wom.model.component.behavior.battle.defensive.FlyingDefensiveUnit;
   import wom.model.component.behavior.battle.hit.SingleHit;
   import wom.model.component.behavior.battle.hit.SplashHit;
   import wom.model.component.behavior.battle.underatack.UnderAttackUnit;
   import wom.model.component.behavior.building.CombineBuildingChildManager;
   import wom.model.component.behavior.unit.SynchronizedWander;
   import wom.model.component.behavior.unit.Wander;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.component.entity.gamesprite.Unit;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.game.unit.UnitStatusType;
   
   public class BeastCave extends CombineDefenseBuilding
   {
      
      public var beast:Unit;
      
      private var _combineBuildingChildManager:CombineBuildingChildManager;
      
      public function BeastCave(param1:BattleManager)
      {
         super(param1,1);
         startEnabled = false;
      }
      
      override public function init() : void
      {
         var _loc3_:DefensiveUnit = null;
         units = new Vector.<Unit>();
         ownerBuilding = owner as Building;
         r = ownerBuilding.data.buildingTypeDIO.buildingSpecificInfo[BuildingSpecificInfoType.RANGES_PER_LEVEL_IN_PX.id][ownerBuilding.data.buildingInfo.level - 1] / 5;
         super.init();
         var _loc2_:WomGameRoot = owner.root as WomGameRoot;
         for each(var _loc1_ in _loc2_.units)
         {
            if(_loc1_.data.isBeast)
            {
               beast = _loc1_;
               break;
            }
         }
         if(!beast)
         {
            var _temp_6:* = tm;
            var _loc9_:WorkerThread;
            var _loc11_:Number = (_loc9_ = _loc2_.tdst)._value;
            var _loc10_:WorkerThread = _temp_6;
            _loc10_._value = _loc11_;
            return;
         }
         units.push(beast);
         if(beast.data.info.healthPoints <= 0)
         {
            beast.data.info.healthPoints = 1;
         }
         _combineBuildingChildManager = ownerBuilding.componentManager["CombineBuildingChildManager"] as CombineBuildingChildManager;
         if(beast.data.typeDIO.id == 33)
         {
            attacksAir = true;
            beast.movement.ranged = beast.data.range;
            beast.componentManager.add(beast.hit = new SplashHit());
            beast.hit.init();
            _loc3_ = new DefensiveUnit(this);
         }
         else if(beast.data.typeDIO.id == 25)
         {
            attacksAir = true;
            beast.componentManager.add(beast.hit = new SingleHit());
            beast.hit.init();
            _loc3_ = new FlyingDefensiveUnit(this);
         }
         else
         {
            beast.componentManager.add(beast.hit = new SingleHit());
            beast.hit.init();
            _loc3_ = new DefensiveUnit(this);
         }
         beast.componentManager.add(beast.defence = _loc3_);
         var _loc4_:UnderAttackUnit = new UnderAttackUnit(b,true);
         beast.componentManager.add(beast.underAttack = _loc4_);
         _loc3_.init();
         _loc4_.init();
         beast.data.info.status = UnitStatusType.IN_WATCH_POST;
         var _loc6_:CombineBuildingChildManager = owner.componentManager["CombineBuildingChildManager"] as CombineBuildingChildManager;
         var _loc5_:SynchronizedWander = new SynchronizedWander(_loc6_.edgeSpace,_loc6_.gardenSpace,_loc6_.buildingSpace,owner as GameSprite);
         beast.componentManager.add(_loc5_);
         _loc5_.init();
      }
      
      override public function startAttack() : void
      {
         if(!beast || beast.data.info.healthPoints <= 0)
         {
            var _temp_2:* = tm;
            var _loc5_:Number = womRoot.tdst._value;
            var _loc2_:WorkerThread = _temp_2;
            _loc2_._value = _loc5_;
            return;
         }
         beast.defence.target = tu;
         if(beast.data.info.status == UnitStatusType.DEFENDING)
         {
            arrivedBeastCaveDoorToOut(beast,false);
         }
         else
         {
            if("Wander" in beast.componentManager)
            {
               (beast.componentManager["Wander"] as Wander).disable();
            }
            beast.movement.clearWaypoint();
            beast.movement.addWaypoint(new Point3(_combineBuildingChildManager.gateCoord.x,_combineBuildingChildManager.gateCoord.y));
            beast.movement.movementFinished.addFunctionOnce(arrivedBeastCaveDoorToOut);
         }
         var _temp_4:* = tm;
         var _loc6_:Number = womRoot.tda._value;
         var _loc4_:WorkerThread = _temp_4;
         _loc4_._value = _loc6_;
      }
      
      public function arrivedBeastCaveDoorToOut(param1:Unit, param2:Boolean = true) : void
      {
         param1.data.info.status = UnitStatusType.DEFENDING;
         if(param2)
         {
            _combineBuildingChildManager.removeUnit(param1);
         }
         if(!tu)
         {
            returnToHome(param1);
            return;
         }
         param1.defence.startAttack();
      }
      
      override public function returnToHome(param1:Unit) : void
      {
         if(param1.data.info.status == UnitStatusType.DEAD)
         {
            return;
         }
         stopAttack();
         if(param1.data.info.status == UnitStatusType.IN_WATCH_POST)
         {
            if("Wander" in beast.componentManager)
            {
               (beast.componentManager["Wander"] as Wander).enable();
            }
            return;
         }
         var _loc2_:Point3 = new Point3(ownerBuilding.position.point.x + _combineBuildingChildManager.gateCoord.x,ownerBuilding.position.point.y + _combineBuildingChildManager.gateCoord.y);
         param1.movement.clearWaypoint();
         param1.movement.generalTarget = _loc2_;
         param1.movement.rangeSquare = 0;
         param1.movement.addWaypoint(_loc2_);
         param1.movement.enable();
         param1.movement.movementFinished.addFunctionOnce(arrivedBeastCaveDoorToIn);
      }
      
      private function arrivedBeastCaveDoorToIn(param1:Unit) : void
      {
         _combineBuildingChildManager.addUnit(param1,true);
         param1.data.info.status = UnitStatusType.IN_WATCH_POST;
      }
      
      override public function checkUnitToAttack(param1:Unit) : int
      {
         if(param1.data.info.status == UnitStatusType.RETREATED)
         {
            var _loc2_:WorkerThread = womRoot.tdrd;
            return _loc2_._value;
         }
         return super.checkUnitToAttack(param1);
      }
      
      public function attackingUnitRetreated(param1:Unit) : void
      {
         if(param1 == beast.defence.target)
         {
            beast.defence.stopAttack();
         }
      }
   }
}

