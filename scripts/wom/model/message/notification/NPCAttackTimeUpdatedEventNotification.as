package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class NPCAttackTimeUpdatedEventNotification extends AbstractIncomingMessage
   {
      
      private var _remainingTime:Number;
      
      private var _delayed:Boolean;
      
      public function NPCAttackTimeUpdatedEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _remainingTime = param1.remainingTime;
         _delayed = param1.delayed;
      }
      
      public function get remainingTime() : Number
      {
         return _remainingTime;
      }
      
      public function get delayed() : Boolean
      {
         return _delayed;
      }
   }
}

