package wom.view.screen.windows.hiringquarters
{
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.logging.log;
   import peak.util.MobileAlignmentUtil;
   import peak.util.NumberUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.game.hiring.HiringQueueInfo;
   import wom.model.game.hiring.HiringSlotView;
   import wom.model.game.window.WindowEnumeration;
   import wom.service.logging.WomLoggerContexts;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.component.progressbar.MobileWomProgressBar;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   import wom.view.util.MobileFullScreenWindow;
   
   public class MobileCentralHiringQuartersWindow extends MobileFullScreenWindow
   {
      
      private var inQueueBackground:DisplayObject;
      
      private var hiringQuartersSprite:Sprite;
      
      private var hiringQuartersBackground:DisplayObject;
      
      private var ironAsset:DisplayObject;
      
      private var _ironProgressBar:MobileWomProgressBar;
      
      private var _topOffIronButton:MobileWomButton;
      
      private var _selectMercenaryPanel:MobileHiringQuartersMercenaryPanel;
      
      private var inQueueHeader:MPTextField;
      
      private var _queuedMercenaryViews:Vector.<MobileHiringQuartersMercenaryView>;
      
      private var _queuedMercenaryBackgrounds:Array;
      
      private var _queuedMercenaryThreeDotIcons:Array;
      
      private var hiringQuarterStatusHeader:MPTextField;
      
      private var mercenaryInProgressHatcheryLabels:Array;
      
      private var _mercenaryInProgressStatusTextFields:Array;
      
      private var _mercenaryInProgressRemainingTimeTFs:Array;
      
      private var _mercenaryInProgressStatusBackgrounds:Array;
      
      private var _mercenaryInProgressViews:Array;
      
      private var _mercenaryInProgressBackgrounds:Array;
      
      private var hiringQuarterLockedIcons:Array;
      
      private var hiringQuarterThreeDotIcons:Array;
      
      private var housingSpaceProgressBar:MobileWomProgressBar;
      
      private var queuedSpaceProgressBar:MobileWomProgressBar;
      
      private var housingRatioTextField:MPTextField;
      
      private var queuedUpLabel:MPTextField;
      
      private var _totalHousingTextField:MPTextField;
      
      private var _speedupButton:MobileWomButton;
      
      private var _finishNowButton:MobileWomButton;
      
      private var _buildingInstanceId:int;
      
      private var _hiringQuarterIds:Array;
      
      private var _dontAskForOverflow:Boolean = false;
      
      private var _isFirstUpdate:Boolean = true;
      
      public function MobileCentralHiringQuartersWindow(param1:int, param2:int = 10, param3:Vector.<WindowEnumeration> = null)
      {
         super(true,param3);
         _buildingInstanceId = param1;
         _hiringQuarterIds = [];
      }
      
      override protected function initLayout() : void
      {
         var _loc5_:int = 0;
         var _loc2_:MPTextField = null;
         var _loc1_:DisplayObject = null;
         var _loc4_:MPTextField = null;
         var _loc3_:MPTextField = null;
         super.initLayout();
         var _loc6_:String = "ui.windows.centralhiring.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc6_));
         _ironProgressBar = MobileWomUIComponentFactory.createProgressBar("Iron");
         _ironProgressBar.width = 90;
         _ironProgressBar.height = 27;
         _ironProgressBar.minimum = 0;
         _ironProgressBar.align = "center";
         _ironProgressBar.label = "";
         addChild(_ironProgressBar);
         ironAsset = assetRepository.getDisplayObject("ResourceIconIron");
         addChild(ironAsset);
         _topOffIronButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Small");
         var _temp_5:* = _topOffIronButton;
         var _loc7_:String = "ui.windows.centralhiring.topoff";
         _temp_5.label = peak.i18n.PText.INSTANCE.getText0(_loc7_);
         _topOffIronButton.width = 108;
         addChild(_topOffIronButton);
         _selectMercenaryPanel = new MobileHiringQuartersMercenaryPanel(0,assetRepository,_buildingInstanceId);
         addChild(_selectMercenaryPanel);
         hiringQuarterStatusHeader = new MobileCaptionTextField();
         hiringQuarterStatusHeader.textRendererProperties.textFormat = getCaptionTextFormat(21);
         hiringQuarterStatusHeader.width = 180;
         hiringQuartersSprite.addChild(hiringQuarterStatusHeader);
         var _temp_8:* = hiringQuarterStatusHeader;
         var _loc8_:String = "ui.windows.centralhiring.header2";
         _temp_8.text = peak.i18n.PText.INSTANCE.getText0(_loc8_);
         hiringQuarterLockedIcons = [];
         hiringQuarterThreeDotIcons = [];
         _mercenaryInProgressViews = [];
         mercenaryInProgressHatcheryLabels = [];
         _mercenaryInProgressStatusTextFields = [];
         _mercenaryInProgressRemainingTimeTFs = [];
         _mercenaryInProgressStatusBackgrounds = [];
         _loc5_ = 0;
         while(_loc5_ < 5)
         {
            _loc2_ = new MobileWomTextField();
            _loc2_.textRendererProperties.textFormat = getWomTextFormat(19,"center");
            _loc2_.width = 86;
            hiringQuartersSprite.addChild(_loc2_);
            var _temp_17:* = _loc2_;
            var _temp_16:* = "ui.windows.centralhiring.hatchery";
            var _loc9_:Number = _loc5_ + 1;
            var _loc10_:String = _temp_16;
            _temp_17.text = peak.i18n.PText.INSTANCE.getText1(_loc10_,_loc9_);
            mercenaryInProgressHatcheryLabels[_loc5_] = _loc2_;
            _loc1_ = assetRepository.getDisplayObject("BackgroundRedWarningPanel");
            _loc1_.width = 90;
            _loc1_.height = 25;
            _loc1_.visible = false;
            hiringQuartersSprite.addChild(_loc1_);
            _mercenaryInProgressStatusBackgrounds[_loc5_] = _loc1_;
            _loc4_ = new MobileWomTextField();
            _loc4_.textRendererProperties.textFormat = getWomTextFormat(19,"center",16777215);
            _loc4_.visible = false;
            _loc4_.width = 86;
            hiringQuartersSprite.addChild(_loc4_);
            _mercenaryInProgressStatusTextFields[_loc5_] = _loc4_;
            _loc3_ = new MobileWomTextField();
            _loc3_.textRendererProperties.textFormat = getWomTextFormat(19,"center");
            _loc3_.visible = false;
            _loc3_.width = 86;
            hiringQuartersSprite.addChild(_loc3_);
            _mercenaryInProgressRemainingTimeTFs[_loc5_] = _loc3_;
            hiringQuarterLockedIcons[_loc5_] = assetRepository.getDisplayObject("IconLockMBordered");
            hiringQuarterLockedIcons[_loc5_].visible = false;
            hiringQuartersSprite.addChild(hiringQuarterLockedIcons[_loc5_]);
            hiringQuarterThreeDotIcons[_loc5_] = assetRepository.getDisplayObject("SymbolThreeDot");
            hiringQuarterThreeDotIcons[_loc5_].visible = true;
            hiringQuartersSprite.addChild(hiringQuarterThreeDotIcons[_loc5_]);
            _loc5_++;
         }
         housingSpaceProgressBar = MobileWomUIComponentFactory.createProgressBar("Yellow");
         housingSpaceProgressBar.width = 326;
         housingSpaceProgressBar.height = 33;
         housingSpaceProgressBar.minimum = 0;
         housingSpaceProgressBar.align = "center";
         housingSpaceProgressBar.label = "";
         hiringQuartersSprite.addChild(housingSpaceProgressBar);
         queuedSpaceProgressBar = MobileWomUIComponentFactory.createProgressBar("Yellow");
         queuedSpaceProgressBar.width = 326;
         queuedSpaceProgressBar.height = 33;
         queuedSpaceProgressBar.minimum = 0;
         queuedSpaceProgressBar.align = "center";
         queuedSpaceProgressBar.label = "";
         hiringQuartersSprite.addChild(queuedSpaceProgressBar);
         queuedUpLabel = new MobileWomTextField();
         queuedUpLabel.textRendererProperties.textFormat = getWomTextFormat(17);
         hiringQuartersSprite.addChild(queuedUpLabel);
         var _temp_22:* = queuedUpLabel;
         var _loc11_:String = "ui.windows.centralhiring.queuedup";
         _temp_22.text = peak.i18n.PText.INSTANCE.getText0(_loc11_);
         _totalHousingTextField = new MobileWomTextField();
         _totalHousingTextField.textRendererProperties.textFormat = getWomTextFormat(17);
         _totalHousingTextField.width = 86;
         hiringQuartersSprite.addChild(_totalHousingTextField);
         housingRatioTextField = new MobileCaptionTextField();
         housingRatioTextField.textRendererProperties.textFormat = getCaptionTextFormat(17);
         housingRatioTextField.width = 86;
         hiringQuartersSprite.addChild(housingRatioTextField);
         _speedupButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Small");
         var _temp_26:* = _speedupButton;
         var _loc12_:String = "ui.windows.centralhiring.speedup";
         _temp_26.label = peak.i18n.PText.INSTANCE.getText0(_loc12_);
         _speedupButton.width = 149;
         hiringQuartersSprite.addChild(_speedupButton);
         _finishNowButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Small");
         var _temp_28:* = _finishNowButton;
         var _loc13_:String = "ui.windows.centralhiring.finishnow";
         _temp_28.label = peak.i18n.PText.INSTANCE.getText0(_loc13_);
         _finishNowButton.width = 169;
         hiringQuartersSprite.addChild(_finishNowButton);
         inQueueHeader = new MobileCaptionTextField();
         inQueueHeader.textRendererProperties.textFormat = getCaptionTextFormat(21);
         inQueueHeader.width = 80;
         addChild(inQueueHeader);
         var _temp_30:* = inQueueHeader;
         var _loc14_:String = "ui.windows.centralhiring.header3";
         _temp_30.text = peak.i18n.PText.INSTANCE.getText0(_loc14_);
         _queuedMercenaryThreeDotIcons = [];
         _loc5_ = 0;
         while(_loc5_ < 7)
         {
            _queuedMercenaryThreeDotIcons[_loc5_] = assetRepository.getDisplayObject("SymbolThreeDot");
            _queuedMercenaryThreeDotIcons[_loc5_].visible = true;
            addChild(_queuedMercenaryThreeDotIcons[_loc5_]);
            _loc5_++;
         }
         _queuedMercenaryViews = new Vector.<MobileHiringQuartersMercenaryView>();
         drawLayout();
      }
      
      override protected function drawBackground() : void
      {
         var _loc3_:int = 0;
         var _loc2_:DisplayObject = null;
         var _loc1_:DisplayObject = null;
         super.drawBackground();
         hiringQuartersSprite = new Sprite();
         addChild(hiringQuartersSprite);
         _mercenaryInProgressBackgrounds = [];
         hiringQuartersBackground = assetRepository.getDisplayObject("MobileYellowBackground");
         hiringQuartersBackground.width = 998;
         hiringQuartersBackground.height = 162;
         hiringQuartersSprite.addChild(hiringQuartersBackground);
         MobileAlignmentUtil.alignAccordingToPositionOf(hiringQuartersSprite,_background,(_windowWidth - hiringQuartersSprite.width) / 2,417);
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            _loc2_ = assetRepository.getDisplayObject("MercEmptyBackground");
            _loc2_.width = 86;
            hiringQuartersSprite.addChild(_loc2_);
            _mercenaryInProgressBackgrounds[_loc3_] = _loc2_;
            if(_loc3_ == 0)
            {
               MobileAlignmentUtil.alignAccordingToPositionOf(_loc2_,hiringQuartersBackground,37,42);
            }
            else
            {
               MobileAlignmentUtil.alignRightOf(_loc2_,_mercenaryInProgressBackgrounds[_loc3_ - 1],35);
            }
            _loc3_++;
         }
         _queuedMercenaryBackgrounds = [];
         inQueueBackground = assetRepository.getDisplayObject("MobileDarkBackground");
         inQueueBackground.width = 998;
         inQueueBackground.height = 162;
         addChild(inQueueBackground);
         MobileAlignmentUtil.alignBelowOf(inQueueBackground,hiringQuartersSprite,12);
         _loc3_ = 0;
         while(_loc3_ < 7)
         {
            _loc1_ = assetRepository.getDisplayObject("MercEmptyBackground");
            _loc1_.width = 86;
            addChild(_loc1_);
            _queuedMercenaryBackgrounds[_loc3_] = _loc1_;
            if(_loc3_ == 0)
            {
               MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_loc1_,inQueueBackground,92);
            }
            else
            {
               MobileAlignmentUtil.alignRightOf(_loc1_,_queuedMercenaryBackgrounds[_loc3_ - 1],35);
            }
            _loc3_++;
         }
         _staticLayer.flatten();
      }
      
      public function drawLayout() : void
      {
         var _loc4_:DisplayObject = null;
         var _loc7_:DisplayObject = null;
         var _loc8_:int = 0;
         var _loc6_:MPTextField = null;
         var _loc5_:MPTextField = null;
         var _loc2_:MPTextField = null;
         var _loc1_:DisplayObject = null;
         var _loc3_:DisplayObject = null;
         MobileAlignmentUtil.alignAccordingToPositionOf(ironAsset,_background,25,13);
         MobileAlignmentUtil.alignRightWithYMarginOf(_ironProgressBar,ironAsset,2,-ironAsset.width / 2);
         MobileAlignmentUtil.alignRightWithYMarginOf(_topOffIronButton,_ironProgressBar,-(_topOffIronButton.height - _ironProgressBar.height >> 1),-3);
         MobileAlignmentUtil.alignAccordingToPositionOf(_selectMercenaryPanel,_background,(_windowWidth - _selectMercenaryPanel.width) / 2,88);
         _loc8_ = 0;
         while(_loc8_ < 5)
         {
            _loc6_ = mercenaryInProgressHatcheryLabels[_loc8_];
            _loc4_ = _mercenaryInProgressBackgrounds[_loc8_];
            _loc5_ = _mercenaryInProgressStatusTextFields[_loc8_];
            _loc2_ = _mercenaryInProgressRemainingTimeTFs[_loc8_];
            _loc1_ = _mercenaryInProgressStatusBackgrounds[_loc8_];
            _loc3_ = hiringQuarterLockedIcons[_loc8_];
            _loc7_ = hiringQuarterThreeDotIcons[_loc8_];
            MobileAlignmentUtil.alignAboveOf(_loc6_,_loc4_,10);
            MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_loc1_,_loc4_,_loc4_.height - 5);
            MobileAlignmentUtil.alignAccordingToPositionOf(_loc5_,_loc1_,3,3);
            MobileAlignmentUtil.alignAccordingToPositionOf(_loc2_,_loc5_,0,0);
            MobileAlignmentUtil.alignMiddleOf(_loc3_,_loc4_);
            MobileAlignmentUtil.alignMiddleOf(_loc7_,_loc4_);
            _loc8_++;
         }
         _loc8_ = 0;
         while(_loc8_ < 7)
         {
            _loc4_ = _queuedMercenaryBackgrounds[_loc8_];
            _loc7_ = _queuedMercenaryThreeDotIcons[_loc8_];
            MobileAlignmentUtil.alignMiddleOf(_loc7_,_loc4_);
            _loc8_++;
         }
         MobileAlignmentUtil.alignAccordingToPositionOf(hiringQuarterStatusHeader,hiringQuartersBackground,30,-hiringQuarterStatusHeader.height / 2 + 3);
         MobileAlignmentUtil.alignAccordingToPositionOf(inQueueHeader,inQueueBackground,30,-inQueueHeader.height / 2 + 3);
         MobileAlignmentUtil.alignAccordingToPositionOf(_finishNowButton,hiringQuartersBackground,hiringQuartersBackground.width - _finishNowButton.width - 30,48);
         MobileAlignmentUtil.alignAccordingToPositionOf(_speedupButton,_finishNowButton,-_speedupButton.width - 11,0);
         MobileAlignmentUtil.alignBelowOf(housingSpaceProgressBar,_speedupButton,5);
         MobileAlignmentUtil.alignBelowOf(queuedSpaceProgressBar,_speedupButton,5);
         MobileAlignmentUtil.alignAccordingToPositionOf(housingRatioTextField,queuedSpaceProgressBar,35,9);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(queuedUpLabel,housingSpaceProgressBar,130);
         MobileAlignmentUtil.alignRightOf(_totalHousingTextField,queuedUpLabel,7);
      }
      
      public function set capacityOfBarracks(param1:int) : void
      {
         housingSpaceProgressBar.maximum = param1;
         queuedSpaceProgressBar.maximum = param1;
      }
      
      public function set housingOfUnitsInBarracks(param1:int) : void
      {
         housingRatioTextField.text = NumberUtil.format(param1) + " / " + NumberUtil.format(housingSpaceProgressBar.maximum);
         housingSpaceProgressBar.value = param1;
      }
      
      public function get selectMercenaryPanel() : MobileHiringQuartersMercenaryPanel
      {
         return _selectMercenaryPanel;
      }
      
      public function get mercenaryInProgressStatusTextFields() : Array
      {
         return _mercenaryInProgressStatusTextFields;
      }
      
      public function setMercenaryInProgress(param1:int, param2:int, param3:int = -1) : void
      {
         hiringQuarterLockedIcons[param1].visible = false;
         if(_mercenaryInProgressViews[param1])
         {
            hiringQuartersSprite.removeChild(_mercenaryInProgressViews[param1]);
            _mercenaryInProgressViews[param1] = null;
         }
         if(param2)
         {
            _mercenaryInProgressViews[param1] = new MobileHiringQuartersMercenaryView(param2,param3,0,0,0,_dontAskForOverflow);
            hiringQuartersSprite.addChild(_mercenaryInProgressViews[param1]);
            MobileAlignmentUtil.alignMiddleOf(_mercenaryInProgressViews[param1],_mercenaryInProgressBackgrounds[param1]);
         }
      }
      
      public function fillQueuedMercenaries(param1:HiringQueueInfo) : void
      {
         var _loc6_:MobileHiringQuartersMercenaryView = null;
         var _loc7_:Boolean = false;
         var _loc4_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc8_:* = 0;
         var _loc3_:int = 0;
         for each(var _loc5_ in param1.hiringSlots)
         {
            _loc7_ = _queuedMercenaryViews.length > _loc3_ && _queuedMercenaryViews[_loc3_];
            if(_loc7_ && _queuedMercenaryViews[_loc3_].unitTypeId == _loc5_.unitId)
            {
               _loc6_ = _queuedMercenaryViews[_loc3_];
               _loc4_ = _loc6_.numberOfUnits > _loc5_.numberOfUnits && param1.hiringSlots.length == _queuedMercenaryViews.length;
               _loc2_ = _loc6_.numberOfUnits < _loc5_.numberOfUnits && param1.hiringSlots.length == _queuedMercenaryViews.length;
               _loc6_.numberOfUnits = _loc5_.numberOfUnits;
               if(_loc4_)
               {
                  _loc6_.showCancelQueuedAnimation();
               }
               else if(!_isFirstUpdate && _loc2_)
               {
                  _selectMercenaryPanel.showHireAnimationOf(_loc5_.unitId);
               }
               log(WomLoggerContexts.GAME,"========[[[[[[ UNIT HIRED: VIEW_UPDATE TO " + _loc6_.numberOfUnits + " ]]]]]]========");
            }
            else
            {
               if(_loc7_)
               {
                  _loc6_ = _queuedMercenaryViews[_loc3_];
                  removeChild(_loc6_);
               }
               _loc6_ = new MobileHiringQuartersMercenaryView(_loc5_.unitId,_buildingInstanceId,1,_loc5_.numberOfUnits,_loc3_ + 1,_dontAskForOverflow);
               addChild(_loc6_);
               MobileAlignmentUtil.alignMiddleOf(_loc6_,_queuedMercenaryBackgrounds[_loc3_]);
               _queuedMercenaryViews[_loc3_] = _loc6_;
               if(!_isFirstUpdate && param1.hiringSlots.length == _queuedMercenaryViews.length)
               {
                  _selectMercenaryPanel.showHireAnimationOf(_loc5_.unitId);
               }
            }
            _loc3_++;
         }
         _loc8_ = _loc3_;
         while(_loc8_ < _queuedMercenaryViews.length)
         {
            removeChild(_queuedMercenaryViews[_loc8_]);
            _loc8_++;
         }
         _queuedMercenaryViews.splice(_loc3_,_queuedMercenaryViews.length - _loc3_);
      }
      
      public function updateNonBuiltHiringQuarterSlot(param1:int, param2:Boolean = false) : void
      {
         hiringQuarterLockedIcons[param1].visible = true;
         hiringQuarterThreeDotIcons[param1].visible = false;
      }
      
      public function set queuedHousing(param1:int) : void
      {
         queuedSpaceProgressBar.value = param1 + housingSpaceProgressBar.value > queuedSpaceProgressBar.maximum ? queuedSpaceProgressBar.maximum : param1 + housingSpaceProgressBar.value;
         var _loc2_:String;
         _totalHousingTextField.text = NumberUtil.format(param1 + housingSpaceProgressBar.value) + (param1 + housingSpaceProgressBar.value > queuedSpaceProgressBar.maximum ? (_loc2_ = "ui.windows.centralhiring.over",peak.i18n.PText.INSTANCE.getText0(_loc2_)) : "");
      }
      
      public function setMercenaryInProgressAlpha(param1:int, param2:Number) : void
      {
         _mercenaryInProgressBackgrounds[param1].alpha = param2;
         if(_mercenaryInProgressViews[param1])
         {
            _mercenaryInProgressViews[param1].alpha = param2;
         }
      }
      
      public function resetMercenaryInProgressStatus(param1:int, param2:String = null) : void
      {
         _mercenaryInProgressStatusTextFields[param1].text = param2;
         _mercenaryInProgressRemainingTimeTFs[param1].visible = false;
         _mercenaryInProgressStatusTextFields[param1].visible = param2 != null;
         _mercenaryInProgressStatusBackgrounds[param1].visible = param2 != null;
      }
      
      public function resetMercenaryInProgressRemainingTime(param1:int, param2:String = null) : void
      {
         _mercenaryInProgressRemainingTimeTFs[param1].visible = param2 != null;
         _mercenaryInProgressRemainingTimeTFs[param1].text = param2;
         _mercenaryInProgressStatusTextFields[param1].visible = param2 == null;
         _mercenaryInProgressStatusBackgrounds[param1].visible = param2 == null;
      }
      
      public function get dontAskForOverflow() : Boolean
      {
         return _dontAskForOverflow;
      }
      
      public function set dontAskForOverflow(param1:Boolean) : void
      {
         _dontAskForOverflow = param1;
      }
      
      public function get ironProgressBar() : MobileWomProgressBar
      {
         return _ironProgressBar;
      }
      
      public function get buildingInstanceId() : int
      {
         return _buildingInstanceId;
      }
      
      public function get finishNowButton() : MobileWomButton
      {
         return _finishNowButton;
      }
      
      public function get speedupButton() : MobileWomButton
      {
         return _speedupButton;
      }
      
      public function get topOffIronButton() : MobileWomButton
      {
         return _topOffIronButton;
      }
      
      public function set hiringQuartersSpriteVisible(param1:Boolean) : void
      {
         hiringQuartersSprite.visible = param1;
      }
      
      public function get mercenaryInProgressBackgrounds() : Array
      {
         return _mercenaryInProgressBackgrounds;
      }
      
      public function get isFirstUpdate() : Boolean
      {
         return _isFirstUpdate;
      }
      
      public function set isFirstUpdate(param1:Boolean) : void
      {
         _isFirstUpdate = param1;
      }
   }
}

