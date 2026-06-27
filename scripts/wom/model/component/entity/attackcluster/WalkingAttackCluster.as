package wom.model.component.entity.attackcluster
{
   import flash.geom.Point;
   import peak.cuckoo.game.Root;
   import peak.cuckoo.game.dto.IntBounds;
   import peak.cuckoo.game.dto.IntPoint;
   import peak.cuckoo.game.dto.Point3;
   import peak.cuckoo.game.pathfinding.AreaPathFinder;
   import peak.signal.Slot1;
   import peak.task.TaskQueue;
   import peak.util.ValidationRecorder;
   import peak.util.ValidationVerifier;
   import wom.model.component.behavior.battle.BattleManager;
   import wom.model.component.behavior.battle.underatack.UnderAttackBuilding;
   import wom.model.component.behavior.battle.visuals.CalculationIdle;
   import wom.model.component.behavior.movement.Movement;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.component.entity.gamesprite.Unit;
   import wom.model.game.beast.BeastInfo;
   
   public class WalkingAttackCluster extends AttackCluster implements Slot1
   {
      
      public var path:AreaPathFinder;
      
      private var calculatingTargetBuilding:Building;
      
      private var referencePoint:Point3 = new Point3();
      
      private var xCheckPath:int;
      
      private var yCheckPath:int;
      
      public function WalkingAttackCluster(param1:Root, param2:BattleManager, param3:Number, param4:Number)
      {
         super(param1,param2,param3,param4);
      }
      
      override public function chooseTargetAndFight() : Boolean
      {
         var _loc3_:UnderAttackBuilding = null;
         var _loc6_:int = 0;
         var _loc2_:Number = NaN;
         var _loc1_:Number = NaN;
         var _loc8_:int = 0;
         var _loc4_:Movement = null;
         var _loc7_:UnderAttackBuilding = null;
         if(super.chooseTargetAndFight())
         {
            return true;
         }
         var _loc5_:TaskQueue = root.taskQueue;
         if(path)
         {
            _loc5_.removeTask(path);
         }
         calculatingTargetBuilding = targetBuilding;
         if(!targetBuilding.underAttack)
         {
            _loc3_ = new UnderAttackBuilding(battleManager);
            targetBuilding.componentManager.add(targetBuilding.underAttack = _loc3_);
            _loc3_.init();
         }
         if(availableUnit > 0)
         {
            _loc6_ = targetBuilding.data.buildingTypeDIO.baseSize;
            _loc2_ = targetBuilding.position.point.x;
            _loc1_ = targetBuilding.position.point.y;
            path = new AreaPathFinder(womRoot.weightGrid.grid,womRoot.weightGrid.bounds,new IntPoint(x,y),new IntBounds(_loc2_,_loc2_ + _loc6_,_loc1_,_loc1_ + _loc6_),7);
            path.finished.addOnce(new PathfindFinishedHandler(this));
            path.canceled.addOnce(new PathfindCanceledHandler(this));
            _loc5_.addTask(path);
            referencePoint.x = x;
            referencePoint.y = y;
         }
         _loc8_ = 0;
         while(_loc8_ < units.length)
         {
            (units[_loc8_].componentManager["CalculationIdle"] as CalculationIdle).disable();
            if(units[_loc8_].attack.targetUnit)
            {
               trace("he is busyyyyyyyy-------------------1----------1--------------1----");
            }
            else
            {
               _loc4_ = units[_loc8_].movement;
               _loc4_.clearWaypoint();
               _loc4_.movementFinished.add(this);
               _loc4_.addWaypoint(difuseUnitsAtTarget(units[_loc8_].position.point.x,units[_loc8_].position.point.y,targetBuilding.position.point.x,targetBuilding.position.point.y,true));
               if(!targetBuilding.underAttack)
               {
                  _loc7_ = new UnderAttackBuilding(battleManager);
                  targetBuilding.componentManager.add(targetBuilding.underAttack = _loc7_);
                  _loc7_.init();
               }
               targetBuilding.underAttack.attackerUnits.push(units[_loc8_]);
               units[_loc8_].attack.targetBuilding = targetBuilding;
            }
            _loc8_++;
         }
         return false;
      }
      
      public function calculationFinished(param1:Vector.<Point>) : void
      {
         var _loc7_:Unit = null;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc9_:Movement = null;
         var _loc12_:Building = null;
         var _loc14_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc5_:int = 0;
         var _loc10_:Point3 = null;
         var _loc11_:Number = NaN;
         var _loc8_:UnderAttackBuilding = null;
         var _loc13_:Vector.<Unit> = new Vector.<Unit>();
         if(!param1)
         {
            return;
         }
         for each(_loc7_ in units)
         {
            if(_loc7_.attack.targetBuilding)
            {
               _loc3_ = _loc7_.attack.targetBuilding.underAttack.attackerUnits.indexOf(_loc7_);
               if(_loc3_ != -1)
               {
                  _loc7_.attack.targetBuilding.underAttack.attackerUnits.splice(_loc3_,1);
               }
            }
         }
         for each(_loc7_ in units)
         {
            if(!_loc7_.attack.targetUnit)
            {
               _loc13_.push(_loc7_);
            }
            else
            {
               trace("he is busyyyyyyyy-------------------3----------3--------------3----");
            }
         }
         if(_loc13_.length == 0)
         {
            return;
         }
         targetBuilding = calculatingTargetBuilding;
         if(targetBuilding.data.buildingInfo.healthPoint <= 0)
         {
            chooseTargetAndFight();
            return;
         }
         var _loc4_:int = targetBuilding.data.buildingTypeDIO.baseSize;
         _loc6_ = 0;
         while(_loc6_ < _loc13_.length)
         {
            _loc9_ = _loc13_[_loc6_].movement;
            _loc9_.clearWaypoint();
            (_loc13_[_loc6_].componentManager["CalculationIdle"] as CalculationIdle).disable();
            _loc9_.movementFinished.add(this);
            _loc6_++;
         }
         _loc6_ = 0;
         while(_loc6_ < param1.length)
         {
            _loc12_ = checkPath(x,y,param1[_loc6_].x,param1[_loc6_].y);
            if(!(!_loc12_ && _loc6_ != param1.length - 1))
            {
               if(_loc12_)
               {
                  targetBuilding = _loc12_;
                  _loc4_ = targetBuilding.data.buildingTypeDIO.baseSize;
               }
               _loc5_ = 0;
               while(_loc5_ < _loc13_.length)
               {
                  _loc7_ = _loc13_[_loc5_];
                  _loc10_ = difuseUnitsAtTarget(x,y,param1[_loc6_].x,param1[_loc6_].y);
                  if(_loc7_.movement.ranged != 0)
                  {
                     _loc11_ = _loc7_.movement.ranged;
                     _loc7_.movement.rangeSquare = _loc11_ * _loc11_;
                     _loc7_.movement.generalTarget = new Point3(targetBuilding.position.point.x + targetBuilding.data.buildingTypeDIO.baseSize / 2,targetBuilding.position.point.y + targetBuilding.data.buildingTypeDIO.baseSize / 2);
                  }
                  else if(unitData.isBeast)
                  {
                     _loc7_.movement.rangeSquare = (unitData.info as BeastInfo).level * (unitData.info as BeastInfo).level;
                     _loc7_.movement.generalTarget = _loc10_;
                  }
                  _loc7_.movement.addWaypoint(_loc10_);
                  _loc5_++;
               }
               x = xCheckPath;
               y = yCheckPath;
               break;
            }
            x = param1[_loc6_].x;
            y = param1[_loc6_].y;
            _loc14_ = _loc13_[0].position.point.x;
            _loc2_ = _loc13_[0].position.point.y;
            if((x - referencePoint.x) * (x - referencePoint.x) + (y - referencePoint.y) * (y - referencePoint.y) >= (_loc14_ - referencePoint.x) * (_loc14_ - referencePoint.x) + (_loc2_ - referencePoint.y) * (_loc2_ - referencePoint.y))
            {
               for each(_loc7_ in _loc13_)
               {
                  _loc7_.movement.addWaypoint(new Point3(param1[_loc6_].x,param1[_loc6_].y));
               }
            }
            _loc6_++;
         }
         if(!targetBuilding.underAttack)
         {
            _loc8_ = new UnderAttackBuilding(battleManager);
            targetBuilding.componentManager.add(targetBuilding.underAttack = _loc8_);
            _loc8_.init();
         }
         _loc6_ = 0;
         while(_loc6_ < _loc13_.length)
         {
            _loc7_ = _loc13_[_loc6_];
            if(_loc7_.attack.enabled)
            {
               if(_loc7_.attack.targetBuilding == targetBuilding)
               {
                  _loc7_.movement.clearWaypoint();
                  _loc7_.animation.state = 2;
               }
               else
               {
                  if(_loc7_.attack.targetUnit)
                  {
                     trace("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                     throw new Error();
                  }
                  _loc7_.attack.stopAttackBuilding();
                  _loc7_.animation.state = 1;
               }
            }
            targetBuilding.underAttack.attackerUnits.push(_loc7_);
            _loc7_.attack.targetBuilding = targetBuilding;
            _loc6_++;
         }
      }
      
      private function difuseUnitsAtTarget(param1:Number, param2:Number, param3:int, param4:int, param5:Boolean = false) : Point3
      {
         var _loc9_:Building = checkPath(param1,param2,param3,param4,param5);
         if(param5 && _loc9_)
         {
            targetBuilding = _loc9_;
         }
         var _loc8_:int = xCheckPath;
         var _loc6_:int = yCheckPath;
         var _loc10_:int = int(targetBuilding.data.buildingTypeDIO.pathMargin < 0 ? 0 : targetBuilding.data.buildingTypeDIO.pathMargin);
         var _loc7_:int = targetBuilding.data.buildingTypeDIO.baseSize - _loc10_ * 2;
         var _loc11_:Number = womRoot.pseudoRandomGenerator.nextDouble();
         var _loc12_:int = _loc11_ * _loc7_ + _loc10_;
         var _loc13_:int = womRoot.pseudoRandomGenerator.nextDouble() * _loc7_ + _loc10_;
         if(targetBuilding == checkPath(param1,param2,targetBuilding.position.point.x + _loc12_,targetBuilding.position.point.y + _loc13_,param5))
         {
            _loc8_ = xCheckPath;
            _loc6_ = yCheckPath;
         }
         return new Point3(_loc8_,_loc6_);
      }
      
      private function checkPath(param1:int, param2:int, param3:int, param4:int, param5:Boolean = false) : Building
      {
         var _loc11_:Building = null;
         var _loc13_:Array = battleManager.battleFieldControl.battleFieldRegisteredBuildings;
         var _loc7_:int = Math.abs(param3 - param1);
         var _loc8_:int = Math.abs(param4 - param2);
         var _loc15_:int = param1;
         var _loc14_:int = param2;
         var _loc9_:int = 1 + _loc7_ + _loc8_;
         var _loc10_:int = param3 > param1 ? 1 : -1;
         var _loc12_:int = param4 > param2 ? 1 : -1;
         var _loc6_:int = _loc7_ - _loc8_;
         _loc7_ <<= 1;
         _loc8_ <<= 1;
         while(_loc9_ > 0)
         {
            if(_loc13_[(_loc15_ << 10) + _loc14_] != null)
            {
               _loc11_ = _loc13_[(_loc15_ << 10) + _loc14_] as Building;
               if(!param5 && (_loc11_.data.buildingTypeDIO.id == 41 && (unitData.typeInfo && unitData.typeInfo.unitTypeId != 22 || !unitData.typeInfo) || _loc11_ == targetBuilding))
               {
                  return _loc11_;
               }
               if(param5 && !_loc11_.data.buildingTypeDIO.indestructable)
               {
                  return _loc11_;
               }
            }
            xCheckPath = _loc15_;
            yCheckPath = _loc14_;
            if(_loc6_ > 0)
            {
               _loc15_ += _loc10_;
               _loc6_ -= _loc8_;
            }
            else
            {
               _loc14_ += _loc12_;
               _loc6_ += _loc7_;
            }
            _loc9_--;
         }
         return null;
      }
      
      public function onSignal1(param1:*) : void
      {
         super.unitMoveFinished(param1 as Unit);
      }
      
      override public function removeUnit(param1:Unit) : void
      {
         super.removeUnit(param1);
         if(path && units.length == 0)
         {
            root.taskQueue.removeTask(path);
         }
      }
   }
}

import flash.geom.Point;
import peak.cuckoo.game.behavior.FpsSync;
import peak.signal.Slot1;
import peak.signal.Slot2;
import wom.model.component.CuckooNotifier;
import wom.model.dto.PathFindWaypointDTO;

class PathfindCanceledHandler implements Slot1
{
   
   private var attackCluster:WalkingAttackCluster;
   
   public function PathfindCanceledHandler(param1:WalkingAttackCluster)
   {
      super();
      this.attackCluster = param1;
   }
   
   public function onSignal1(param1:*) : void
   {
      var _loc2_:PathFindWaypointDTO = null;
      var _loc3_:int = param1;
      if(CuckooNotifier.getInstance())
      {
         _loc2_ = new PathFindWaypointDTO(FpsSync.frameNum,_loc3_,null,true);
         CuckooNotifier.getInstance().waypointCalculated(_loc2_);
      }
   }
}

class PathfindFinishedHandler implements Slot2
{
   
   private var attackCluster:WalkingAttackCluster;
   
   public function PathfindFinishedHandler(param1:WalkingAttackCluster)
   {
      super();
      this.attackCluster = param1;
   }
   
   public function onSignal2(param1:*, param2:*) : void
   {
      var _loc5_:* = undefined;
      var _loc8_:int = 0;
      var _loc3_:Point = null;
      var _loc4_:PathFindWaypointDTO = null;
      var _loc7_:int = param2;
      var _loc6_:Vector.<Point> = param1 as Vector.<Point>;
      if(CuckooNotifier.getInstance())
      {
         _loc5_ = new Vector.<Point>();
         _loc8_ = 0;
         while(_loc8_ < _loc6_.length)
         {
            _loc3_ = _loc6_[_loc8_];
            _loc5_[_loc8_] = new Point(_loc3_.x,_loc3_.y);
            _loc8_++;
         }
         _loc4_ = new PathFindWaypointDTO(FpsSync.frameNum,_loc7_,_loc5_);
         CuckooNotifier.getInstance().waypointCalculated(_loc4_);
      }
      attackCluster.path = null;
      attackCluster.calculationFinished(_loc6_);
   }
}
