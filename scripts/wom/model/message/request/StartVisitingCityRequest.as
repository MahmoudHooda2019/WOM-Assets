package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class StartVisitingCityRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var _gameId:String;
      
      public function StartVisitingCityRequest(param1:String)
      {
         super();
         _gameId = param1;
      }
      
      override public function serialize() : Object
      {
         return {"gameUid":_gameId};
      }
   }
}

