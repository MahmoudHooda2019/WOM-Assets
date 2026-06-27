package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.dto.UnitTypeAmountDTO;
   
   public class UnitsDeployedToWatchPostEventNotification extends AbstractIncomingMessage
   {
      
      private var _instanceId:int;
      
      private var _unitAmounts:Vector.<UnitTypeAmountDTO>;
      
      private var _unitDeploymentSource:int;
      
      public function UnitsDeployedToWatchPostEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         var _loc2_:int = 0;
         _instanceId = param1.instanceId;
         _unitDeploymentSource = param1.unitDeploymentSource;
         _unitAmounts = new Vector.<UnitTypeAmountDTO>();
         _loc2_ = 0;
         while(_loc2_ < param1.unitAmounts.length)
         {
            _unitAmounts.push(new UnitTypeAmountDTO(param1.unitAmounts[_loc2_].id,param1.unitAmounts[_loc2_].amount));
            _loc2_++;
         }
      }
      
      public function get instanceId() : int
      {
         return _instanceId;
      }
      
      public function get unitAmounts() : Vector.<UnitTypeAmountDTO>
      {
         return _unitAmounts;
      }
      
      public function get unitDeploymentSource() : int
      {
         return _unitDeploymentSource;
      }
   }
}

