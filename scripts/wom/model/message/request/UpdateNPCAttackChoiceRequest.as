package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   import wom.model.game.defense.NPCAttackChoiceType;
   
   public class UpdateNPCAttackChoiceRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var attackChoice:NPCAttackChoiceType;
      
      public function UpdateNPCAttackChoiceRequest(param1:NPCAttackChoiceType)
      {
         super();
         this.attackChoice = param1;
      }
      
      override public function serialize() : Object
      {
         return {"attackChoice":attackChoice.id};
      }
   }
}

