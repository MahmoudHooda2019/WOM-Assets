package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   import wom.model.dto.PathFindWaypointDTO;
   
   public class AddWaypointsRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var _pathFindWaypointDTOs:Vector.<PathFindWaypointDTO>;
      
      public function AddWaypointsRequest(param1:Vector.<PathFindWaypointDTO>)
      {
         super();
         _pathFindWaypointDTOs = param1;
      }
      
      override public function serialize() : Object
      {
         var _loc2_:Array = [];
         for each(var _loc1_ in _pathFindWaypointDTOs)
         {
            _loc2_.push(_loc1_.serialize());
         }
         return {"wp":_loc2_};
      }
   }
}

