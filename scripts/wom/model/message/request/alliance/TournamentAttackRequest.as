package wom.model.message.request.alliance
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class TournamentAttackRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var _byGold:Boolean;
      
      public function TournamentAttackRequest(param1:Boolean = false)
      {
         super();
         _byGold = param1;
      }
      
      override public function serialize() : Object
      {
         return {"byGold":_byGold};
      }
   }
}

