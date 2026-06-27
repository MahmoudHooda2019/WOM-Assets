package wom.model.game
{
   import wom.model.dto.PathFindWaypointDTO;
   
   public class WaypointStatusInfo
   {
      
      private var _calculatedWaypoints:Vector.<PathFindWaypointDTO>;
      
      public function WaypointStatusInfo()
      {
         super();
         _calculatedWaypoints = new Vector.<PathFindWaypointDTO>(0);
      }
      
      public function reset() : void
      {
         _calculatedWaypoints.length = 0;
      }
      
      public function get calculatedWaypoints() : Vector.<PathFindWaypointDTO>
      {
         return _calculatedWaypoints;
      }
   }
}

