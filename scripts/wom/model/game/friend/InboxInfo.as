package wom.model.game.friend
{
   import flash.utils.Dictionary;
   import wom.model.game.friend.request.RequestInfo;
   
   public class InboxInfo
   {
      
      public static const MODE_NOT_INITIALIZED:int = 0;
      
      public static const MODE_INITIALIZING:int = 1;
      
      public static const MODE_INITIALIZED:int = 2;
      
      private var _inboxMode:int;
      
      private var _inboxOpened:Boolean;
      
      private var _requests:Dictionary;
      
      private var _counts:Dictionary;
      
      private var _addFromClient:Dictionary;
      
      private var _addFromWeb:int;
      
      public function InboxInfo()
      {
         super();
         _inboxMode = 0;
         _inboxOpened = false;
         _requests = new Dictionary();
         _requests[1] = new Vector.<Vector.<RequestInfo>>();
         _requests[11] = new Vector.<Vector.<RequestInfo>>();
         _requests[2] = new Vector.<Vector.<RequestInfo>>();
         _requests[3] = new Vector.<Vector.<RequestInfo>>();
         _requests[9] = new Vector.<Vector.<RequestInfo>>();
         _requests[10] = new Vector.<Vector.<RequestInfo>>();
         _requests[13] = new Vector.<Vector.<RequestInfo>>();
         _requests[12] = new Vector.<Vector.<RequestInfo>>();
         _counts = new Dictionary();
         _counts[1] = 0;
         _counts[11] = 0;
         _counts[2] = 0;
         _counts[3] = 0;
         _counts[9] = 0;
         _counts[10] = 0;
         _counts[13] = 0;
         _counts[12] = 0;
         _addFromClient = new Dictionary();
         _addFromWeb = 0;
      }
      
      public function get inboxMode() : int
      {
         return _inboxMode;
      }
      
      public function set inboxMode(param1:int) : void
      {
         _inboxMode = param1;
      }
      
      public function get inboxOpened() : Boolean
      {
         return _inboxOpened;
      }
      
      public function set inboxOpened(param1:Boolean) : void
      {
         _inboxOpened = param1;
      }
      
      public function get requests() : Dictionary
      {
         return _requests;
      }
      
      public function get counts() : Dictionary
      {
         return _counts;
      }
      
      public function get totalCount() : int
      {
         var _loc2_:int = 0;
         for each(var _loc1_ in _counts)
         {
            _loc2_ += _loc1_;
         }
         return _loc2_;
      }
      
      public function clearRequests() : void
      {
         for(var _loc1_ in _requests)
         {
            _requests[_loc1_].length = 0;
            _counts[_loc1_] = 0;
         }
      }
      
      public function get addFromClient() : Dictionary
      {
         return _addFromClient;
      }
      
      public function totalAddFromClient() : int
      {
         var _loc1_:int = 0;
         for(var _loc2_ in _addFromClient)
         {
            _loc1_ += int(_addFromClient[_loc2_]);
         }
         return _loc1_;
      }
      
      public function get addFromWeb() : int
      {
         return _addFromWeb;
      }
      
      public function set addFromWeb(param1:int) : void
      {
         _addFromWeb = param1;
      }
   }
}

