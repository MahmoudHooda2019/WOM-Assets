package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   import wom.model.dto.UnitTypeAmountDTO;
   
   public class ExecuteUnitRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var unitAmounts:Vector.<UnitTypeAmountDTO>;
      
      public function ExecuteUnitRequest(param1:Vector.<UnitTypeAmountDTO>)
      {
         super();
         this.unitAmounts = param1;
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
         return {"unitAmounts":_loc1_};
      }
   }
}

