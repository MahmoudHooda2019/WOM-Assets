package wom.view.ui.mainframe.city.tooltip.mobile
{
   import peak.util.MobileAlignmentUtil;
   import starling.display.Sprite;
   import wom.model.resource.MobileWomAssetRepository;
   
   public class MobileBuildingTooltipDefenseInfoView extends Sprite
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      public var damageView:MobileTooltipInfoView;
      
      public var healthView:MobileTooltipInfoView;
      
      public var health:int;
      
      public var damage:int;
      
      protected var _spyMood:Boolean;
      
      public function MobileBuildingTooltipDefenseInfoView(param1:int, param2:int, param3:Boolean = false)
      {
         super();
         this.damage = param1;
         this.health = param2;
         _spyMood = param3;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
         drawLayout();
      }
      
      public function initLayout() : void
      {
         damageView = new MobileTooltipInfoView("IconDamage","" + damage,160,33,_spyMood);
         addChild(damageView);
         healthView = new MobileTooltipInfoView("IconHealth","" + health,160,33,_spyMood);
         addChild(healthView);
      }
      
      public function drawLayout() : void
      {
         if(_spyMood)
         {
            MobileAlignmentUtil.alignAccordingToPositionOf(damageView,this);
            MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(damageView,this,45);
         }
         else
         {
            damageView.x = 17;
            damageView.y = 0;
            healthView.x = damageView.x + damageView.width + 3;
            healthView.y = 0;
         }
      }
      
      override public function get width() : Number
      {
         if(_spyMood)
         {
            return damageView.width;
         }
         return super.width;
      }
   }
}

