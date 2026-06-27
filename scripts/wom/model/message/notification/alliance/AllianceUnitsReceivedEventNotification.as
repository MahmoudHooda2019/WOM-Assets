package wom.model.message.notification.alliance
{
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.dto.UnitTypeAmountDTO;
   
   public class AllianceUnitsReceivedEventNotification extends AbstractIncomingMessage
   {
      
      private var _unitAmounts:Vector.<UnitTypeAmountDTO>;
      
      public function AllianceUnitsReceivedEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         var _loc2_:int = 0;
         _unitAmounts = new Vector.<UnitTypeAmountDTO>();
         _loc2_ = 0;
         while(_loc2_ < param1.unitAmounts.length)
         {
            _unitAmounts.push(new UnitTypeAmountDTO(param1.unitAmounts[_loc2_].id,param1.unitAmounts[_loc2_].amount));
            _loc2_++;
         }
      }
      
      public function get unitAmounts() : Vector.<UnitTypeAmountDTO>
      {
         return _unitAmounts;
      }
   }
}

