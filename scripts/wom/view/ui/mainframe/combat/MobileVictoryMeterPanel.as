package wom.view.ui.mainframe.combat
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Elastic;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.controller.event.ui.MobileVictoryMeterEvent;
   import wom.model.component.enum.ELOStarType;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   import wom.view.screen.windows.report.battlereport.MobileBattlePointsBigStarView;
   import wom.view.ui.common.MobileLightAnimationView;
   import wom.view.ui.tooltip.MobileVictoryTooltipView;
   
   public class MobileVictoryMeterPanel extends Sprite implements View
   {
      
      public static const LEVEL_DAMAGE_TABLE:Array = [[18,55,85],[19,57,87],[21,60,90],[23,62,92],[25,65,95]];
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _tooltipContainer:Sprite;
      
      private var _kValue:Number;
      
      private var background:DisplayObject;
      
      private var currentBPGainLabel:MobileWomTextField;
      
      private var currentBPGainTextField:MobileCaptionTextField;
      
      private var maxBPGainLabel:MobileWomTextField;
      
      private var maxBPGainTextField:MobileCaptionTextField;
      
      private var _starViews:Vector.<MobileBattlePointsSmallStarView>;
      
      private var thresholdViews:Vector.<DisplayObject>;
      
      private var victoryMeterBg:DisplayObject;
      
      private var badPerformanceMeter:MobileVictoryMeterProgressView;
      
      private var goodPerformanceMeter:MobileVictoryMeterProgressView;
      
      private var negatedPerformanceMeter:MobileVictoryMeterProgressView;
      
      private var _totalCityHP:Number;
      
      private var _initialCityHP:Number;
      
      private var _levelDiff:int;
      
      private var _performanceArray:Array;
      
      private var _tooltip:MobileVictoryTooltipView;
      
      private var _bigStar:MobileBattlePointsBigStarView;
      
      private var _light1:Sprite;
      
      private var _light2:Sprite;
      
      private var _ongoingAnimation:Boolean;
      
      private var _touchedStarIndex:int;
      
      public function MobileVictoryMeterPanel()
      {
         super();
      }
      
      private static function sumToZero(param1:int) : int
      {
         if(param1 == 0)
         {
            return -1;
         }
         var _loc3_:int = param1 - 1;
         var _loc2_:int = 0;
         while(_loc3_ > 0)
         {
            _loc2_ += _loc3_;
            _loc3_--;
         }
         return _loc2_;
      }
      
      [PostConstruct]
      public function init() : void
      {
         _levelDiff = 0;
         _ongoingAnimation = false;
         performanceArray = LEVEL_DAMAGE_TABLE[0];
         initLayout();
      }
      
      public function initLayout() : void
      {
         var _loc2_:int = 0;
         var _loc1_:MobileBattlePointsSmallStarView = null;
         _tooltipContainer = new Sprite();
         addChild(_tooltipContainer);
         background = assetRepository.getDisplayObject("BackgroundTransparentProtectionPanel");
         background.width = 472;
         background.height = 50;
         _tooltipContainer.addChild(background);
         currentBPGainLabel = new MobileWomTextField();
         currentBPGainLabel.textRendererProperties.textFormat = getWomTextFormat(17,"center");
         currentBPGainLabel.width = 66;
         currentBPGainLabel.height = 13;
         var _temp_4:* = currentBPGainLabel;
         var _loc3_:String = "ui.mainframe.combat.victorymeter.bpgain";
         _temp_4.text = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         _tooltipContainer.addChild(currentBPGainLabel);
         currentBPGainTextField = new MobileCaptionTextField();
         currentBPGainTextField.textRendererProperties.textFormat = getCaptionTextFormat(23,"center");
         currentBPGainTextField.width = 66;
         currentBPGainTextField.height = 20;
         _tooltipContainer.addChild(currentBPGainTextField);
         maxBPGainLabel = new MobileWomTextField();
         maxBPGainLabel.textRendererProperties.textFormat = getWomTextFormat(17,"center");
         maxBPGainLabel.width = 56;
         maxBPGainLabel.height = 13;
         var _temp_7:* = maxBPGainLabel;
         var _loc4_:String = "ui.mainframe.combat.victorymeter.maxbp";
         _temp_7.text = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _tooltipContainer.addChild(maxBPGainLabel);
         maxBPGainTextField = new MobileCaptionTextField();
         maxBPGainTextField.textRendererProperties.textFormat = getCaptionTextFormat(23,"center");
         maxBPGainTextField.width = 56;
         maxBPGainTextField.height = 20;
         _tooltipContainer.addChild(maxBPGainTextField);
         _starViews = new Vector.<MobileBattlePointsSmallStarView>(6,true);
         thresholdViews = new Vector.<DisplayObject>(3,true);
         victoryMeterBg = assetRepository.getDisplayObject("ProgressbarVictoryBase");
         _tooltipContainer.addChild(victoryMeterBg);
         badPerformanceMeter = new MobileVictoryMeterProgressView(assetRepository.getDisplayObject("ProgressbarVictoryRed"));
         _tooltipContainer.addChild(badPerformanceMeter);
         goodPerformanceMeter = new MobileVictoryMeterProgressView(assetRepository.getDisplayObject("ProgressbarVictoryGreen"));
         _tooltipContainer.addChild(goodPerformanceMeter);
         negatedPerformanceMeter = new MobileVictoryMeterProgressView(assetRepository.getDisplayObject("ProgressbarVictoryBlack"),false);
         _tooltipContainer.addChild(negatedPerformanceMeter);
         _loc2_ = 0;
         while(_loc2_ < _starViews.length)
         {
            _loc1_ = new MobileBattlePointsSmallStarView(assetRepository.getDisplayObject(ELOStarType.EMPTY.mobileSmallAssetName),ELOStarType.EMPTY);
            _tooltipContainer.addChild(_loc1_);
            _loc1_.setPaddings(10,10,10,10);
            _starViews[_loc2_] = _loc1_;
            _loc2_++;
         }
         _light1 = new MobileLightAnimationView();
         _light1.scaleX = _light1.scaleY = 2;
         addChild(_light1);
         _light1.visible = false;
         _bigStar = new MobileBattlePointsBigStarView(assetRepository.getDisplayObject(ELOStarType.POSITIVE.mobileBigAssetName),ELOStarType.POSITIVE);
         _bigStar.touchable = _bigStar.visible = false;
         addChild(_bigStar);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         var _loc1_:int = 0;
         MobileAlignmentUtil.alignAccordingToPositionOf(currentBPGainLabel,background,3,5);
         MobileAlignmentUtil.alignAccordingToPositionOf(currentBPGainTextField,background,3,21);
         MobileAlignmentUtil.alignAccordingToPositionOf(maxBPGainLabel,background,403,5);
         MobileAlignmentUtil.alignAccordingToPositionOf(maxBPGainTextField,background,403,21);
         MobileAlignmentUtil.alignAccordingToPositionOf(victoryMeterBg,background,78,24);
         MobileAlignmentUtil.alignAccordingToPositionOf(badPerformanceMeter,victoryMeterBg,1,1);
         MobileAlignmentUtil.alignAccordingToPositionOf(goodPerformanceMeter,victoryMeterBg,1,1);
         MobileAlignmentUtil.alignAccordingToPositionOf(negatedPerformanceMeter,victoryMeterBg,1,1);
         MobileAlignmentUtil.alignAccordingToPositionOf(_light1,_bigStar,_bigStar.width >> 1,_bigStar.height >> 1);
         _loc1_ = 0;
         while(_loc1_ < thresholdViews.length)
         {
            if(thresholdViews[_loc1_] != null)
            {
               thresholdViews[_loc1_].x = victoryMeterBg.x + _performanceArray[_loc1_] * victoryMeterBg.width / 100;
               thresholdViews[_loc1_].y = 18;
            }
            _loc1_++;
         }
         if(thresholdViews[0] != null)
         {
            MobileAlignmentUtil.alignAccordingToPositionOf(_starViews[0],thresholdViews[0],-8,0);
            MobileAlignmentUtil.alignAccordingToPositionOf(_starViews[1],thresholdViews[1],-14,0);
            MobileAlignmentUtil.alignAccordingToPositionOf(_starViews[2],_starViews[1],12,0);
            MobileAlignmentUtil.alignAccordingToPositionOf(_starViews[3],thresholdViews[2],-19,0);
            MobileAlignmentUtil.alignAccordingToPositionOf(_starViews[4],_starViews[3],11,0);
            MobileAlignmentUtil.alignAccordingToPositionOf(_starViews[5],_starViews[4],11,0);
         }
         _loc1_ = 0;
         while(_loc1_ < _starViews.length)
         {
            _starViews[_loc1_].y = 7;
            _loc1_++;
         }
      }
      
      public function animateStarGain() : void
      {
         trace("ongoing animation : " + _ongoingAnimation);
         if(_ongoingAnimation)
         {
            return;
         }
         _ongoingAnimation = true;
         _light1.visible = _bigStar.visible = true;
         _light1.alpha = _bigStar.alpha = 1;
         var _loc2_:int = visibleWidth >> 1;
         var _loc1_:int = parent ? ((parent as MobileCombatUILayer).visibleHeight >> 1) - 30 : 200;
         _bigStar.x = _loc2_ - (_bigStar.width >> 1);
         _bigStar.y = _loc1_ - (_bigStar.height >> 1);
         MobileAlignmentUtil.alignAccordingToPositionOf(_light1,_bigStar,_bigStar.width >> 1,_bigStar.height >> 1);
         TweenMax.from(_bigStar,0.5,{
            "alpha":0,
            "scaleX":0.25,
            "scaleY":0.25,
            "x":_bigStar.x + (_bigStar.width * 0.875 >> 1),
            "y":_bigStar.y + (_bigStar.height * 0.875 >> 1),
            "ease":Elastic.easeOut,
            "onComplete":onStarFirstAnimationComplete
         });
         TweenMax.from(_light1,0.45,{
            "alpha":0,
            "ease":Elastic.easeOut,
            "onComplete":onLightFirstAnimationComplete
         });
         TweenMax.to(_light1,2.6,{"rotation":240});
      }
      
      private function onLightFirstAnimationComplete() : void
      {
         TweenMax.to(_light1,0.9,{
            "delay":1.25,
            "alpha":0
         });
      }
      
      private function onStarFirstAnimationComplete() : void
      {
         TweenMax.to(_bigStar,0.4,{
            "delay":1.75,
            "scaleX":0.3,
            "scaleY":0.3,
            "x":visibleWidth >> 1,
            "y":20,
            "alpha":0,
            "onComplete":onAnimationComplete
         });
      }
      
      private function onAnimationComplete() : void
      {
         TweenMax.killTweensOf(_bigStar);
         TweenMax.killTweensOf(_light1);
         _bigStar.scaleX = _bigStar.scaleY = 1;
         _light1.visible = _bigStar.visible = false;
         _light1.alpha = _bigStar.alpha = 1;
         _light1.rotation = 1;
         _ongoingAnimation = false;
      }
      
      public function updateVictoryMeter(param1:Number, param2:int, param3:int, param4:Boolean, param5:Boolean, param6:Boolean, param7:Boolean, param8:Number = 0) : void
      {
         var _loc11_:Number = (_initialCityHP - param1 - param8) / _totalCityHP * 100;
         var _loc9_:Boolean = _loc11_ < _performanceArray[0];
         var _loc12_:Number = (_totalCityHP + param8 - _initialCityHP) / _totalCityHP * 100;
         badPerformanceMeter.visible = _loc9_;
         goodPerformanceMeter.visible = !_loc9_;
         badPerformanceMeter.updateProgress(_loc11_);
         goodPerformanceMeter.updateProgress(_loc11_);
         negatedPerformanceMeter.updateProgress(_loc12_);
         var _loc13_:int = calculatePerformanceIndex(_loc11_);
         if(!param6)
         {
            updateStars(_loc13_);
         }
         maxBPGainTextField.text = (param7 || param4 ? 0 : calculateBPGain(calculatePerformanceIndex((_initialCityHP - param8) / _totalCityHP * 100),param2,param3)).toString();
         var _loc10_:Boolean = !param7 && param4;
         var _loc14_:int = int(_loc10_ ? 0 : calculateBPGain(_loc13_,param2,param3));
         var _loc15_:String;
         currentBPGainTextField.text = _loc10_ ? (_loc15_ = "ui.common.na",peak.i18n.PText.INSTANCE.getText0(_loc15_)) : (param7 && _loc14_ > 0 ? "0" : _loc14_.toString());
         if(_tooltip)
         {
            if(_tooltip.type == 1)
            {
               _tooltip.updateWithData(_performanceArray[_touchedStarIndex == 0 ? 0 : int(_touchedStarIndex / 3) + 1],calculateBPGain((_touchedStarIndex == 0 ? 0 : int(_touchedStarIndex / 3) + 1) + 1,param2,param3),param4,param7);
            }
            else
            {
               _tooltip.updateWithData(_loc11_,_loc12_);
            }
         }
      }
      
      public function calculateBPGain(param1:int, param2:int, param3:int) : int
      {
         var _loc6_:Number = 1 / (1 + Math.pow(10,(param3 - param2) / 2095));
         var _loc5_:Number = Math.ceil(_kValue * (1 - _loc6_));
         var _loc7_:int = int(param1 == 1 ? 1 : (param1 == 2 ? 4 : (param1 == 3 ? 6 : param1)));
         var _loc4_:Number = -2 * (_kValue - _loc5_);
         return param1 < 1 ? (_loc4_ == 0 ? -2 : _loc4_) : _loc7_ * _loc5_;
      }
      
      private function updateStars(param1:int) : void
      {
         var _loc5_:int = 0;
         var _loc2_:Boolean = false;
         var _loc4_:Boolean = false;
         var _loc3_:int = sumToZero(param1);
         _loc5_ = 0;
         while(_loc5_ < _starViews.length)
         {
            if(_loc5_ <= _loc3_ + param1 - 1)
            {
               _loc2_ = updateStarView(_loc5_,ELOStarType.POSITIVE);
               if(_loc2_ == true)
               {
                  _loc4_ = true;
               }
            }
            else
            {
               _loc2_ = updateStarView(_loc5_,ELOStarType.EMPTY);
               if(_loc2_ == true)
               {
                  _loc4_ = true;
               }
            }
            _loc5_++;
         }
         if(_loc4_)
         {
            dispatchEvent(new MobileVictoryMeterEvent("starGained"));
            animateStarGain();
            drawLayout();
         }
      }
      
      private function updateStarView(param1:int, param2:ELOStarType) : Boolean
      {
         var _loc3_:Boolean = false;
         if(_starViews[param1].starType != param2)
         {
            _loc3_ = true;
            _tooltipContainer.removeChild(_starViews[param1]);
            _starViews[param1] = new MobileBattlePointsSmallStarView(assetRepository.getDisplayObject(param2.mobileSmallAssetName),param2);
            _tooltipContainer.addChild(_starViews[param1]);
         }
         return _loc3_;
      }
      
      public function setDamageThresholds(param1:int = 0, param2:int = 8, param3:Array = null) : void
      {
         var _loc6_:int = 0;
         var _loc4_:DisplayObject = null;
         _levelDiff = param1;
         _kValue = param2;
         this.performanceArray = param3 ? param3 : LEVEL_DAMAGE_TABLE[_levelDiff];
         clearThresholds();
         var _loc5_:int = _tooltipContainer.getChildIndex(negatedPerformanceMeter) + 1;
         _loc6_ = 0;
         while(_loc6_ < thresholdViews.length)
         {
            _loc4_ = assetRepository.getDisplayObject(_loc6_ == 0 ? "VictoryIndicator1" : "VictoryIndicator2");
            _tooltipContainer.addChildAt(_loc4_,_loc5_ + _loc6_);
            thresholdViews[_loc6_] = _loc4_;
            _loc6_++;
         }
         drawLayout();
      }
      
      private function clearThresholds() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < thresholdViews.length)
         {
            if(thresholdViews[_loc1_] != null && _tooltipContainer.contains(thresholdViews[_loc1_]))
            {
               _tooltipContainer.removeChild(thresholdViews[_loc1_]);
            }
            thresholdViews[_loc1_] = null;
            _loc1_++;
         }
      }
      
      public function calculatePerformanceIndex(param1:Number) : int
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _performanceArray.length)
         {
            if(param1 < _performanceArray[_loc2_])
            {
               break;
            }
            _loc2_++;
         }
         return _loc2_;
      }
      
      public function set performanceArray(param1:Array) : void
      {
         _performanceArray = param1;
      }
      
      public function get visibleWidth() : int
      {
         return background.width;
      }
      
      public function set totalCityHP(param1:Number) : void
      {
         _totalCityHP = param1;
      }
      
      public function get initialCityHP() : Number
      {
         return _initialCityHP;
      }
      
      public function set initialCityHP(param1:Number) : void
      {
         _initialCityHP = param1;
      }
      
      public function get starViews() : Vector.<MobileBattlePointsSmallStarView>
      {
         return _starViews;
      }
      
      public function get performanceArray() : Array
      {
         return _performanceArray;
      }
      
      public function get totalCityHP() : Number
      {
         return _totalCityHP;
      }
      
      public function get tooltipContainer() : Sprite
      {
         return _tooltipContainer;
      }
      
      public function set touchedStarIndex(param1:int) : void
      {
         _touchedStarIndex = param1;
      }
      
      public function set tooltip(param1:MobileVictoryTooltipView) : void
      {
         _tooltip = param1;
      }
      
      public function visibleHeight() : int
      {
         return background.height;
      }
   }
}

