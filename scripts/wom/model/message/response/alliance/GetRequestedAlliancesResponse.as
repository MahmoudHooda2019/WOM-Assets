package wom.model.message.response.alliance
{
   import flash.utils.Dictionary;
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.message.util.AllianceDeserializeUtil;
   
   public class GetRequestedAlliancesResponse extends AbstractIncomingMessage
   {
      
      private var _requestedAllianceIds:Dictionary;
      
      public function GetRequestedAlliancesResponse()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _requestedAllianceIds = AllianceDeserializeUtil.deserializeRequestedAlliances(param1);
      }
      
      public function get requestedAllianceIds() : Dictionary
      {
         return _requestedAllianceIds;
      }
   }
}

