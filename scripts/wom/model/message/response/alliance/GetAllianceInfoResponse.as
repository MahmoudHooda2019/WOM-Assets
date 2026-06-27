package wom.model.message.response.alliance
{
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.game.alliance.AllianceDetailInfo;
   import wom.model.message.util.AllianceDeserializeUtil;
   
   public class GetAllianceInfoResponse extends AbstractIncomingMessage
   {
      
      private var _allianceDetails:AllianceDetailInfo;
      
      public function GetAllianceInfoResponse()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _allianceDetails = AllianceDeserializeUtil.deserializeAllianceDetails(param1.alliance);
      }
      
      public function get allianceDetails() : AllianceDetailInfo
      {
         return _allianceDetails;
      }
   }
}

