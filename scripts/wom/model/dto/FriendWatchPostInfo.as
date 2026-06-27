package wom.model.dto
{
   public class FriendWatchPostInfo
   {
      
      private var _level:int;
      
      private var _availableCapacity:int;
      
      public function FriendWatchPostInfo(param1:int, param2:int)
      {
         super();
         _level = param1;
         _availableCapacity = param2;
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      public function get availableCapacity() : int
      {
         return _availableCapacity;
      }
      
      public function set availableCapacity(param1:int) : void
      {
         _availableCapacity = param1;
      }
      
      public function set level(param1:int) : void
      {
         _level = param1;
      }
   }
}

