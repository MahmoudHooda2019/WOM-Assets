package wom.model.game
{
   public class AnnouncementInfo
   {
      
      private var _id:String;
      
      private var _header:String;
      
      private var _assetURL:String;
      
      private var _desc:String;
      
      private var _priority:int;
      
      private var _seen:Boolean;
      
      public function AnnouncementInfo(param1:String, param2:String, param3:String, param4:String, param5:int, param6:Boolean)
      {
         super();
         _id = param1;
         _header = param2;
         _assetURL = param3;
         _desc = param4;
         _priority = param5;
         _seen = param6;
      }
      
      public static function deserialize(param1:Object) : AnnouncementInfo
      {
         return new AnnouncementInfo(param1.id,param1.header,param1.assetURL,param1.desc,param1.priority,param1.seen);
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function get header() : String
      {
         return _header;
      }
      
      public function get assetURL() : String
      {
         return _assetURL;
      }
      
      public function get desc() : String
      {
         return _desc;
      }
      
      public function get priority() : int
      {
         return _priority;
      }
      
      public function get seen() : Boolean
      {
         return _seen;
      }
      
      public function set seen(param1:Boolean) : void
      {
         _seen = param1;
      }
   }
}

