package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class RecruitmentCancelledEventNotification extends AbstractIncomingMessage
   {
      
      private var _unitTypeId:int;
      
      public function RecruitmentCancelledEventNotification()
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

