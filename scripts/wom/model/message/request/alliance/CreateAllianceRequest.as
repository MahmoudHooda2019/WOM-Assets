package wom.model.message.request.alliance
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   import wom.model.game.alliance.AllianceDetailInfo;
   import wom.model.message.util.CoatOfArmsDeserializeUtil;
   
   public class CreateAllianceRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var _allianceDetails:AllianceDetailInfo;
      
      public function CreateAllianceRequest(param1:AllianceDetailInfo)
      {
         super();
         _allianceDetails = param1;
      }
      
      override public function serialize() : Object
      {
         return {
            "name":_allianceDetails.name,
            "membershipType":_allianceDetails.membershipType.id,
            "minScore":(_allianceDetails.minScore == -1 ? null : _allianceDetails.minScore),
            "minLevel":(_allianceDetails.minLevel == -1 ? null : _allianceDetails.minLevel),
            "description":_allianceDetails.description,
            "coa":CoatOfArmsDeserializeUtil.serializeCoatOfArmsInfo(_allianceDetails.coatOfArmsInfo)
         };
      }
   }
}

