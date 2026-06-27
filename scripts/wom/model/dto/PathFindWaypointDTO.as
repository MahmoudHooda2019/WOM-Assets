package wom.model.dto
{
   import flash.geom.Point;
   
   public class PathFindWaypointDTO
   {
      
      private var _finishedFrameNum:int;
      
      private var _taskID:int;
      
      private var _waypoint:Vector.<Point>;
      
      private var _canceled:Boolean;
      
      public function PathFindWaypointDTO(param1:int, param2:int, param3:Vector.<Point>, param4:Boolean = false)
      {
         super();
         this._finishedFrameNum = param1;
         this._taskID = param2;
         this._waypoint = param3;
         this._canceled = param4;
      }
      
      public static function deserialize(param1:Object) : PathFindWaypointDTO
      {
         var _loc3_:Vector.<Point> = new Vector.<Point>();
         for each(var _loc2_ in param1.w)
         {
            _loc3_.push(new Point(_loc2_.x,_loc2_.y));
         }
         return new PathFindWaypointDTO(param1.f,param1.t,_loc3_,param1.c);
      }
      
      public function get finishedFrameNum() : int
      {
         return _finishedFrameNum;
      }
      
      public function get taskID() : int
      {
         return _taskID;
      }
      
      public function get waypoint() : Vector.<Point>
      {
         return _waypoint;
      }
      
      public function get canceled() : Boolean
      {
         return _canceled;
      }
      
      public function serialize() : Object
      {
         var _loc2_:Array = [];
         for each(var _loc1_ in _waypoint)
         {
            _loc2_.push({
               "x":_loc1_.x,
               "y":_loc1_.y
            });
         }
         return {
            "f":_finishedFrameNum,
            "t":_taskID,
            "c":(_canceled ? 1 : 0),
            "w":_loc2_
         };
      }
   }
}

