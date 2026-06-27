package wom.model.message.notification.alliance
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class ReplyToAllianceInvitationNotification extends AbstractIncomingMessage
   {
      
      private var _userId:String;
      
      private var _accepted:Boolean;
      
      public function ReplyToAllianceInvitationNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _userId = param1.userId;
         _accepted = param1.accepted;
      }
      
      public function get userId() : String
      {
         return _userId;
      }
      
      public function get accepted() : Boolean
      {
         return _accepted;
      }
   }
}

