package wom.controller.event.combat
{
   import flash.events.Event;
   import wom.model.dto.PathFindWaypointDTO;
   
   public class AddWaypointsEvent extends Event
   {
      
      public static const ADD_WAYPOINT:String = "addWayPoint";
      
      public static const FLUSH_WAYPOINTS:String = "flushWaypoints";
      
      private var _pathFindWaypointDTO:PathFindWaypointDTO;
      
      public function AddWaypointsEvent(param1:String, param2:PathFindWaypointDTO = null)
      {
         super(param1);
         _pathFindWaypointDTO = param2;
      }
      
      public function get pathFindWaypointDTO() : PathFindWaypointDTO
      {
         return _pathFindWaypointDTO;
      }
   }
}

