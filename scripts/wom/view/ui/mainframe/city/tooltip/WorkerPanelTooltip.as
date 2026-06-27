package wom.view.ui.mainframe.city.tooltip
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.util.LocalizedDateTimeUtil;
   
   public class WorkerPanelTooltip extends Sprite implements View
   {
      
      public var tooltipBackground:DisplayObject;
      
      public var infoBackground:DisplayObject;
      
      public var typeLabel:CaptionTextField;
      
      public var workersIdleField:CaptionTextField;
      
      public var workersIdleLabel:CaptionTextField;
      
      public var availableInField:CaptionTextField;
      
      public var availableInLabel:CaptionTextField;
      
      public var workersToBuyField:CaptionTextField;
      
      public var workersToBuyLabel:CaptionTextField;
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      public function WorkerPanelTooltip()
      {
         super();
         visible = false;
      }
      
      public function updateWithData(param1:int, param2:int, param3:Number, param4:int) : void
      {
         if(workersIdleField)
         {
            workersIdleField.text = param2 + "/" + param1;
            var _loc5_:String;
            availableInField.text = param3 == 0 ? (_loc5_ = "ui.mainframe.city.tooltip.allworkersavailable",peak.i18n.PText.INSTANCE.getText0(_loc5_)) : LocalizedDateTimeUtil.getUserFriendlyTime(param3);
            workersToBuyField.text = "" + param4;
         }
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         tooltipBackground = assetRepository.getDisplayObject("TooltipBackgroundSkin");
         tooltipBackground.width = 196;
         tooltipBackground.height = 105;
         addChild(tooltipBackground);
         infoBackground = assetRepository.getDisplayObject("TooltipInnerBackground");
         infoBackground.width = 183;
         infoBackground.height = 67;
         addChild(infoBackground);
         typeLabel = new CaptionTextField(WomTextFormats.BLACK_FILTER);
         typeLabel.defaultTextFormat = WomTextFormats.FONT_SIZE_20;
         typeLabel.autoSize = "left";
         var _temp_4:* = typeLabel;
         var _loc2_:String = "ui.mainframe.city.tooltip.workers";
         _temp_4.text = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         addChild(typeLabel);
         var _loc1_:int = 16;
         workersIdleLabel = new CaptionTextField(new GlowFilter(6904072,1,5,5,10,1));
         workersIdleLabel.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         workersIdleLabel.autoSize = "left";
         var _temp_6:* = workersIdleLabel;
         var _loc3_:String = "ui.mainframe.city.tooltip.workersidle";
         _temp_6.text = peak.i18n.PText.INSTANCE.getText0(_loc3_) + ":";
         addChild(workersIdleLabel);
         availableInLabel = new CaptionTextField(new GlowFilter(6904072,1,5,5,10,1));
         availableInLabel.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         availableInLabel.autoSize = "left";
         var _temp_8:* = availableInLabel;
         var _loc4_:String = "ui.mainframe.city.tooltip.availablein";
         _temp_8.text = peak.i18n.PText.INSTANCE.getText0(_loc4_) + ":";
         addChild(availableInLabel);
         workersToBuyLabel = new CaptionTextField(new GlowFilter(6904072,1,5,5,10,1));
         workersToBuyLabel.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         workersToBuyLabel.autoSize = "left";
         var _temp_10:* = workersToBuyLabel;
         var _loc5_:String = "ui.mainframe.city.tooltip.workerstobuy";
         _temp_10.text = peak.i18n.PText.INSTANCE.getText0(_loc5_) + ":";
         addChild(workersToBuyLabel);
         workersIdleField = new CaptionTextField(WomTextFormats.BLACK_FILTER);
         workersIdleField.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         workersIdleField.autoSize = "left";
         addChild(workersIdleField);
         availableInField = new CaptionTextField(WomTextFormats.BLACK_FILTER);
         availableInField.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         availableInField.autoSize = "left";
         addChild(availableInField);
         workersToBuyField = new CaptionTextField(WomTextFormats.BLACK_FILTER);
         workersToBuyField.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         workersToBuyField.autoSize = "left";
         addChild(workersToBuyField);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 3;
         tooltipBackground.x = 0;
         tooltipBackground.y = 0;
         infoBackground.x = 6;
         infoBackground.y = 30;
         typeLabel.x = 10;
         typeLabel.y = 5;
         workersIdleLabel.x = 8;
         workersIdleLabel.y = 34;
         AlignmentUtil.alignBelowOf(availableInLabel,workersIdleLabel,_loc1_);
         AlignmentUtil.alignBelowOf(workersToBuyLabel,availableInLabel,_loc1_);
         AlignmentUtil.alignRightOf(workersIdleField,workersIdleLabel,_loc2_);
         AlignmentUtil.alignRightOf(availableInField,availableInLabel,_loc2_);
         AlignmentUtil.alignRightOf(workersToBuyField,workersToBuyLabel,_loc2_);
      }
   }
}

