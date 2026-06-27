package wom.model.facebook
{
   public class FacebookUserInfo
   {
      
      public static var NAME_REGEXP:RegExp = new RegExp(/[^\wşğıüöçŞİĞÜÖÇ ]/);
      
      private var _uid:String;
      
      private var _fullName:String;
      
      public function FacebookUserInfo()
      {
         super();
      }
      
      public static function shortenLastWord(param1:String) : String
      {
         if(!param1)
         {
            return "";
         }
         var _loc2_:Array = param1.split(" ");
         return _loc2_[0] + (_loc2_.length > 1 ? " " + _loc2_[_loc2_.length - 1].charAt(0) + "." : "");
      }
      
      public function loadDataFromObject(param1:Object) : void
      {
         _uid = param1["id"];
         fullName = param1["name"];
      }
      
      public function get uid() : String
      {
         return _uid;
      }
      
      public function get fullName() : String
      {
         return _fullName;
      }
      
      public function set uid(param1:String) : void
      {
         _uid = param1;
      }
      
      public function set fullName(param1:String) : void
      {
         _fullName = param1.replace(NAME_REGEXP,"_");
      }
      
      public function shortenedFullName() : String
      {
         return shortenLastWord(_fullName);
      }
   }
}

