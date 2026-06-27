package wom.view.ui.tooltip
{
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   
   public class MobileVictoryTooltipView extends MobileBaseTooltipView
   {
      
      public static const VIEW_WIDTH:Number = 285;
      
      public static const VIEW_HEIGHT:Number = 111;
      
      public static const STAR_ICON:int = 1;
      
      public static const VICTORY_PANEL:int = 2;
      
      private var label1:MobileCaptionTextField;
      
      private var label2:MobileCaptionTextField;
      
      private var textField1:MobileWomTextField;
      
      private var textField2:MobileWomTextField;
      
      private var _type:int;
      
      public function MobileVictoryTooltipView(param1:int)
      {
         super(285,111,false);
         _type = param1;
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.mainframe.combat.tooltip." + (_type == 1 ? "damageinflicted" : "currentcombatdamage");
         label1 = createLabel(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         var _loc2_:String = "ui.mainframe.combat.tooltip." + (_type == 1 ? "currentbpgain" : "previousdamage");
         label2 = createLabel(peak.i18n.PText.INSTANCE.getText0(_loc2_));
         textField1 = createTextField();
         textField2 = createTextField();
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
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         MobileAlignmentUtil.alignAccordingToPositionOf(label1,_bg,24,26);
         MobileAlignmentUtil.alignBelowOf(label2,label1,8);
         MobileAlignmentUtil.alignAccordingToPositionOf(textField1,label1,196,-2);
         MobileAlignmentUtil.alignAccordingToPositionOf(textField2,label2,196,-2);
      }
      
      public function updateWithData(param1:int, param2:int, param3:Boolean = false, param4:Boolean = false) : void
      {
         if(textField1)
         {
            var _temp_2:* = textField1;
            var _temp_1:* = "ui.common.percentage";
            var _loc5_:int = param1;
            var _loc6_:String = _temp_1;
            _temp_2.text = peak.i18n.PText.INSTANCE.getText1(_loc6_,_loc5_);
            var _temp_3:*;
            var _loc7_:int;
            var _loc8_:String;
            textField2.text = _type == 2 ? (_temp_3 = "ui.common.percentage",_loc7_ = param2,_loc8_ = _temp_3,peak.i18n.PText.INSTANCE.getText1(_loc8_,_loc7_)) : (param3 ? "-" : (param2 > 0 ? (param4 ? "0" : "+" + param2) : param2.toString()));
            drawLayout();
         }
      }
      
      public function get type() : int
      {
         return _type;
      }
   }
}

