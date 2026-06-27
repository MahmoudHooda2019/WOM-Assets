package wom.model.component.behavior.movement
{
   import peak.cuckoo.game.dto.IntBounds;
   import peak.cuckoo.game.dto.IntPoint;
   import peak.cuckoo.game.dto.Point3;
   import peak.cuckoo.game.pathfinding.AreaPathFinder;
   import peak.cuckoo.game.pathfinding.PointPathFinder;
   import peak.task.TaskQueue;
   
   public class MovementWalk extends Movement
   {
      
      private var path:AreaPathFinder;
      
      private var _taskQueue:TaskQueue;
      
      public function MovementWalk()
      {
         super();
      }
      
      override public function init() : void
      {
         super.init();
         setDirection = true;
         _taskQueue = owner.root.taskQueue;
      }
      
      override public function update() : void
      {
         var _loc6_:Number = NaN;
         if(_waypoints.length == 0)
         {
            trace("bullshit");
            return;
         }
         var _loc8_:Point3 = _waypoints[0];
         var _loc1_:Point3 = ownerPosition.point;
         var _loc10_:WorkerThread = unitData.speed;
         var _loc4_:Number = _loc10_._value * sync.precise;
         var _loc3_:Number = _loc8_.x - _loc1_.x;
         var _loc5_:Number = _loc8_.y - _loc1_.y;
         if(setDirection)
         {
            setDirection = false;
            turn(_loc3_,_loc5_);
         }
         if(rangeSquare != 0)
         {
            _loc6_ = (generalTarget.x - _loc1_.x) * (generalTarget.x - _loc1_.x) + (generalTarget.y - _loc1_.y) * (generalTarget.y - _loc1_.y);
            if(_loc6_ <= rangeSquare)
            {
               faceTo(generalTarget);
               _waypoints.length = 0;
               setDirection = true;
               this.disable();
               movementFinished.dispatch(ownerUnit);
               return;
            }
         }
         var _loc7_:Number = _loc3_ < 0 ? -_loc3_ : _loc3_;
         var _loc9_:Number = _loc5_ < 0 ? -_loc5_ : _loc5_;
         if(_loc7_ <= _loc4_ && _loc9_ <= _loc4_)
         {
            _loc1_.x = _loc8_.x;
            _loc1_.y = _loc8_.y;
            ownerPosition.refreshPosition();
            _waypoints.splice(0,1);
            setDirection = true;
            if(_waypoints.length <= 0)
            {
               this.disable();
               movementFinished.dispatch(ownerUnit);
            }
            return;
         }
         var _loc2_:Number = Math.sqrt(_loc3_ * _loc3_ + _loc5_ * _loc5_);
         _loc1_.x += _loc4_ * _loc3_ / _loc2_;
         _loc1_.y += _loc4_ * _loc5_ / _loc2_;
         ownerPosition.refreshPosition();
      }
      
      override public function moveToPoint(param1:Point3, param2:int = 0) : void
      {
         clearWaypoint(true);
         generalTarget = param1;
         path = new PointPathFinder(womRoot.weightGrid.grid,womRoot.weightGrid.bounds,new IntPoint(ownerUnit.position.point.x,ownerUnit.position.point.y),new IntPoint(param1.x,param1.y),7);
         path.canceled.addOnce(new PathfindCanceledHandler(this));
         path.finished.addOnce(new PathfindFinishedHandler(ownerUnit,path));
         owner.root.taskQueue.addTask(path);
         this.rangeSquare = param2 * param2;
      }
      
      override public function moveToSquare(param1:int, param2:int, param3:int, param4:Point3, param5:int = 0) : void
      {
         clearWaypoint(true);
         generalTarget = param4;
         path = new AreaPathFinder(womRoot.weightGrid.grid,womRoot.weightGrid.bounds,new IntPoint(ownerUnit.position.point.x,ownerUnit.position.point.y),new IntBounds(param1,param1 + param3,param2,param2 + param3),7);
         path.canceled.addOnce(new PathfindCanceledHandler(this));
         path.finished.addOnce(new PathfindFinishedHandler(ownerUnit,path));
         owner.root.taskQueue.addTask(path);
         this.rangeSquare = param5 * param5;
      }
      
      override public function clearWaypoint(param1:Boolean = false) : void
      {
         super.clearWaypoint(param1);
         if(param1 && path)
         {
            _taskQueue.removeTask(path);
         }
      }
   }
}

import flash.geom.Point;
import peak.cuckoo.game.behavior.FpsSync;
import peak.cuckoo.game.dto.Point3;
import peak.cuckoo.game.pathfinding.AreaPathFinder;
import peak.signal.Slot1;
import peak.signal.Slot2;
import wom.model.component.CuckooNotifier;
import wom.model.component.entity.gamesprite.Unit;
import wom.model.dto.PathFindWaypointDTO;

class PathfindCanceledHandler implements Slot1
{
   
   private var movement:Movement;
   
   public function PathfindCanceledHandler(param1:Movement)
   {
      super();
      this.movement = param1;
   }
   
   public function onSignal1(param1:*) : void
   {
      var _loc3_:PathFindWaypointDTO = null;
      var _loc2_:int = param1;
      if(CuckooNotifier.getInstance())
      {
         _loc3_ = new PathFindWaypointDTO(FpsSync.frameNum,_loc2_,null,true);
         CuckooNotifier.getInstance().waypointCalculated(_loc3_);
      }
   }
}

class PathfindFinishedHandler implements Slot2
{
   
   private var owner:Unit;
   
   private var path:AreaPathFinder;
   
   public function PathfindFinishedHandler(param1:Unit, param2:AreaPathFinder)
   {
      super();
      this.owner = param1;
      this.path = param2;
   }
   
   public function onSignal2(param1:*, param2:*) : void
   {
      var _loc10_:int = 0;
      var _loc5_:* = undefined;
      var _loc8_:int = 0;
      var _loc9_:Point3 = null;
      var _loc3_:PathFindWaypointDTO = null;
      var _loc7_:int = param2;
      var _loc6_:Vector.<Point> = param1 as Vector.<Point>;
      var _loc4_:Vector.<Point3> = new Vector.<Point3>();
      _loc10_ = 0;
      while(_loc10_ < _loc6_.length)
      {
         _loc4_.push(new Point3(_loc6_[_loc10_].x,_loc6_[_loc10_].y));
         _loc10_++;
      }
      if(CuckooNotifier.getInstance())
      {
         _loc5_ = new Vector.<Point>();
         _loc8_ = 0;
         while(_loc8_ < _loc4_.length)
         {
            _loc9_ = _loc4_[_loc8_];
            _loc5_[_loc8_] = new Point(_loc9_.x,_loc9_.y);
            _loc8_++;
         }
         _loc3_ = new PathFindWaypointDTO(FpsSync.frameNum,_loc7_,_loc5_);
         CuckooNotifier.getInstance().waypointCalculated(_loc3_);
      }
      if(false && !owner.root)
      {
         return;
      }
      owner.movement.waypoints = _loc4_;
   }
}
