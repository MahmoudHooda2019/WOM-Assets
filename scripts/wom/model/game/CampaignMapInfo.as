package wom.model.game
{
   import flash.utils.Dictionary;
   
   public class CampaignMapInfo
   {
      
      private var _npcInfos:Dictionary;
      
      private var _byPassMap:Boolean;
      
      public function CampaignMapInfo()
      {
         super();
         _npcInfos = new Dictionary();
         _byPassMap = false;
      }
      
      public function get npcInfos() : Dictionary
      {
         return _npcInfos;
      }
      
      public function set npcInfos(param1:Dictionary) : void
      {
         _npcInfos = param1;
      }
      
      public function get byPassMap() : Boolean
      {
         return _byPassMap;
      }
      
      public function set byPassMap(param1:Boolean) : void
      {
         _byPassMap = param1;
      }
   }
}

