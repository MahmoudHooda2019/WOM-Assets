package wom.view.ui.mainframe.city.tooltip
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import peak.i18n.PText;
   import peak.util.NumberUtil;
   import wom.model.dto.BeastCannonInfoDTO;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.progressbar.MaskedProgressBar;
   import wom.view.component.progressbar.ProgressBar19;
   
   public class BuildingTooltipBeastCannonView extends BuildingTooltipDefenceView
   {
      
      public var timeTextField:WomTextField;
      
      public var progressBar:MaskedProgressBar;
      
      public var bulletImage:DisplayObject;
      
      private var tooltipInitialized:Boolean;
      
      public function BuildingTooltipBeastCannonView(param1:WomAssetRepository)
      {
         super(param1);
         tooltipInitialized = false;
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         timeTextField = new WomTextField();
         timeTextField.autoSize = "left";
         timeTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_18;
         addChild(timeTextField);
         progressBar = new ProgressBar19();
         progressBar.align = "center";
         progressBar.width = 180 - 70;
         addChild(progressBar);
         bulletImage = assetRepository.getDisplayObject("BombsTooltipIcon");
         bulletImage.addEventListener("change",onAssetChange,false,0,true);
         addChild(bulletImage);
         tooltipInitialized = true;
         drawLayout();
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         if(tooltipInitialized)
         {
            progressBar.x = 180 - progressBar.width >> 1;
            progressBar.y = 35;
            timeTextField.x = 180 - timeTextField.width >> 1;
            timeTextField.y = 55;
            bulletImage.x = progressBar.x - (bulletImage.width >> 1);
            bulletImage.y = progressBar.y - 6;
         }
      }
      
      public function updateWithCannonData(param1:Number, param2:int, param3:BeastCannonInfoDTO, param4:int) : void
      {
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         updateWithData(param1,param2);
         if(param3.remainingTimeToRecharge <= 0)
         {
            var _temp_1:* = timeTextField;
            var _loc8_:String = "ui.mainframe.city.tooltip.catapultready";
            _temp_1.text = peak.i18n.PText.INSTANCE.getText0(_loc8_);
         }
         else
         {
            _loc6_ = param3.remainingTimeToRecharge / 1000;
            _loc5_ = _loc6_ / 60;
            _loc7_ = _loc5_ / 60;
            _loc6_ %= 60;
            _loc5_ %= 60;
            _loc7_ %= 24;
            timeTextField.text = (_loc7_ < 10 ? "0" : "") + _loc7_ + ":" + ((_loc5_ < 10 ? "0" : "") + _loc5_ + ":") + ((_loc6_ < 10 ? "0" : "") + _loc6_);
         }
         progressBar.setProgress(param3.ammoAmount,param4);
         progressBar.progressText = NumberUtil.format(param3.ammoAmount);
         drawLayout();
      }
      
      private function onAssetChange(param1:Event) : void
      {
         drawLayout();
      }
   }
}

