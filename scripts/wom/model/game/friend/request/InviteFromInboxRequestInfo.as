package wom.model.game.friend.request
{
   import wom.model.domain.domaininfoobject.PartTypeDIO;
   import wom.model.game.Profile;
   
   public class InviteFromInboxRequestInfo extends RequestInfo
   {
      
      public static const MAX_FRIENDS_AMOUNT:int = 50;
      
      private var _nonPlayingFriends:Vector.<Profile>;
      
      private var _partDIO:PartTypeDIO;
      
      public function InviteFromInboxRequestInfo(param1:Vector.<Profile>)
      {
         super(NaN,NaN,12,param1[0],"sent");
         _nonPlayingFriends = param1;
         _partDIO = PartTypeDIO.LUMBER_GIFT;
      }
      
      public function get nonPlayingFriends() : Vector.<Profile>
      {
         return _nonPlayingFriends;
      }
      
      public function get partDIO() : PartTypeDIO
      {
         return _partDIO;
      }
   }
}

