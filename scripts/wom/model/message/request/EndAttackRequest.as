package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   import wom.model.dto.combat.PostBattleInfo;
   
   public class EndAttackRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var postBattleInfo:PostBattleInfo;
      
      private var _tutorialAttack:Boolean;
      
      public function EndAttackRequest(param1:PostBattleInfo, param2:Boolean = false)
      {
         super();
         this.postBattleInfo = param1;
         _tutorialAttack = param2;
      }
      
      override public function serialize() : Object
      {
         return {
            "info":postBattleInfo.serialize(),
            "tutorialAttack":_tutorialAttack
         };
      }
   }
}

