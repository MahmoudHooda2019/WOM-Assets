package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.dto.UnitTypeAmountDTO;
   
   public class UnitsExecutedEventNotification extends AbstractIncomingMessage
   {
      
      private var _unitTypeAmountTuple:Vector.<UnitTypeAmountDTO>;
      
      public function UnitsExecutedEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         var _loc2_:int = 0;
         _unitTypeAmountTuple = new Vector.<UnitTypeAmountDTO>();
         _loc2_ = 0;
         while(_loc2_ < param1.unitAmounts.length)
         {
            _unitTypeAmountTuple.push(new UnitTypeAmountDTO(param1.unitAmounts[_loc2_].id,param1.unitAmounts[_loc2_].amount));
            _loc2_++;
         }
      }
      
      public function get unitTypeAmountTuple() : Vector.<UnitTypeAmountDTO>
      {
         return _unitTypeAmountTuple;
      }
   }
}

