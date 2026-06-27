package wom.view.ui.tooltip
{
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import peak.util.NumberUtil;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   
   public class MobileExperiencePointsTooltipView extends MobileBaseTooltipView
   {
      
      public static const VIEW_WIDTH:Number = 350;
      
      public static const VIEW_HEIGHT:Number = 126;
      
      private var currentXPLabel:MobileCaptionTextField;
      
      private var untilNextLevelLabel:MobileCaptionTextField;
      
      private var currentXPTextField:MobileWomTextField;
      
      private var untilNextLevelTextField:MobileWomTextField;
      
      public function MobileExperiencePointsTooltipView()
      {
         super(350,126,false);
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.mainframe.city.tooltip.xp";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         var _loc2_:String = "ui.mainframe.city.tooltip.currentxp";
         currentXPLabel = createLabel(peak.i18n.PText.INSTANCE.getText0(_loc2_) + ":");
         var _loc3_:String = "ui.mainframe.city.tooltip.untilnextlevel";
         untilNextLevelLabel = createLabel(peak.i18n.PText.INSTANCE.getText0(_loc3_) + ":");
         currentXPTextField = createTextField();
         untilNextLevelTextField = createTextField();
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         MobileAlignmentUtil.alignAccordingToPositionOf(currentXPLabel,_bg,40,38);
         MobileAlignmentUtil.alignBelowOf(untilNextLevelLabel,currentXPLabel,8);
         MobileAlignmentUtil.alignAccordingToPositionOf(currentXPTextField,currentXPLabel,178,-2);
         MobileAlignmentUtil.alignAccordingToPositionOf(untilNextLevelTextField,untilNextLevelLabel,178,-2);
      }
      
      public function updateWithData(param1:Number, param2:Number) : void
      {
         if(currentXPTextField)
         {
            param2 = Math.floor(param2);
            currentXPTextField.text = NumberUtil.format(param1);
            untilNextLevelTextField.text = NumberUtil.format(param2);
            drawLayout();
         }
      }
      
      private function createLabel(param1:String) : MobileCaptionTextField
      {
         var _loc2_:MobileCaptionTextField = new MobileCaptionTextField();
         _loc2_.textRendererProperties.textFormat = getCaptionTextFormat(25);
         addChild(_loc2_);
         _loc2_.text = param1;
         return _loc2_;
      }
      
      private function createTextField() : MobileWomTextField
      {
         var _loc1_:MobileWomTextField = new MobileWomTextField();
         _loc1_.textRendererProperties.textFormat = getWomTextFormat(25);
         addChild(_loc1_);
         return _loc1_;
      }
   }
}

