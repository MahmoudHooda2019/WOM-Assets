package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class RechargeCatapultRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var _catapultId:int;
      
      private var _goldAmount:int;
      
      public function RechargeCatapultRequest(param1:int, param2:int)
      {
         super();
         _catapultId = param1;
         _goldAmount = param2;
      }
      
      override public function serialize() : Object
      {
         return {
            "catapultId":_catapultId,
            "goldCost":_goldAmount
         };
      }
   }
}

