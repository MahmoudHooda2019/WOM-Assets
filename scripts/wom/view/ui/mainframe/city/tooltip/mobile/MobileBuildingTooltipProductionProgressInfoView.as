package wom.view.ui.mainframe.city.tooltip.mobile
{
   import flash.utils.getTimer;
   import peak.component.mobile.MPTextField;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.i18n.lang.Languages;
   import peak.util.DateTimeUtil;
   import peak.util.MobileAlignmentUtil;
   import peak.util.NumberUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.game.building.BuildingInfo;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.component.progressbar.MobileWomProgressBar;
   import wom.view.getWomTextFormat;
   import wom.view.util.LocalizedDateTimeUtil;
   
   public class MobileBuildingTooltipProductionProgressInfoView extends Sprite implements View
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var dataTextField:MPTextField;
      
      private var icon:DisplayObject;
      
      private var _progressBar:MobileWomProgressBar;
      
      private var assetName:String;
      
      private var _buildingInfo:BuildingInfo;
      
      private var _buildingTypeDIO:BuildingTypeDIO;
      
      private var _spyMood:Boolean;
      
      public function MobileBuildingTooltipProductionProgressInfoView(param1:String, param2:BuildingInfo, param3:BuildingTypeDIO, param4:Boolean = false)
      {
         super();
         this.assetName = param1;
         _buildingInfo = param2;
         _buildingTypeDIO = param3;
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
         dataTextField = new MobileWomTextField();
         dataTextField.textRendererProperties.textFormat = getWomTextFormat(21,"center");
         dataTextField.width = 150;
         dataTextField.height = 24;
         addChild(dataTextField);
         _progressBar = MobileWomUIComponentFactory.createProgressBar("Yellow");
         _progressBar.width = 150;
         _progressBar.height = 33;
         _progressBar.align = "center";
         addChild(_progressBar);
         icon = assetRepository.getDisplayObject(assetName);
         addChild(icon);
      }
      
      public function drawLayout() : void
      {
         var _loc1_:int = 0;
         if(_spyMood)
         {
            _progressBar.x = 15;
            _progressBar.y = icon.height - _progressBar.height >> 1;
            dataTextField.x = _progressBar.width + 15 - dataTextField.width >> 1;
            dataTextField.y = 44;
         }
         else
         {
            _loc1_ = 7;
            dataTextField.x = 0;
            dataTextField.y = _loc1_;
            MobileAlignmentUtil.alignRightWithYMarginOf(icon,dataTextField,-_loc1_,20);
            MobileAlignmentUtil.alignRightOf(_progressBar,icon,-20);
         }
      }
      
      public function updateWithResourceProductionData(param1:Number, param2:Number, param3:Number) : void
      {
         var _loc5_:Number = NaN;
         var _loc4_:int = 0;
         if(dataTextField)
         {
            _loc5_ = (param1 - param2) / param3 * 60 * 60 * 1000;
            if(_loc5_ <= 0)
            {
               var _temp_2:* = dataTextField;
               var _loc6_:String = "ui.mainframe.city.tooltip.storagefull";
               _temp_2.text = peak.i18n.PText.INSTANCE.getText0(_loc6_);
            }
            else
            {
               var _temp_4:* = dataTextField;
               var _temp_3:* = "ui.mainframe.city.tooltip.fullin2";
               var _loc7_:String = Languages.activeLanguageId == "ar" ? LocalizedDateTimeUtil.getUserFriendlyTime(_loc5_) : DateTimeUtil.getFormattedTime(_loc5_);
               var _loc8_:String = _temp_3;
               _temp_4.text = peak.i18n.PText.INSTANCE.getText1(_loc8_,_loc7_);
            }
            _progressBar.maximum = param1;
            _progressBar.value = param2;
            _loc4_ = param2;
            if(_loc4_ < 0)
            {
               _loc4_ = 0;
            }
            _progressBar.label = NumberUtil.format(_loc4_);
         }
         drawLayout();
      }
      
      public function updateWithTaxData(param1:Number, param2:int, param3:int, param4:Number, param5:int) : void
      {
         var _loc7_:Number = param1 * param2 * 60 * 60 * 1000 / param5 >> 0;
         var _loc8_:int = getTimer();
         var _loc6_:Number = _loc8_ - param3 > param4 ? 0 : param4 - (_loc8_ - param3);
         if(_loc6_ <= 0)
         {
            var _temp_3:* = dataTextField;
            var _loc10_:String = "ui.mainframe.city.tooltip.full";
            _temp_3.text = peak.i18n.PText.INSTANCE.getText0(_loc10_);
         }
         else
         {
            var _temp_5:* = dataTextField;
            var _temp_4:* = "ui.mainframe.city.tooltip.fullin2";
            var _loc11_:String = Languages.activeLanguageId == "ar" ? LocalizedDateTimeUtil.getUserFriendlyTime(_loc6_) : DateTimeUtil.getFormattedTime(_loc6_);
            var _loc12_:String = _temp_4;
            _temp_5.text = peak.i18n.PText.INSTANCE.getText1(_loc12_,_loc11_);
         }
         var _loc9_:int = (_loc7_ - _loc6_) * param2 / _loc7_ >> 0;
         if(_loc9_ < 0)
         {
            _loc9_ = 0;
         }
         _progressBar.maximum = param2;
         _progressBar.value = _loc9_;
         _progressBar.label = NumberUtil.format(_loc9_);
         drawLayout();
      }
      
      public function updateWithStockPileData(param1:Number, param2:Number, param3:Number) : void
      {
         var _temp_2:* = dataTextField;
         var _temp_1:* = "ui.mainframe.city.tooltip.harvestable2";
         var _loc4_:String = NumberUtil.format(param3);
         var _loc5_:String = _temp_1;
         _temp_2.text = peak.i18n.PText.INSTANCE.getText1(_loc5_,_loc4_);
         _progressBar.maximum = param1;
         _progressBar.value = param2;
         var _temp_5:* = _progressBar;
         var _temp_3:* = "ui.common.percentage";
         var _loc6_:String = Math.ceil(param2 / param1 * 100).toString();
         var _loc7_:String = _temp_3;
         var _temp_4:* = peak.i18n.PText.INSTANCE.getText1(_loc7_,_loc6_) + " ";
         var _loc8_:String = "ui.mainframe.city.tooltip.full";
         _temp_5.label = _temp_4 + peak.i18n.PText.INSTANCE.getText0(_loc8_);
         drawLayout();
      }
      
      public function get buildingInfo() : BuildingInfo
      {
         return _buildingInfo;
      }
      
      public function get buildingTypeDIO() : BuildingTypeDIO
      {
         return _buildingTypeDIO;
      }
      
      public function get progressBar() : MobileWomProgressBar
      {
         return _progressBar;
      }
      
      override public function get height() : Number
      {
         return 40;
      }
      
      override public function get width() : Number
      {
         if(_spyMood)
         {
            return 15 + _progressBar.width;
         }
         return super.width;
      }
   }
}

