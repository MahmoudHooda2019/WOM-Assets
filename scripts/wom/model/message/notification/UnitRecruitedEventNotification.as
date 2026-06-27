package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class UnitRecruitedEventNotification extends AbstractIncomingMessage
   {
      
      private var _unitTypeId:int;
      
      public function UnitRecruitedEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _unitTypeId = param1.unitTypeId;
      }
      
      public function get unitTypeId() : int
      {
         return _unitTypeId;
      }
   }
}

