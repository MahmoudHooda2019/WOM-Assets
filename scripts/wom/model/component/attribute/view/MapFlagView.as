package wom.model.component.attribute.view
{
   import peak.cuckoo.game.attribute.view.AssetView;
   import wom.model.component.attribute.data.MapTileData;
   import wom.model.resource.WomAssetRepository;
   
   public class MapFlagView extends AssetView
   {
      
      public function MapFlagView(param1:MapTileData, param2:WomAssetRepository)
      {
         var _loc3_:String = determineBackground(param1);
         super(3,_loc3_);
      }
      
      private function determineBackground(param1:MapTileData) : String
      {
         return param1.mapMemberInfo.isEventNpc ? "Map1VisualAvatarBackground6" : (param1.mapMemberInfo.profile.isNpc ? "Map1VisualAvatarBackground5" : (!param1.mapMemberInfo.isAttackable() ? "Map1VisualAvatarBackground4" : (param1.mapMemberInfo.isAllianceEnemy || param1.mapMemberInfo.isRevanchist ? "Map1VisualAvatarBackground1" : (param1.mapMemberInfo.isFriend ? "Map1VisualAvatarBackground2" : "Map1VisualAvatarBackground3"))));
      }
      
      override public function init() : void
      {
         super.init();
      }
   }
}

