package wom.view.ui.mainframe.city.tooltip
{
   import flash.display.Sprite;
   import wom.model.resource.WomAssetRepository;
   
   public class BuildingTooltipWallView extends Sprite
   {
      
      public var healthView:TooltipInfoView;
      
      public var health:int;
      
      public var assetRepository:WomAssetRepository;
      
      public var initialized:Boolean = false;
      
      public function BuildingTooltipWallView(param1:WomAssetRepository)
      {
         super();
         this.assetRepository = param1;
      }
      
      public function init() : void
      {
         initLayout();
         initialized = true;
      }
      
      public function initLayout() : void
      {
         healthView = new TooltipInfoView(assetRepository,"Health","" + health);
         addChild(healthView);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         healthView.x = (180 - healthView.width >> 1) + 10;
         healthView.y = 0;
      }
      
      public function updateWithData(param1:int) : void
      {
         if(!initialized)
         {
            this.health = param1;
            init();
         }
      }
   }
}

