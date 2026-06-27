package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class ReadAttackLogRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var _attackLogId:Number;
      
      private var _markAllAsRead:Boolean;
      
      public function ReadAttackLogRequest(param1:Number, param2:Boolean = false)
      {
         super();
         _attackLogId = param1;
         _markAllAsRead = param2;
      }
      
      override public function serialize() : Object
      {
         return {
            "attackLogId":_attackLogId,
            "markAllAsRead":_markAllAsRead
         };
      }
   }
}

