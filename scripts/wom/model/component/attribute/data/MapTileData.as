package wom.model.component.attribute.data
{
   import flash.geom.Point;
   import peak.cuckoo.core.Attribute;
   import wom.model.dto.MapMemberInfo;
   
   public class MapTileData extends Attribute
   {
      
      public static const TYPE_ID:String = "MapTileData";
      
      public static const FOREST:int = 0;
      
      public static const NPC:int = 1;
      
      public static const PLAYER:int = 2;
      
      public static const DOODAD:int = 3;
      
      public var slot:int;
      
      public var assetId:int;
      
      public var townInfoPosition:Point;
      
      public var mapMemberInfo:MapMemberInfo;
      
      private var _tileType:int;
      
      public function MapTileData(param1:int, param2:MapMemberInfo)
      {
         super();
         this.mapMemberInfo = param2;
         this.assetId = param1;
         if(!param2)
         {
            _tileType = 0;
         }
         else if(param2.profile.isNpc)
         {
            _tileType = 1;
         }
         else
         {
            _tileType = 2;
         }
      }
      
      override public function get typeId() : String
      {
         return "MapTileData";
      }
      
      public function get tileType() : int
      {
         return _tileType;
      }
   }
}

