package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   import wom.model.game.Profile;
   
   public class HelpFriendRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var _instanceId:int;
      
      private var _helpedFriendProfile:Profile;
      
      public function HelpFriendRequest(param1:Profile, param2:int)
      {
         super();
         _instanceId = param2;
         _helpedFriendProfile = param1;
      }
      
      override public function serialize() : Object
      {
         var _loc1_:Object = {"instanceId":_instanceId};
         if(_helpedFriendProfile.isNpc)
         {
            _loc1_.helpedNpcName = _helpedFriendProfile.npcId;
         }
         else
         {
            _loc1_.helpedGameUid = _helpedFriendProfile.gameId;
         }
         return _loc1_;
      }
   }
}

