package wom.view.screen
{
   import peak.component.mobile.MPBitmapFontTextFormat;
   import peak.component.mobile.MPTextField;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.getCaptionTextFormat;
   import wom.view.ui.common.MobileCondenseButtonView;
   
   public class MobileBoostButtonView extends MobileCondenseButtonView
   {
      
      private var _boostLabelBackground:DisplayObject;
      
      private var _boostAmountTF:MPTextField;
      
      private var _boostAmountStr:String;
      
      private var _durationTF:MPTextField;
      
      private var _cooldownTF:MPTextField;
      
      public function MobileBoostButtonView(param1:String, param2:String, param3:String, param4:String, param5:String, param6:Number = 1, param7:Number = 1)
      {
         super(param1,param2,param3,param4,param6,param7,"Green","Gray");
         _boostAmountStr = param5;
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         _boostLabelBackground = assetRepository.getDisplayObject("IconBoostLabel");
         addChild(_boostLabelBackground);
         _boostAmountTF = new MobileCaptionTextField();
         _boostAmountTF.textRendererProperties.textFormat = getCaptionTextFormat(17);
         addChild(_boostAmountTF);
         _boostAmountTF.text = _boostAmountStr;
         drawLayout();
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         if(_boostLabelBackground)
         {
            MobileAlignmentUtil.alignAccordingToPositionOf(_boostLabelBackground,_button,19,30);
         }
         if(_boostAmountTF)
         {
            _boostAmountTF.validate();
            if(_boostAmountTF.width != 0)
            {
               MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_boostAmountTF,_boostLabelBackground,5);
            }
            else
            {
               MobileAlignmentUtil.alignAccordingToPositionOf(_boostAmountTF,_boostLabelBackground,5,5);
            }
         }
         if(_cooldownTF)
         {
            MobileAlignmentUtil.alignAccordingToPositionOf(_cooldownTF,_button,65,11);
            MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_durationTF,_cooldownTF,20);
         }
      }
      
      public function set boostAmountLabel(param1:String) : void
      {
         _boostAmountTF.text = param1;
      }
      
      public function get boostAmountLabel() : String
      {
         return _boostAmountTF.text;
      }
      
      override protected function initIcon() : void
      {
         super.initIcon();
         if(_boostLabelBackground)
         {
            setChildIndex(_icon,getChildIndex(_boostLabelBackground) - 1);
         }
      }
      
      public function activateCooldownLabel(param1:String, param2:String, param3:MPBitmapFontTextFormat = null) : void
      {
         _button.isEnabled = false;
         _subIconLabel.visible = false;
         _mainLabel.visible = false;
         _cooldownTF = new MobileCaptionTextField();
         _cooldownTF.textRendererProperties.textFormat = param3 != null ? param3 : getCaptionTextFormat(21,"center");
         _cooldownTF.width = 65;
         addChild(_cooldownTF);
         _cooldownTF.text = param1;
         _durationTF = new MobileCaptionTextField();
         _durationTF.textRendererProperties.textFormat = param3 != null ? param3 : getCaptionTextFormat(21,"center");
         _durationTF.width = 65;
         addChild(_durationTF);
         _durationTF.text = param2;
         drawLayout();
      }
      
      public function deactivateCooldownLabel() : void
      {
         _button.isEnabled = true;
         _subIconLabel.visible = true;
         _mainLabel.visible = true;
         removeChild(_cooldownTF);
         removeChild(_durationTF);
      }
      
      public function setDurationText(param1:String) : void
      {
         _durationTF.text = param1;
      }
      
      public function isCooldownActive() : Boolean
      {
         return !_mainLabel.visible;
      }
      
      public function resetSubIconLabel(param1:String, param2:String) : void
      {
         _subIconId = param1;
         _subLabelStr = param2;
         if(_subIconLabel && getChildIndex(_subIconLabel) != -1)
         {
            removeChild(_subIconLabel);
         }
         initSubIconLabel();
         drawLayout();
      }
   }
}

