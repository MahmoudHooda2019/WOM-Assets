package wom.view.ui.mainframe.city.tooltip.mobile
{
   import flash.utils.Dictionary;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.Sprite;
   import wom.model.game.attack.CatapultTimeDTO;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.ui.common.MobileIconLabelView;
   
   public class MobileBuildingTooltipCatapultInfoView extends Sprite
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _lumberCatapultView:MobileIconLabelView;
      
      private var _stoneCatapultView:MobileIconLabelView;
      
      private var _mightCatapultView:MobileIconLabelView;
      
      private var _buildingLevel:int;
      
      public function MobileBuildingTooltipCatapultInfoView(param1:int)
      {
         super();
         _buildingLevel = param1;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
         drawLayout();
      }
      
      public function initLayout() : void
      {
         _lumberCatapultView = new MobileIconLabelView("CatapultButtonLumber","",55,48,null,null,false,0.7);
         _stoneCatapultView = new MobileIconLabelView("CatapultButtonStone","",55,48,null,null,false,0.7);
         _mightCatapultView = new MobileIconLabelView("CatapultButtonMight","",55,48,null,null,false,0.7);
         addChild(_lumberCatapultView);
         addChild(_stoneCatapultView);
         addChild(_mightCatapultView);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         _lumberCatapultView.x = 0;
         MobileAlignmentUtil.alignRightOf(_stoneCatapultView,_lumberCatapultView,20);
         MobileAlignmentUtil.alignRightOf(_mightCatapultView,_stoneCatapultView,20);
      }
      
      public function updateWithData(param1:Dictionary, param2:int) : void
      {
         updateCatapultViewLabel(_lumberCatapultView,param1[1],1 <= param2);
         updateCatapultViewLabel(_stoneCatapultView,param1[2],2 <= param2);
         updateCatapultViewLabel(_mightCatapultView,param1[3],3 <= param2);
         drawLayout();
      }
      
      private function updateCatapultViewLabel(param1:MobileIconLabelView, param2:CatapultTimeDTO, param3:Boolean) : void
      {
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Number = param2.catapultTime;
         if(param3)
         {
            param1.icon.alpha = 1;
            if(_loc5_ <= 0)
            {
               var _temp_1:* = param1;
               var _loc7_:String = "ui.mainframe.city.tooltip.catapultready";
               _temp_1.label = peak.i18n.PText.INSTANCE.getText0(_loc7_);
            }
            else
            {
               _loc6_ = _loc5_ / 1000;
               _loc4_ = _loc6_ / 60;
               _loc6_ %= 60;
               _loc4_ %= 60;
               param1.label = (_loc4_ < 10 ? "0" : "") + _loc4_ + ":" + ((_loc6_ < 10 ? "0" : "") + _loc6_);
            }
         }
         else
         {
            param1.icon.alpha = 0.5;
            var _temp_3:* = param1;
            var _loc8_:String = "ui.mainframe.city.tooltip.catapultlocked";
            _temp_3.label = peak.i18n.PText.INSTANCE.getText0(_loc8_);
         }
      }
      
      public function get buildingLevel() : int
      {
         return _buildingLevel;
      }
      
      override public function get height() : Number
      {
         return 80;
      }
   }
}

