package wom.model.facebook
{
   public class FacebookFriendInfo
   {
      
      private var _gameUid:String;
      
      private var _fbId:String;
      
      private var _xp:Number;
      
      private var _coa:String;
      
      public function FacebookFriendInfo()
      {
         super();
      }
      
      public function loadDataFromObject(param1:Object) : void
      {
         _gameUid = param1["gameUid"];
         _fbId = param1["fbId"];
         _xp = param1["xp"];
         _coa = param1["coa"];
      }
      
      public function get gameUid() : String
      {
         return _gameUid;
      }
      
      public function get fbId() : String
      {
         return _fbId;
      }
      
      public function get xp() : Number
      {
         return _xp;
      }
      
      public function get coa() : String
      {
         return _coa;
      }
   }
}

