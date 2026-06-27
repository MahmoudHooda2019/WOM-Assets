package wom.model.game.league
{
   public class LeagueBonusAndRewardDTO
   {
      
      private var _assetId:String;
      
      private var _prefix:String;
      
      private var _suffix:String;
      
      public function LeagueBonusAndRewardDTO(param1:String, param2:String = null, param3:String = null)
      {
         super();
         _assetId = param1;
         _prefix = param2 != null ? param2 : "";
         _suffix = param3 != null ? param3 : "";
      }
      
      public function get assetId() : String
      {
         return _assetId;
      }
      
      public function get prefix() : String
      {
         return _prefix;
      }
      
      public function get suffix() : String
      {
         return _suffix;
      }
   }
}

