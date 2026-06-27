package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   import wom.model.dto.UnitTypeAmountDTO;
   
   public class TransferUnitsToFriendWatchPostRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var userId:String;
      
      private var unitAmounts:Vector.<UnitTypeAmountDTO>;
      
      private var unitDeploymentSource:int;
      
      public function TransferUnitsToFriendWatchPostRequest(param1:String, param2:Vector.<UnitTypeAmountDTO>, param3:int)
      {
         super();
         this.userId = param1;
         this.unitAmounts = param2;
         this.unitDeploymentSource = param3;
      }
      
      override public function serialize() : Object
      {
         var _loc2_:int = 0;
         var _loc1_:Array = new Array(unitAmounts.length);
         _loc2_ = 0;
         while(_loc2_ < unitAmounts.length)
         {
            _loc1_[_loc2_] = {
               "id":unitAmounts[_loc2_].id,
               "amount":unitAmounts[_loc2_].amount
            };
            _loc2_++;
         }
         return {
            "userId":userId,
            "units":_loc1_,
            "unitDeploymentSource":unitDeploymentSource
         };
      }
   }
}

