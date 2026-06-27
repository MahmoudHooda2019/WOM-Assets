package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class GetBattleReportRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var _logId:Number;
      
      public function GetBattleReportRequest(param1:Number)
      {
         super();
         _logId = param1;
      }
      
      override public function serialize() : Object
      {
         return {"logId":_logId};
      }
   }
}

