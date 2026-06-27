package wom.model.message.response
{
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.facebook.FacebookFriendInfo;
   
   public class GetUserIdsOfFriendsResp extends AbstractIncomingMessage
   {
      
      private var _facebookFriendInfos:Vector.<FacebookFriendInfo>;
      
      public function GetUserIdsOfFriendsResp()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         var _loc2_:FacebookFriendInfo = null;
         _facebookFriendInfos = new Vector.<FacebookFriendInfo>();
         if(!param1.facebookFriendInfos)
         {
            return;
         }
         for each(var _loc3_ in param1.facebookFriendInfos)
         {
            _loc2_ = new FacebookFriendInfo();
            _loc2_.loadDataFromObject(_loc3_);
            _facebookFriendInfos.push(_loc2_);
         }
      }
      
      public function get facebookFriendInfos() : Vector.<FacebookFriendInfo>
      {
         return _facebookFriendInfos;
      }
   }
}

