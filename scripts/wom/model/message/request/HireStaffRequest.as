package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   import wom.model.game.Profile;
   
   public class HireStaffRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var _instanceId:int;
      
      private var _staffId:int;
      
      private var _suitableFriendProfile:Profile;
      
      public function HireStaffRequest(param1:int, param2:int, param3:Profile)
      {
         super();
         _instanceId = param1;
         _staffId = param2;
         _suitableFriendProfile = param3;
      }
      
      override public function serialize() : Object
      {
         var _loc1_:Object = {
            "instanceId":_instanceId,
            "staffId":_staffId
         };
         if(_suitableFriendProfile != null)
         {
            _loc1_.friendPlatformUid = _suitableFriendProfile.platformId;
            _loc1_.friendStartNowId = _suitableFriendProfile.avatar;
         }
         else
         {
            _loc1_.friendPlatformUid = null;
            _loc1_.friendStartNowId = null;
         }
         return _loc1_;
      }
   }
}

