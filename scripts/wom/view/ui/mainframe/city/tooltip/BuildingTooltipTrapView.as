package wom.view.ui.mainframe.city.tooltip
{
   import flash.display.Sprite;
   import wom.model.resource.WomAssetRepository;
   
   public class BuildingTooltipTrapView extends Sprite
   {
      
      public var damageView:TooltipInfoView;
      
      public var damage:int;
      
      public var assetRepository:WomAssetRepository;
      
      public var initialized:Boolean = false;
      
      public function BuildingTooltipTrapView(param1:WomAssetRepository)
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
         damageView = new TooltipInfoView(assetRepository,"SwordTooltipIcon","" + damage);
         addChild(damageView);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         damageView.x = (180 - damageView.width >> 1) + 10;
         damageView.y = 0;
      }
      
      public function updateWithData(param1:int) : void
      {
         if(!initialized)
         {
            this.damage = param1;
            init();
         }
      }
   }
}

