package wom.controller.command.combat
{
   import wom.controller.PCommand;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.combat.AddWaypointsEvent;
   import wom.model.dto.PathFindWaypointDTO;
   import wom.model.game.WaypointStatusInfo;
   import wom.model.message.request.AddWaypointsRequest;
   
   public class AddWaypointsCommand extends PCommand
   {
      
      [Inject]
      public var event:AddWaypointsEvent;
      
      [Inject]
      public var waypointStatusInfo:WaypointStatusInfo;
      
      public function AddWaypointsCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         if(event.type == "addWayPoint")
         {
            addWaypoint(event.pathFindWaypointDTO);
         }
         else if(event.type == "flushWaypoints")
         {
            flushWaypoints();
         }
      }
      
      private function addWaypoint(param1:PathFindWaypointDTO) : void
      {
         waypointStatusInfo.calculatedWaypoints.push(param1);
         if(waypointStatusInfo.calculatedWaypoints.length >= 100)
         {
            flushWaypoints();
         }
      }
      
      private function flushWaypoints() : void
      {
         if(waypointStatusInfo.calculatedWaypoints.length > 0)
         {
            dispatch(new OutgoingMessageEvent("outgoingMessage",new AddWaypointsRequest(waypointStatusInfo.calculatedWaypoints)));
            waypointStatusInfo.reset();
         }
      }
   }
}

