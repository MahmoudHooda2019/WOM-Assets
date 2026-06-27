package wom.view.ui.mainframe.city.tooltip.mobile
{
   import starling.display.Sprite;
   import wom.model.resource.MobileWomAssetRepository;
   
   public class MobileBuildingTooltipWithOneProgressInfoView extends Sprite
   {
      
      public static const TYPE_DAMAGE:int = 0;
      
      public static const TYPE_HEART:int = 1;
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      public var damageView:MobileTooltipInfoView;
      
      public var health:int;
      
      public var value:int;
      
      private var _spyMood:Boolean;
      
      private var _type:int;
      
      public function MobileBuildingTooltipWithOneProgressInfoView(param1:int, param2:int, param3:Boolean = false)
      {
         super();
         _type = param1;
         this.value = param2;
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
         damageView = new MobileTooltipInfoView(getIconName(),"" + value,160,33,_spyMood);
         addChild(damageView);
      }
      
      private function getIconName() : String
      {
         var _loc1_:String = "";
         switch(_type)
         {
            case 0:
               _loc1_ = "IconDamage";
               break;
            case 1:
               _loc1_ = "IconHealth";
         }
         return _loc1_;
      }
      
      public function drawLayout() : void
      {
         damageView.x = 0;
         damageView.y = 0;
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

