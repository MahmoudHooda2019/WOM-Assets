package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   import wom.model.game.Profile;
   
   public class StartSpyingRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var _profile:Profile;
      
      public function StartSpyingRequest(param1:Profile)
      {
         super();
         _profile = param1;
      }
      
      override public function serialize() : Object
      {
         if(_profile.isNpc)
         {
            return {"npcName":_profile.npcId};
         }
         return {"gameUid":_profile.gameId};
      }
   }
}

