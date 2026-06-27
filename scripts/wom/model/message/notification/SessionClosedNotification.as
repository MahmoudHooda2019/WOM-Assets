package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.game.connection.DisconnectionReasonType;
   
   public class SessionClosedNotification extends AbstractIncomingMessage
   {
      
      private var _disconnecting:Boolean;
      
      private var _reason:DisconnectionReasonType;
      
      public function SessionClosedNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _disconnecting = param1.disconnecting;
         _reason = DisconnectionReasonType.determineDisconnectionReason(param1.reason);
      }
      
      public function get disconnecting() : Boolean
      {
         return _disconnecting;
      }
      
      public function get reason() : DisconnectionReasonType
      {
         return _reason;
      }
   }
}

