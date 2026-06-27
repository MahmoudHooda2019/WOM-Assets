package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class UnitRewardsAddedEventNotification extends AbstractIncomingMessage
   {
      
      private var _unitTypeId:int;
      
      private var _amount:int;
      
      private var _questId:int;
      
      public function UnitRewardsAddedEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _unitTypeId = param1.unitTypeId;
         _amount = param1.amount;
         _questId = param1.questId;
      }
      
      public function get unitTypeId() : int
      {
         return _unitTypeId;
      }
      
      public function get amount() : int
      {
         return _amount;
      }
      
      public function get questId() : int
      {
         return _questId;
      }
   }
}

