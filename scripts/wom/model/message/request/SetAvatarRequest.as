package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class SetAvatarRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var _name:String;
      
      private var _avatarId:int;
      
      public function SetAvatarRequest(param1:String, param2:int)
      {
         super();
         _name = param1;
         _avatarId = param2;
      }
      
      override public function serialize() : Object
      {
         return {
            "id":_avatarId,
            "name":_name
         };
      }
   }
}

