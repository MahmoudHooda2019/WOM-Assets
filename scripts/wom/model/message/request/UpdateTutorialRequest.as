package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   
   public class UpdateTutorialRequest extends AbstractOutgoingMessage
   {
      
      private var _tutorial:String;
      
      public function UpdateTutorialRequest(param1:String)
      {
         super();
         _tutorial = param1;
      }
      
      override public function serialize() : Object
      {
         return {"tutorial":_tutorial};
      }
   }
}

