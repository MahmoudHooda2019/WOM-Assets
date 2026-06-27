package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   import wom.model.game.Profile;
   
   public class EndVisitingCityRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var _visitedProfile:Profile;
      
      public function EndVisitingCityRequest(param1:Profile)
      {
         super();
         _visitedProfile = param1;
      }
      
      override public function serialize() : Object
      {
         if(_visitedProfile.isNpc)
         {
            return {"visitedNpcName":_visitedProfile.npcId};
         }
         return {"visitedGameUid":_visitedProfile.gameId};
      }
   }
}

