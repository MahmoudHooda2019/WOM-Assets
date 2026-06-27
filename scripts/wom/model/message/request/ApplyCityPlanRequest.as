package wom.model.message.request
{
   import flash.utils.Dictionary;
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   import wom.model.dto.PlannerBuildingDTO;
   
   public class ApplyCityPlanRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      public var _plan:Dictionary;
      
      public function ApplyCityPlanRequest(param1:Dictionary)
      {
         super();
         _plan = param1;
      }
      
      override public function serialize() : Object
      {
         var _loc4_:Object = null;
         var _loc3_:Array = [];
         var _loc1_:int = 0;
         for each(var _loc2_ in _plan)
         {
            _loc4_ = {
               "x":_loc2_.position.point.x,
               "y":_loc2_.position.point.y
            };
            _loc3_[_loc1_] = {
               "id":_loc2_.instanceId,
               "position":_loc4_
            };
            _loc1_ += 1;
         }
         return {"plan":_loc3_};
      }
   }
}

