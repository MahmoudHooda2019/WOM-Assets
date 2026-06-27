package wom.model.component.behavior.movement
{
   import peak.cuckoo.game.dto.Point3;
   import wom.model.component.WomGameRoot;
   
   public class MovementAir extends Movement
   {
      
      public const flyHeight:int = 15;
      
      private var grid:Array;
      
      private var xCheckPath:int;
      
      private var yCheckPath:int;
      
      private var squareType:Boolean;
      
      private var px:int;
      
      private var py:int;
      
      private var pBX:int;
      
      private var pBY:int;
      
      private var p1:Point3;
      
      private var p2:Point3;
      
      private var p3:Point3;
      
      public var highFlight:Boolean = false;
      
      public function MovementAir()
      {
         super();
         p1 = new Point3();
         p2 = new Point3();
         p3 = new Point3();
      }
      
      override public function init() : void
      {
         super.init();
         grid = (owner.root as WomGameRoot).cityGrid.grid;
         setDirection = true;
         squareType = false;
      }
      
      override public function moveToSquare(param1:int, param2:int, param3:int, param4:Point3, param5:int = 0) : void
      {
         squareType = true;
         this.px = param1;
         this.py = param2;
         this.pBX = param1 + param3;
         this.pBY = param2 + param3;
         moveToPoint(param4,param5);
      }
      
      override public function moveToPoint(param1:Point3, param2:int = 0) : void
      {
         if(ownerUnit.underAttack && ownerUnit.underAttack.aboutToDie)
         {
            return;
         }
         clearWaypoint();
         generalTarget = param1;
         if(ownerPosition.point.z != 15)
         {
            p1.x = ownerPosition.point.x;
            p1.y = ownerPosition.point.y;
            p1.z = ownerPosition.point.z;
            addWaypoint(p1);
         }
         if(!squareType)
         {
            p2.x = p3.x = param1.x;
            p2.y = p3.y = param1.y;
            p3.z = param1.z;
            p2.z = 15;
            addWaypoint(p2);
            if(param1.z != 15)
            {
               addWaypoint(p3);
            }
         }
         else
         {
            addWaypoint(checkPath(ownerPosition.point.x,ownerPosition.point.y,param1.x,param1.y));
         }
         squareType = false;
         this.rangeSquare = param2 * param2;
         faceTo(generalTarget);
         setDirection = false;
         enable();
         if(soundVariarity > 1)
         {
            sound = sounds[Math.random() * soundVariarity >> 0];
         }
         sfx.unitMove(sound,ownerUnit);
      }
      
      private function checkPath(param1:int, param2:int, param3:int, param4:int) : Point3
      {
         var _loc7_:int = Math.abs(param3 - param1);
         var _loc9_:int = Math.abs(param4 - param2);
         var _loc12_:int = param1;
         var _loc11_:int = param2;
         var _loc10_:int = 1 + _loc7_ + _loc9_;
         var _loc5_:int = param3 > param1 ? 1 : -1;
         var _loc8_:int = param4 > param2 ? 1 : -1;
         var _loc6_:int = _loc7_ - _loc9_;
         _loc7_ *= 2;
         _loc9_ *= 2;
         while(_loc10_ > 0)
         {
            if(_loc12_ >= px && _loc12_ <= pBX && _loc11_ >= py && _loc11_ <= pBY)
            {
               return new Point3(_loc12_,_loc11_,15);
            }
            xCheckPath = _loc12_;
            yCheckPath = _loc11_;
            if(_loc6_ > 0)
            {
               _loc12_ += _loc5_;
               _loc6_ -= _loc9_;
            }
            else
            {
               _loc11_ += _loc8_;
               _loc6_ += _loc7_;
            }
            _loc10_--;
         }
         return new Point3(_loc12_,_loc11_,15);
      }
      
      override public function update() : void
      {
         var _loc10_:int = 0;
         var _loc7_:Number = NaN;
         if(_waypoints.length == 0)
         {
            trace("bullshit");
            return;
         }
         var _loc9_:Point3 = _waypoints[0];
         var _loc1_:Point3 = ownerPosition.point;
         var _loc12_:WorkerThread = unitData.speed;
         var _loc4_:Number = _loc12_._value * sync.precise * speedFactor;
         var _loc3_:Number = _loc9_.x - _loc1_.x;
         var _loc5_:Number = _loc9_.y - _loc1_.y;
         var _loc6_:Number = _loc9_.z - _loc1_.z;
         var _loc8_:Number = _loc3_ < 0 ? -_loc3_ : _loc3_;
         var _loc11_:Number = _loc5_ < 0 ? -_loc5_ : _loc5_;
         if(_loc6_ == 0)
         {
            _loc10_ = 0;
         }
         else if(_loc6_ < 0)
         {
            _loc10_ = -1;
         }
         else
         {
            _loc10_ = 1;
         }
         if(setDirection || highFlight)
         {
            setDirection = false;
            turn(_loc3_,_loc5_);
         }
         if(rangeSquare != 0)
         {
            _loc7_ = (generalTarget.x - _loc1_.x) * (generalTarget.x - _loc1_.x) + (generalTarget.y - _loc1_.y) * (generalTarget.y - _loc1_.y);
            if(_loc7_ <= rangeSquare)
            {
               faceTo(generalTarget);
               _waypoints.length = 0;
               setDirection = true;
               this.disable();
               movementFinished.dispatch(ownerUnit);
               return;
            }
         }
         var _loc2_:Number = Math.sqrt(_loc3_ * _loc3_ + _loc5_ * _loc5_);
         if(_loc8_ <= _loc4_ && _loc11_ <= _loc4_ && _loc6_ * _loc10_ <= _loc4_)
         {
            _loc1_.x = _loc9_.x;
            _loc1_.y = _loc9_.y;
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
         if(_loc8_ <= _loc4_ && _loc11_ <= _loc4_)
         {
            _loc1_.x = _loc9_.x;
            _loc1_.y = _loc9_.y;
         }
         else
         {
            _loc1_.x += _loc4_ * _loc3_ / _loc2_;
            _loc1_.y += _loc4_ * _loc5_ / _loc2_;
         }
         if(!highFlight)
         {
            if(_loc6_ * _loc10_ <= _loc4_)
            {
               _loc1_.z = _loc9_.z;
            }
            else
            {
               _loc1_.z += _loc4_ * _loc10_ * 0.5;
            }
         }
         ownerPosition.refreshPosition();
      }
      
      override public function clearWaypoint(param1:Boolean = false) : void
      {
         if(ownerUnit.underAttack && ownerUnit.underAttack.aboutToDie)
         {
            return;
         }
         super.clearWaypoint(param1);
         highFlight = false;
      }
   }
}

