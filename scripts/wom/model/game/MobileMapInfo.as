package wom.model.game
{
   import flash.utils.Dictionary;
   import wom.model.component.attribute.data.MapTileData;
   
   public class MobileMapInfo
   {
      
      private var _friendsOnMap:Dictionary;
      
      private var _nonFriendsOnMap:Dictionary;
      
      private var _allianceEnemies:Dictionary;
      
      private var _revanchists:Dictionary;
      
      private var _mapMemberInfos:Dictionary;
      
      private var _memberDataList:Vector.<MapTileData>;
      
      public function MobileMapInfo()
      {
         super();
         _friendsOnMap = new Dictionary();
         _nonFriendsOnMap = new Dictionary();
         _allianceEnemies = new Dictionary();
         _revanchists = new Dictionary();
         _mapMemberInfos = new Dictionary();
         _memberDataList = new Vector.<MapTileData>();
      }
      
      public function get friendsOnMap() : Dictionary
      {
         return _friendsOnMap;
      }
      
      public function set friendsOnMap(param1:Dictionary) : void
      {
         _friendsOnMap = param1;
      }
      
      public function get nonFriendsOnMap() : Dictionary
      {
         return _nonFriendsOnMap;
      }
      
      public function set nonFriendsOnMap(param1:Dictionary) : void
      {
         _nonFriendsOnMap = param1;
      }
      
      public function get allianceEnemies() : Dictionary
      {
         return _allianceEnemies;
      }
      
      public function set allianceEnemies(param1:Dictionary) : void
      {
         _allianceEnemies = param1;
      }
      
      public function get revanchists() : Dictionary
      {
         return _revanchists;
      }
      
      public function set revanchists(param1:Dictionary) : void
      {
         _revanchists = param1;
      }
      
      public function get mapMemberInfos() : Dictionary
      {
         return _mapMemberInfos;
      }
      
      public function set mapMemberInfos(param1:Dictionary) : void
      {
         _mapMemberInfos = param1;
      }
      
      public function get memberDataList() : Vector.<MapTileData>
      {
         return _memberDataList;
      }
      
      public function set memberDataList(param1:Vector.<MapTileData>) : void
      {
         _memberDataList = param1;
      }
   }
}

