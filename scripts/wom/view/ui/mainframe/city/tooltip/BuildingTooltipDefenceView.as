package wom.view.ui.mainframe.city.tooltip
{
   import flash.display.Sprite;
   import wom.model.resource.WomAssetRepository;
   
   public class BuildingTooltipDefenceView extends Sprite
   {
      
      public var damageView:TooltipInfoView;
      
      public var healthView:TooltipInfoView;
      
      public var health:int;
      
      public var damage:Number;
      
      public var assetRepository:WomAssetRepository;
      
      public var initialized:Boolean = false;
      
      public function BuildingTooltipDefenceView(param1:WomAssetRepository)
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
         healthView = new TooltipInfoView(assetRepository,"Health","" + health);
         addChild(healthView);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         damageView.x = 17;
         damageView.y = 0;
         healthView.x = damageView.x + damageView.width + 3;
         healthView.y = 0;
      }
      
      public function updateWithData(param1:Number, param2:int) : void
      {
         if(!initialized)
         {
            this.damage = param1;
            this.health = param2;
            init();
         }
      }
   }
}

