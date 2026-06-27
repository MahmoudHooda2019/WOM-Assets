package wom.view.screen.windows.upgrade
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.progressbar.ProgressBar26;
   import wom.view.component.progressbar.WomProgressBar;
   
   public class LevelEffectComparisonView extends Sprite
   {
      
      private var _effectTextField:TextField;
      
      private var _currentLevelProgressBar:WomProgressBar;
      
      private var _nextLevelProgressBar:WomProgressBar;
      
      private var _effectName:String;
      
      private var _currentLevelValue:Number;
      
      private var _nextLevelValue:Number;
      
      private var _maxValue:Number;
      
      private var _unitKey:String;
      
      private var _labelWidth:int;
      
      private var _progressBarWidth:int;
      
      private var _labelMargin:int;
      
      private var _progressBarMargin:int;
      
      public function LevelEffectComparisonView(param1:String, param2:Number, param3:Number, param4:Number, param5:String = null)
      {
         super();
         _effectName = param1;
         _currentLevelValue = param2;
         _nextLevelValue = param3;
         _maxValue = param4;
         _unitKey = param5;
         _labelWidth = 120;
         _progressBarWidth = 160;
         _labelMargin = 16;
         _progressBarMargin = 6;
         init();
      }
      
      public function init() : void
      {
         initLayout();
      }
      
      private function initLayout() : void
      {
         _effectTextField = new CaptionTextField(WomTextFormats.DEFAULT_FILTER);
         _effectTextField.defaultTextFormat = WomTextFormats.RIGHT_16;
         _effectTextField.height = 20;
         addChild(_effectTextField);
         _currentLevelProgressBar = new ProgressBar26();
         _currentLevelProgressBar.maximum = _maxValue;
         addChild(_currentLevelProgressBar);
         _nextLevelProgressBar = new ProgressBar26();
         _nextLevelProgressBar.maximum = _maxValue;
         addChild(_nextLevelProgressBar);
         updateWithComparisonInfo();
      }
      
      public function updateWithComparisonInfo() : void
      {
         _effectTextField.text = _effectName;
         _currentLevelProgressBar.setProgress(_currentLevelValue,_maxValue);
         var _temp_1:*;
         var _loc1_:Number;
         var _loc2_:String;
         _currentLevelProgressBar.progressText = _unitKey ? (_temp_1 = _unitKey,_loc1_ = _currentLevelValue,_loc2_ = _temp_1,peak.i18n.PText.INSTANCE.getText1(_loc2_,_loc1_)) : _currentLevelValue.toString();
         _nextLevelProgressBar.setProgress(_nextLevelValue,_maxValue);
         var _temp_2:*;
         var _loc3_:Number;
         var _loc4_:String;
         _nextLevelProgressBar.progressText = _unitKey ? (_temp_2 = _unitKey,_loc3_ = _nextLevelValue,_loc4_ = _temp_2,peak.i18n.PText.INSTANCE.getText1(_loc4_,_loc3_)) : _nextLevelValue.toString();
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         _effectTextField.x = 10;
         _effectTextField.y = 3;
         _effectTextField.width = _labelWidth;
         _currentLevelProgressBar.width = _progressBarWidth;
         _nextLevelProgressBar.width = _progressBarWidth;
         _currentLevelProgressBar.x = _effectTextField.x + _effectTextField.width + _labelMargin;
         _currentLevelProgressBar.y = 0;
         AlignmentUtil.alignRightOf(_nextLevelProgressBar,_currentLevelProgressBar,6);
      }
      
      public function get currentLevelProgressBar() : WomProgressBar
      {
         return _currentLevelProgressBar;
      }
      
      public function get nextLevelProgressBar() : WomProgressBar
      {
         return _nextLevelProgressBar;
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
   }
}

