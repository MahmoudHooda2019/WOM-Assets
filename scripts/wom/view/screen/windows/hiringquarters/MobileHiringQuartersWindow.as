package wom.view.screen.windows.hiringquarters
{
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.game.hiring.HiringQueueInfo;
   import wom.model.game.hiring.HiringSlotView;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.component.progressbar.MobileWomProgressBar;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   import wom.view.util.MobileFullScreenWindow;
   
   public class MobileHiringQuartersWindow extends MobileFullScreenWindow
   {
      
      private var inQueueBackground:DisplayObject;
      
      private var inProgressBackground:DisplayObject;
      
      private var ironAsset:DisplayObject;
      
      private var _ironProgressBar:MobileWomProgressBar;
      
      private var _topOffIronButton:MobileWomButton;
      
      private var _speedupButton:MobileWomButton;
      
      private var _finishNowButton:MobileWomButton;
      
      private var _remainingDurationTF:MPTextField;
      
      private var _queuedMercenaryViews:Vector.<MobileHiringQuartersMercenaryView>;
      
      private var _queuedMercenaryBackgrounds:Vector.<DisplayObject>;
      
      private var hiringStatusLabel:MPTextField;
      
      private var _inProgressMercenaryView:MobileHiringQuartersMercenaryView;
      
      private var inProgressMercenaryBackground:DisplayObject;
      
      private var _selectMercenaryPanel:MobileHiringQuartersMercenaryPanel;
      
      private var _inProgressTF:MPTextField;
      
      private var _buildingInstanceId:int;
      
      private var _currentBuildingLevel:int;
      
      private var _initialUnitTypeId:int;
      
      private var _dontAskForOverflow:Boolean = false;
      
      private var _isFirstUpdate:Boolean = false;
      
      public function MobileHiringQuartersWindow(param1:int, param2:int, param3:int = 10, param4:Vector.<WindowEnumeration> = null)
      {
         super(true,param4);
         _buildingInstanceId = param1;
         _currentBuildingLevel = param2;
         _initialUnitTypeId = param3;
         _isFirstUpdate = true;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.windows.hiringquarters.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
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
         var _loc2_:String = "ui.windows.centralhiring.topoff";
         _temp_5.label = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         _topOffIronButton.width = 108;
         addChild(_topOffIronButton);
         _selectMercenaryPanel = new MobileHiringQuartersMercenaryPanel(1,assetRepository,_buildingInstanceId);
         addChild(_selectMercenaryPanel);
         _speedupButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Medium");
         var _temp_8:* = _speedupButton;
         var _loc3_:String = "ui.windows.hiringquarters.speedup";
         _temp_8.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         _speedupButton.width = 159;
         addChild(_speedupButton);
         _finishNowButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Medium");
         var _temp_10:* = _finishNowButton;
         var _loc4_:String = "ui.windows.hiringquarters.finishnow";
         _temp_10.label = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _finishNowButton.width = 169;
         addChild(_finishNowButton);
         _inProgressTF = new MobileWomTextField();
         _inProgressTF.textRendererProperties.textFormat = getWomTextFormat(19);
         addChild(_inProgressTF);
         var _temp_12:* = _inProgressTF;
         var _loc5_:String = "ui.windows.hiringquarters.inprogress";
         _temp_12.text = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         _remainingDurationTF = new MobileWomTextField();
         _remainingDurationTF.textRendererProperties.textFormat = getWomTextFormat(19,"center");
         _remainingDurationTF.width = 93;
         addChild(_remainingDurationTF);
         _remainingDurationTF.text = "";
         hiringStatusLabel = new MobileCaptionTextField();
         hiringStatusLabel.textRendererProperties.textFormat = getCaptionTextFormat(23);
         hiringStatusLabel.width = 110;
         addChild(hiringStatusLabel);
         var _temp_15:* = hiringStatusLabel;
         var _loc6_:String = "m.ui.windows.hiringquarters.inqueue";
         _temp_15.text = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         _queuedMercenaryViews = new Vector.<MobileHiringQuartersMercenaryView>();
         drawLayout();
      }
      
      override protected function drawBackground() : void
      {
         var _loc4_:int = 0;
         var _loc2_:DisplayObject = null;
         var _loc3_:DisplayObject = null;
         var _loc1_:DisplayObject = null;
         super.drawBackground();
         _queuedMercenaryBackgrounds = new Vector.<DisplayObject>();
         inQueueBackground = assetRepository.getDisplayObject("MobileYellowBackground");
         inQueueBackground.width = 998;
         inQueueBackground.height = 161;
         addChild(inQueueBackground);
         MobileAlignmentUtil.alignAccordingToPositionOf(inQueueBackground,_background,(_windowWidth - inQueueBackground.width) / 2,590);
         inProgressBackground = assetRepository.getDisplayObject("MobileBeigeBackground");
         inProgressBackground.width = 126;
         inProgressBackground.height = 140;
         addChild(inProgressBackground);
         MobileAlignmentUtil.alignAccordingToPositionOf(inProgressBackground,inQueueBackground,21,13);
         _loc4_ = 0;
         while(_loc4_ < 4)
         {
            _loc2_ = assetRepository.getDisplayObject("MercSlotBackground");
            _loc2_.width = 93;
            addChild(_loc2_);
            _queuedMercenaryBackgrounds[_loc4_] = _loc2_;
            if(_loc4_ == 0)
            {
               MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_loc2_,inProgressBackground,inProgressBackground.width + 13);
            }
            else
            {
               MobileAlignmentUtil.alignRightOf(_loc2_,_queuedMercenaryBackgrounds[_loc4_ - 1],25);
            }
            if(_loc4_ > _currentBuildingLevel)
            {
               _loc3_ = assetRepository.getDisplayObject("IconLockMBordered");
               addChild(_loc3_);
               MobileAlignmentUtil.alignMiddleOf(_loc3_,_loc2_);
            }
            else
            {
               _loc1_ = assetRepository.getDisplayObject("SymbolThreeDot");
               addChild(_loc1_);
               MobileAlignmentUtil.alignMiddleOf(_loc1_,_loc2_);
            }
            _loc4_++;
         }
         inProgressMercenaryBackground = assetRepository.getDisplayObject("MercSlotBackground");
         inProgressMercenaryBackground.width = 93;
         addChild(inProgressMercenaryBackground);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(inProgressMercenaryBackground,inProgressBackground,30);
         _staticLayer.flatten();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(hiringStatusLabel,inQueueBackground,28,-(hiringStatusLabel.height >> 1));
         hiringStatusLabel.x += 8;
         MobileAlignmentUtil.alignAccordingToPositionOf(ironAsset,_background,25,13);
         MobileAlignmentUtil.alignRightWithYMarginOf(_ironProgressBar,ironAsset,2,-ironAsset.width / 2);
         MobileAlignmentUtil.alignRightWithYMarginOf(_topOffIronButton,_ironProgressBar,-(topOffIronButton.height - _ironProgressBar.height >> 1),-3);
         MobileAlignmentUtil.alignAccordingToPositionOf(_selectMercenaryPanel,_background,(_windowWidth - _selectMercenaryPanel.width) / 2,88);
         _selectMercenaryPanel.x = inQueueBackground.x;
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_finishNowButton,inQueueBackground,inQueueBackground.width - _finishNowButton.width - 30);
         MobileAlignmentUtil.alignLeftOf(_speedupButton,_finishNowButton,11);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_inProgressTF,inProgressBackground,2);
         _remainingDurationTF.validate();
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_remainingDurationTF,inProgressBackground,114);
         if(_inProgressMercenaryView)
         {
            MobileAlignmentUtil.alignMiddleOf(_inProgressMercenaryView,inProgressMercenaryBackground);
         }
      }
      
      public function setMercenaryInProgress(param1:int = 0) : void
      {
         if(_inProgressMercenaryView)
         {
            removeChild(_inProgressMercenaryView);
            _inProgressMercenaryView = null;
         }
         if(param1)
         {
            _inProgressMercenaryView = new MobileHiringQuartersMercenaryView(param1,buildingInstanceId,0,0,0,_dontAskForOverflow);
            addChild(_inProgressMercenaryView);
            drawLayout();
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
               if(!_isFirstUpdate)
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
      
      public function get selectMercenaryPanel() : MobileHiringQuartersMercenaryPanel
      {
         return _selectMercenaryPanel;
      }
      
      public function get currentBuildingLevel() : int
      {
         return _currentBuildingLevel;
      }
      
      public function get buildingInstanceId() : int
      {
         return _buildingInstanceId;
      }
      
      public function get dontAskForOverflow() : Boolean
      {
         return _dontAskForOverflow;
      }
      
      public function set dontAskForOverflow(param1:Boolean) : void
      {
         _dontAskForOverflow = param1;
      }
      
      public function get speedupButton() : MobileWomButton
      {
         return _speedupButton;
      }
      
      public function get finishNowButton() : MobileWomButton
      {
         return _finishNowButton;
      }
      
      public function get ironProgressBar() : MobileWomProgressBar
      {
         return _ironProgressBar;
      }
      
      public function get topOffIronButton() : MobileWomButton
      {
         return _topOffIronButton;
      }
      
      public function get remainingDurationTF() : MPTextField
      {
         return _remainingDurationTF;
      }
      
      public function set isFirstUpdate(param1:Boolean) : void
      {
         _isFirstUpdate = param1;
      }
      
      public function get isFirstUpdate() : Boolean
      {
         return _isFirstUpdate;
      }
   }
}

