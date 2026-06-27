package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   
   public class GetUserIdsOfFriendsRequest extends AbstractOutgoingMessage
   {
      
      public var _fbIds:Array;
      
      public function GetUserIdsOfFriendsRequest(param1:Array)
      {
         super();
         _fbIds = param1 ? param1 : [];
      }
      
      override public function serialize() : Object
      {
         return {"fbIds":_fbIds};
      }
   }
}

