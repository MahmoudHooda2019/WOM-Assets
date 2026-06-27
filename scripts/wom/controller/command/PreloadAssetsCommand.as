package wom.controller.command
{
   import wom.controller.PCommand;
   import wom.controller.event.PreloadAssetsEvent;
   import wom.model.resource.WomAssetRepository;
   import wom.model.resource.asset.AssetCategoryType;
   
   public class PreloadAssetsCommand extends PCommand
   {
      
      [Inject]
      public var event:PreloadAssetsEvent;
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      public function PreloadAssetsCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         if(event.assetCategory == AssetCategoryType.TUTORIAL_ALL)
         {
            preloadAssetCategory(AssetCategoryType.TUTORIAL_BUILD_MENU);
            preloadAssetCategory(AssetCategoryType.TUTORIAL_STORE_ITEM);
            preloadAssetCategory(AssetCategoryType.TUTORIAL_BUILDING_SILHOUETTE);
            preloadAssetCategory(AssetCategoryType.TUTORIAL_BUILDING_CANVAS);
            preloadAssetCategory(AssetCategoryType.TUTORIAL_QUEST_ICONS);
            preloadAssetCategory(AssetCategoryType.TUTORIAL_MERC_SMALL_AVATAR);
            preloadAssetCategory(AssetCategoryType.TUTORIAL_MERC_MEDIUM_AVATAR);
            preloadAssetCategory(AssetCategoryType.TUTORIAL_INVITE_IMAGE);
         }
         else
         {
            preloadAssetCategory(event.assetCategory);
         }
      }
      
      private function preloadAssetCategory(param1:AssetCategoryType) : void
      {
         assetRepository.preload(param1.assets);
      }
   }
}

