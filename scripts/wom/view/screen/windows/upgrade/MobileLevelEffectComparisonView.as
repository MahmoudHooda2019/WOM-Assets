package wom.view.screen.windows.upgrade
{
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import peak.util.NumberUtil;
   import starling.display.Sprite;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.component.progressbar.MobileWomProgressBar;
   import wom.view.getCaptionTextFormat;
   
   public class MobileLevelEffectComparisonView extends Sprite
   {
      
      private var _effectTextField:MPTextField;
      
      private var _currentLevelProgressBar:MobileWomProgressBar;
      
      private var _nextLevelProgressBar:MobileWomProgressBar;
      
      private var _effectName:String;
      
      private var _currentLevelValue:Number;
      
      private var _nextLevelValue:Number;
      
      private var _maxValue:Number;
      
      private var _unitKey:String;
      
      private var _labelWidth:int;
      
      private var _progressBarWidth:int;
      
      private var _labelMargin:int;
      
      private var _progressBarMargin:int;
      
      public function MobileLevelEffectComparisonView(param1:String, param2:Number = 0, param3:Number = 0, param4:Number = 100, param5:String = null, param6:int = 140, param7:int = 360, param8:int = 10)
      {
         super();
         _effectName = param1;
         _currentLevelValue = param2;
         _nextLevelValue = param3;
         _maxValue = param4;
         _unitKey = param5;
         _labelWidth = param6;
         _progressBarWidth = param7;
         _labelMargin = param8;
         _progressBarMargin = 10;
         init();
      }
      
      public function init() : void
      {
         initLayout();
      }
      
      private function initLayout() : void
      {
         _effectTextField = new MobileCaptionTextField();
         _effectTextField.textRendererProperties.textFormat = getCaptionTextFormat(21);
         _effectTextField.height = 36;
         addChild(_effectTextField);
         _effectTextField.text = _effectName;
         _nextLevelProgressBar = MobileWomUIComponentFactory.createProgressBar("Blue");
         _nextLevelProgressBar.width = _progressBarWidth;
         _nextLevelProgressBar.height = 36;
         _nextLevelProgressBar.minimum = 0;
         _nextLevelProgressBar.maximum = _maxValue;
         addChild(_nextLevelProgressBar);
         _currentLevelProgressBar = MobileWomUIComponentFactory.createNoBgProgressBar("Yellow");
         _currentLevelProgressBar.width = _progressBarWidth;
         _currentLevelProgressBar.height = 36;
         _currentLevelProgressBar.minimum = 0;
         _currentLevelProgressBar.maximum = _maxValue;
         _currentLevelProgressBar.align = "center";
         addChild(_currentLevelProgressBar);
         updateWithComparisonInfo(_currentLevelValue,_nextLevelValue,_maxValue);
      }
      
      public function updateWithComparisonInfo(param1:Number, param2:Number, param3:Number) : void
      {
         _currentLevelValue = param1;
         _nextLevelValue = param2;
         _maxValue = param3;
         _nextLevelProgressBar.maximum = _maxValue;
         _currentLevelProgressBar.maximum = _maxValue;
         var _loc5_:Number = Math.abs(_nextLevelValue - _currentLevelValue);
         var _loc4_:String = _nextLevelValue > _currentLevelValue ? " + " : (_nextLevelValue < _currentLevelValue ? " - " : null);
         if(_loc4_)
         {
            var _temp_5:*;
            var _temp_7:*;
            var _temp_6:*;
            var _loc6_:Number;
            var _loc7_:String;
            var _loc8_:Number;
            var _loc9_:String;
            _currentLevelProgressBar.label = _unitKey ? (_temp_5 = _unitKey,_loc6_ = _currentLevelValue,_loc7_ = _temp_5,_temp_7 = peak.i18n.PText.INSTANCE.getText1(_loc7_,_loc6_) + _loc4_,_temp_6 = _unitKey,_loc8_ = _loc5_,_loc9_ = _temp_6,_temp_7 + peak.i18n.PText.INSTANCE.getText1(_loc9_,_loc8_)) : "" + NumberUtil.numberFormat(_currentLevelValue) + _loc4_ + NumberUtil.numberFormat(_loc5_);
         }
         else
         {
            var _temp_8:*;
            var _loc10_:Number;
            var _loc11_:String;
            _currentLevelProgressBar.label = _unitKey ? (_temp_8 = _unitKey,_loc10_ = _currentLevelValue,_loc11_ = _temp_8,peak.i18n.PText.INSTANCE.getText1(_loc11_,_loc10_)) : "" + NumberUtil.numberFormat(_currentLevelValue);
         }
         if(_nextLevelValue < _currentLevelValue)
         {
            _nextLevelProgressBar.value = _currentLevelValue;
            _currentLevelProgressBar.value = _nextLevelValue;
         }
         else
         {
            _nextLevelProgressBar.value = _nextLevelValue;
            _currentLevelProgressBar.value = _currentLevelValue;
         }
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(_nextLevelProgressBar,_effectTextField,_labelWidth + _labelMargin + _progressBarMargin,-9);
         MobileAlignmentUtil.alignAccordingToPositionOf(_currentLevelProgressBar,_nextLevelProgressBar,0,0);
      }
      
      public function get labelWidth() : int
      {
         return _labelWidth;
      }
      
      public function set labelWidth(param1:int) : void
      {
         _labelWidth = param1;
      }
      
      public function get progressBarWidth() : int
      {
         return _progressBarWidth;
      }
      
      public function set progressBarWidth(param1:int) : void
      {
         _progressBarWidth = param1;
      }
      
      public function get labelMargin() : int
      {
         return _labelMargin;
      }
      
      public function set labelMargin(param1:int) : void
      {
         _labelMargin = param1;
      }
      
      public function get progressBarMargin() : int
      {
         return _progressBarMargin;
      }
      
      public function set progressBarMargin(param1:int) : void
      {
         _progressBarMargin = param1;
      }
      
      public function set effectName(param1:String) : void
      {
         _effectTextField.text = _effectName = param1;
      }
   }
}

