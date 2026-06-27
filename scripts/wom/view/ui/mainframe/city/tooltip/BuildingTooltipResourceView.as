package wom.view.ui.mainframe.city.tooltip
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.utils.getTimer;
   import peak.i18n.PText;
   import peak.i18n.lang.Languages;
   import peak.util.DateTimeUtil;
   import peak.util.NumberUtil;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.progressbar.MaskedProgressBar;
   import wom.view.component.progressbar.ProgressBar15;
   import wom.view.util.LocalizedDateTimeUtil;
   
   public class BuildingTooltipResourceView extends Sprite
   {
      
      public var timeTextField:WomTextField;
      
      public var resourceImage:DisplayObject;
      
      public var progressBar:MaskedProgressBar;
      
      public var assetRepository:WomAssetRepository;
      
      public var assetName:String;
      
      public function BuildingTooltipResourceView(param1:WomAssetRepository, param2:String)
      {
         super();
         this.assetRepository = param1;
         this.assetName = param2;
         init();
      }
      
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         timeTextField = new WomTextField();
         timeTextField.autoSize = "left";
         timeTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_18;
         addChild(timeTextField);
         progressBar = new ProgressBar15();
         progressBar.align = "center";
         progressBar.width = 180 - 70;
         addChild(progressBar);
         resourceImage = assetRepository.getDisplayObject(assetName);
         if(assetName != "Gold27")
         {
            resourceImage.width *= 0.7;
            resourceImage.height *= 0.7;
         }
         addChild(resourceImage);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         resourceImage.x = 25;
         resourceImage.y = 5;
         progressBar.x = 40;
         progressBar.y = resourceImage.y + (resourceImage.height - 15 >> 1);
         timeTextField.x = 180 - timeTextField.width >> 1;
         timeTextField.y = 33;
      }
      
      public function updateWithData(param1:Number, param2:Number, param3:Number) : void
      {
         var _loc5_:Number = NaN;
         var _loc4_:int = 0;
         if(timeTextField)
         {
            _loc5_ = (param1 - param2) / param3 * 60 * 60 * 1000;
            if(_loc5_ <= 0)
            {
               var _temp_2:* = timeTextField;
               var _loc6_:String = "ui.mainframe.city.tooltip.storagefull";
               _temp_2.text = peak.i18n.PText.INSTANCE.getText0(_loc6_);
            }
            else
            {
               var _temp_4:* = timeTextField;
               var _temp_3:* = "ui.mainframe.city.tooltip.fullin2";
               var _loc7_:String = Languages.activeLanguageId == "ar" ? LocalizedDateTimeUtil.getUserFriendlyTime(_loc5_) : DateTimeUtil.getFormattedTime(_loc5_);
               var _loc8_:String = _temp_3;
               _temp_4.text = peak.i18n.PText.INSTANCE.getText1(_loc8_,_loc7_);
            }
            progressBar.setProgress(resourceImage.width / 2 * param1 / progressBar.width + param2 * (progressBar.width - resourceImage.width / 2) / progressBar.width,param1);
            _loc4_ = param2;
            if(_loc4_ < 0)
            {
               _loc4_ = 0;
            }
            progressBar.progressText = NumberUtil.format(_loc4_);
         }
         drawLayout();
      }
      
      public function updateTaxView(param1:int, param2:Number, param3:int, param4:int, param5:Number, param6:int) : void
      {
         var _loc8_:Number = param2 * param3 * 60 * 60 * 1000 / param6 >> 0;
         var _loc9_:int = getTimer();
         var _loc7_:Number = _loc9_ - param4 > param5 ? 0 : param5 - (_loc9_ - param4);
         if(_loc7_ <= 0)
         {
            var _temp_3:* = timeTextField;
            var _loc11_:String = "ui.mainframe.city.tooltip.full";
            _temp_3.text = peak.i18n.PText.INSTANCE.getText0(_loc11_);
         }
         else
         {
            var _temp_5:* = timeTextField;
            var _temp_4:* = "ui.mainframe.city.tooltip.fullin2";
            var _loc12_:String = Languages.activeLanguageId == "ar" ? LocalizedDateTimeUtil.getUserFriendlyTime(_loc7_) : DateTimeUtil.getFormattedTime(_loc7_);
            var _loc13_:String = _temp_4;
            _temp_5.text = peak.i18n.PText.INSTANCE.getText1(_loc13_,_loc12_);
         }
         var _loc10_:int = (_loc8_ - _loc7_) * param3 / _loc8_ >> 0;
         if(_loc10_ < 0)
         {
            _loc10_ = 0;
         }
         progressBar.setProgress(resourceImage.width / 2 * param3 / progressBar.width + _loc10_ * (progressBar.width - resourceImage.width / 2) / progressBar.width,param3);
         progressBar.progressText = NumberUtil.format(_loc10_);
         drawLayout();
      }
   }
}

