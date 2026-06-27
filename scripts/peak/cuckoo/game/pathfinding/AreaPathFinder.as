package peak.cuckoo.game.pathfinding
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   import flash.geom.Point;
   import flash.system.ApplicationDomain;
   import flash.utils.ByteArray;
   import flash.utils.getTimer;
   import peak.cuckoo.game.dto.IntBounds;
   import peak.cuckoo.game.dto.IntPoint;
   import peak.cuckoo.game.dto.WeightNode;
   import peak.signal.Signal1;
   import peak.signal.Signal2;
   import peak.task.Task;
   
   public class AreaPathFinder extends Task
   {
      
      public static var domain:ApplicationDomain = ApplicationDomain.currentDomain;
      
      public static var sqrtMemory:ByteArray = new ByteArray();
      
      public static var NEIGHBOR_OFFSETS:Array = [-1025,-1024,-1023,1,1025,1024,1023,-1];
      
      public var wayPoints:Vector.<Point>;
      
      public var walkableThreshold:int;
      
      public var timeLimit:int;
      
      public var targetNodeId:int;
      
      public var targetArea:IntBounds;
      
      public var target:IntPoint;
      
      public var startNodeId:int;
      
      public var startNode:PathFinderNode;
      
      public var start:IntPoint;
      
      public var pathIteration:int;
      
      public var outerTarget:IntPoint;
      
      public var openSetHead:PathFinderNode;
      
      public var nodeSet:Array;
      
      public var grid:Array;
      
      public var finished:Signal2;
      
      public var continuing:Boolean = false;
      
      public var canceled:Signal1;
      
      public var bounds:IntBounds;
      
      public function AreaPathFinder(param1:Array, param2:IntBounds, param3:IntPoint, param4:IntBounds, param5:int)
      {
         super();
         grid = param1;
         bounds = param2;
         start = param3;
         target = new IntPoint(param4.highX + param4.lowX >> 1,param4.highY + param4.lowY >> 1);
         targetArea = param4;
         walkableThreshold = param5;
         finished = new Signal2();
         canceled = new Signal1();
      }
      
      override public function run(param1:uint) : Boolean
      {
         var _loc4_:* = null as WeightNode;
         var _loc5_:* = null as IntPoint;
         var _loc6_:* = null as IntPoint;
         var _loc7_:int = 0;
         var _loc8_:* = null as PathFinderNode;
         var _loc9_:* = 0;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Boolean = false;
         var _loc13_:* = null as IntBounds;
         var _loc14_:* = null as PathFinderNode;
         var _loc15_:* = 0;
         var _loc16_:* = 0;
         var _loc17_:Boolean = false;
         var _loc18_:* = null as PathFinderNode;
         var _loc19_:* = 0;
         var _loc20_:* = 0;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:* = null as Point;
         var _loc24_:int = 0;
         var _loc25_:int = 0;
         var _loc26_:int = 0;
         var _loc27_:* = 0;
         var _loc28_:* = 0;
         var _loc2_:int = int(param1);
         var _loc3_:ByteArray = AreaPathFinder.domain.domainMemory;
         AreaPathFinder.domain.domainMemory = AreaPathFinder.sqrtMemory;
         timeLimit = getTimer() + _loc2_;
         if(continuing || _loc12_)
         {
            _loc12_ = false;
            while(openSetHead != null)
            {
               _loc14_ = openSetHead;
               openSetHead = openSetHead.nextOpenNode;
               _loc8_ = _loc14_;
               _loc4_ = _loc8_.weightNode;
               _loc13_ = targetArea;
               if(_loc4_.x >= _loc13_.lowX && _loc4_.x <= _loc13_.highX && (_loc4_.y >= _loc13_.lowY && _loc4_.y <= _loc13_.highY))
               {
                  _loc12_ = true;
                  targetNodeId = _loc8_.weightNode.id;
                  break;
               }
               _loc8_.closed = true;
               _loc7_ = 0;
               while(_loc7_ < 8)
               {
                  _loc9_ = _loc7_++;
                  _loc15_ = int(AreaPathFinder.NEIGHBOR_OFFSETS[_loc9_]);
                  _loc16_ = _loc8_.weightNode.id + _loc15_;
                  _loc14_ = nodeSet[_loc16_];
                  _loc17_ = _loc14_ == null;
                  _loc4_ = grid[_loc16_];
                  if(_loc17_)
                  {
                     _loc14_ = nodeSet[_loc16_] = new PathFinderNode(_loc4_);
                  }
                  if(!_loc14_.closed)
                  {
                     _loc10_ = _loc8_.gScore + _loc4_.weight * 0.125;
                     if(_loc10_ <= _loc14_.gScore)
                     {
                        _loc14_.direction = _loc15_;
                        _loc14_.comeFrom = _loc8_;
                        _loc14_.gScore = _loc10_;
                        var _temp_14:* = _loc10_;
                        _loc19_ = _loc4_.x - target.x;
                        _loc20_ = _loc4_.y - target.y;
                        _loc21_ = _loc19_ * _loc19_ + _loc20_ * _loc20_;
                        sf32(_loc21_,0);
                        si32(1597463007 - (li32(0) >> 1),0);
                        _loc22_ = lf32(0);
                        _loc11_ = _temp_14 + _loc21_ * _loc22_ * (1.5 - _loc22_ * _loc22_ * _loc21_ * 0.5);
                        if(_loc11_ < _loc14_.fScore)
                        {
                           _loc14_.fScore = _loc11_;
                        }
                     }
                  }
                  if(_loc17_)
                  {
                     if(openSetHead == null || openSetHead.fScore > _loc14_.fScore)
                     {
                        _loc14_.nextOpenNode = openSetHead;
                        openSetHead = _loc14_;
                     }
                     else
                     {
                        _loc18_ = openSetHead;
                        while(_loc18_.nextOpenNode != null && _loc18_.nextOpenNode.fScore <= _loc14_.fScore)
                        {
                           _loc18_ = _loc18_.nextOpenNode;
                        }
                        _loc14_.nextOpenNode = _loc18_.nextOpenNode;
                        _loc18_.nextOpenNode = _loc14_;
                     }
                  }
               }
               if((pathIteration = pathIteration + 1) >= 300)
               {
                  pathIteration = 0;
                  if(getTimer() >= timeLimit)
                  {
                     break;
                  }
               }
            }
            if(!_loc12_)
            {
               continuing = true;
               AreaPathFinder.domain.domainMemory = _loc3_;
               return false;
            }
            _loc8_ = nodeSet[targetNodeId];
            _loc7_ = _loc8_.direction;
            wayPoints.push(new Point(_loc8_.weightNode.x,_loc8_.weightNode.y));
            do
            {
               _loc8_ = _loc8_.comeFrom;
               if(_loc8_.direction != _loc7_)
               {
                  _loc7_ = _loc8_.direction;
                  if(int(wayPoints.length) >= 2)
                  {
                     _loc23_ = wayPoints[int(wayPoints.length) - 2];
                     _loc9_ = int(_loc23_.x);
                     _loc15_ = int(_loc23_.y);
                     _loc16_ = _loc8_.weightNode.x;
                     _loc19_ = _loc8_.weightNode.y;
                     _loc20_ = int(_loc16_ > _loc9_ ? _loc16_ - _loc9_ : _loc9_ - _loc16_);
                     _loc24_ = _loc19_ > _loc15_ ? _loc19_ - _loc15_ : _loc15_ - _loc19_;
                     _loc25_ = _loc16_ > _loc9_ ? 1 : -1;
                     _loc26_ = _loc19_ > _loc15_ ? 1 : -1;
                     _loc27_ = 1 + _loc20_ + _loc24_;
                     _loc28_ = _loc20_ - _loc24_;
                     _loc20_ <<= 1;
                     _loc24_ <<= 1;
                     _loc12_ = true;
                     while(_loc27_-- > 0)
                     {
                        if(grid[(_loc9_ << 10) + _loc15_].weight > walkableThreshold)
                        {
                           _loc12_ = false;
                           break;
                        }
                        if(_loc28_ > 0)
                        {
                           _loc9_ += _loc25_;
                           _loc28_ -= _loc24_;
                        }
                        else
                        {
                           _loc15_ += _loc26_;
                           _loc28_ += _loc20_;
                        }
                     }
                     if(_loc12_)
                     {
                        wayPoints.pop();
                     }
                  }
                  wayPoints.push(new Point(_loc8_.weightNode.x,_loc8_.weightNode.y));
               }
            }
            while(_loc8_.weightNode.id != startNodeId);
            wayPoints.pop();
            wayPoints.reverse();
            if(outerTarget != null)
            {
               wayPoints.pop();
               wayPoints.push(new Point(outerTarget.x,outerTarget.y));
            }
         }
         AreaPathFinder.domain.domainMemory = _loc3_;
         finished.dispatch(wayPoints,taskId);
         return true;
      }
      
      override public function cancel() : void
      {
         canceled.dispatch(taskId);
      }
   }
}

import flash.system.ApplicationDomain;
import flash.utils.ByteArray;

