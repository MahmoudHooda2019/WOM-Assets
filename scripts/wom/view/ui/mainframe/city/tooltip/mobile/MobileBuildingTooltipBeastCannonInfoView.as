package wom.view.ui.mainframe.city.tooltip.mobile
{
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.component.progressbar.MobileWomProgressBar;
   
   public class MobileBuildingTooltipBeastCannonInfoView extends Sprite
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      public var damageView:MobileTooltipInfoView;
      
      public var healthView:MobileTooltipInfoView;
      
      public var health:int;
      
      public var damage:Number;
      
      public var maxAmmo:int;
      
      protected var _spyMood:Boolean;
      
      public var ammoProgressBar:MobileWomProgressBar;
      
      private var rechargeIcon:DisplayObject;
      
      public function MobileBuildingTooltipBeastCannonInfoView(param1:Number, param2:int, param3:int, param4:Boolean = false)
      {
         super();
         this.damage = param1;
         this.maxAmmo = param3;
         this.health = param2;
         _spyMood = param4;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
         drawLayout();
      }
      
      public function initLayout() : void
      {
         var _temp_3:* = §§findproperty(MobileTooltipInfoView);
         var _temp_2:* = "IconDamage";
         var _temp_1:* = "domain.buildingupgradevalues.percentdamage";
         var _loc1_:Number = damage;
         var _loc2_:String = _temp_1;
         damageView = new MobileTooltipInfoView(_temp_2,peak.i18n.PText.INSTANCE.getText1(_loc2_,_loc1_),130,33,_spyMood);
         addChild(damageView);
         ammoProgressBar = MobileWomUIComponentFactory.createProgressBar("Yellow");
         ammoProgressBar.width = 133;
         ammoProgressBar.height = 33;
         ammoProgressBar.align = "center";
         ammoProgressBar.maximum = maxAmmo;
         addChild(ammoProgressBar);
         rechargeIcon = assetRepository.getDisplayObject("IconBombs");
         addChild(rechargeIcon);
         healthView = new MobileTooltipInfoView("IconHealth","" + health,130,33,_spyMood);
         addChild(healthView);
      }
      
      public function drawLayout() : void
      {
         if(_spyMood)
         {
            MobileAlignmentUtil.alignAccordingToPositionOf(damageView,this);
            MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(damageView,this,45);
            MobileAlignmentUtil.alignAccordingToPositionOf(ammoProgressBar,this,12,90);
         }
         else
         {
            damageView.x = 9;
            damageView.y = 0;
            ammoProgressBar.x = damageView.x + damageView.width + 10;
            ammoProgressBar.y = 0;
            healthView.x = ammoProgressBar.x + ammoProgressBar.width + 21;
            healthView.y = 0;
         }
         rechargeIcon.x = ammoProgressBar.x - (rechargeIcon.width >> 1) + 3;
         rechargeIcon.y = ammoProgressBar.y + (rechargeIcon.height - ammoProgressBar.height >> 1);
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

