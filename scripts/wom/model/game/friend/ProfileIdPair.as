package wom.model.game.friend
{
   public class ProfileIdPair
   {
      
      private var _platformId:String;
      
      private var _startNowId:String;
      
      public function ProfileIdPair(param1:String, param2:String)
      {
         super();
         _platformId = param1;
         _startNowId = param2;
      }
      
      public function get platformId() : String
      {
         return _platformId;
      }
      
      public function get startNowId() : String
      {
         return _startNowId;
      }
   }
}

