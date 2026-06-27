package wom.model.game
{
   public class UserInterfaceInfo
   {
      
      private var _lastVisibleFriendIndex:int;
      
      private var _attackLogIndicatorShown:Boolean;
      
      public function UserInterfaceInfo()
      {
         super();
         _lastVisibleFriendIndex = -1;
         _attackLogIndicatorShown = false;
      }
      
      public function get lastVisibleFriendIndex() : int
      {
         return _lastVisibleFriendIndex;
      }
      
      public function set lastVisibleFriendIndex(param1:int) : void
      {
         _lastVisibleFriendIndex = param1;
      }
      
      public function get attackLogIndicatorShown() : Boolean
      {
         return _attackLogIndicatorShown;
      }
      
      public function set attackLogIndicatorShown(param1:Boolean) : void
      {
         _attackLogIndicatorShown = param1;
      }
   }
}

