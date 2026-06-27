package wom.view.screen.windows.hiringquarters
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import peak.util.NumberUtil;
   import wom.model.game.hiring.HiringPauseReasonType;
   import wom.model.game.hiring.HiringQueueInfo;
   import wom.model.game.hiring.HiringSlotView;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.WomButton;
   import wom.view.component.button.colored.WomBlueSmallButton;
   import wom.view.component.button.colored.WomGreenSmallButton;
   import wom.view.component.progressbar.CentralHiringBigTransparentProgressBar;
   import wom.view.component.progressbar.ProgressBar36;
   import wom.view.component.progressbar.ProgressBar65;
   import wom.view.component.progressbar.WomProgressBar;
   import wom.view.mediator.screen.windows.hiringquarters.QueuedMercenaryCancelIcon;
   import wom.view.util.GenericWindow;
   
   public class CentralHiringQuartersWindow extends GenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 750;
      
      private static const WINDOW_HEIGHT:int = 576;
      
      private var hiringQuarterSlotBackgrounds:Array;
      
      private var hiringQuarterLockedIcons:Array;
      
      private var hiringQuarterLockedTextFields:Array;
      
      private var chooseMercenaryHeader:TextField;
      
      private var hiringQuarterStatusHeader:TextField;
      
      private var inQueueHeader:TextField;
      
      private var _selectMercenaryPanel:HiringQuartersSelectMercenaryPanel;
      
      private var _speedupButton:WomButton;
      
      private var _finishNowButton:WomButton;
      
      private var _topOffButton:WomButton;
      
      private var arrowIcon:DisplayObject;
      
      private var _mercenaryInProgressViews:Array;
      
      private var mercenaryInProgressHatcheryLabels:Array;
      
      private var _mercenaryInProgressStatusTextFields:Array;
      
      private var mercenaryInProgressBackgrounds:Array;
      
      private var housingSpaceProgressBar:WomProgressBar;
      
      private var queuedSpaceProgressBar:ProgressBar65;
      
      private var housingSpaceLabel:TextField;
      
      private var housingRatioTextField:TextField;
      
      private var queuedUpLabel:TextField;
      
      private var totalHousingTextField:TextField;
      
      private var resourceUsageLabel:TextField;
      
      private var resourceUsageProgressBar:ProgressBar36;
      
      private var _buildingInstanceId:int;
      
      private var _hiringQuarterIds:Array;
      
      private var _queuedMercenaryViews:Vector.<HiringQuartersQueuedMercenaryView>;
      
      private var _queuedMercenaryCancelIcons:Vector.<QueuedMercenaryCancelIcon>;
      
      private var queuedMercenaryBackgrounds:Array;
      
      private var _initialUnitTypeId:int;
      
      private var _dontAskForOverflow:Boolean = false;
      
      public function CentralHiringQuartersWindow(param1:int, param2:int = 10, param3:Vector.<WindowEnumeration> = null)
      {
         super(750,576,param3);
         _buildingInstanceId = param1;
         _initialUnitTypeId = param2;
         _hiringQuarterIds = [];
      }
      
      override protected function initLayout() : void
      {
         var _loc3_:int = 0;
         var _loc1_:TextField = null;
         var _loc2_:TextField = null;
         super.initLayout();
         var _loc4_:String = "ui.windows.centralhiring.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc4_));
         chooseMercenaryHeader = new CaptionTextField(WomTextFormats.BLACK_FILTER);
         chooseMercenaryHeader.defaultTextFormat = WomTextFormats.CENTER_20;
         chooseMercenaryHeader.height = 22;
         chooseMercenaryHeader.width = 750;
         var _temp_3:* = chooseMercenaryHeader;
         var _loc5_:String = "ui.windows.centralhiring.header1";
         _temp_3.text = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         addChild(chooseMercenaryHeader);
         hiringQuarterStatusHeader = new CaptionTextField(WomTextFormats.BLACK_FILTER);
         hiringQuarterStatusHeader.defaultTextFormat = WomTextFormats.CENTER_20;
         hiringQuarterStatusHeader.height = 22;
         hiringQuarterStatusHeader.width = 750;
         var _temp_5:* = hiringQuarterStatusHeader;
         var _loc6_:String = "ui.windows.centralhiring.header2";
         _temp_5.text = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         addChild(hiringQuarterStatusHeader);
         inQueueHeader = new CaptionTextField(WomTextFormats.BLACK_FILTER);
         inQueueHeader.defaultTextFormat = WomTextFormats.CENTER_20;
         inQueueHeader.height = 22;
         inQueueHeader.width = 750;
         var _temp_7:* = inQueueHeader;
         var _loc7_:String = "ui.windows.centralhiring.header3";
         _temp_7.text = peak.i18n.PText.INSTANCE.getText0(_loc7_);
         addChild(inQueueHeader);
         _selectMercenaryPanel = new HiringQuartersSelectMercenaryPanel(assetRepository);
         addChild(_selectMercenaryPanel);
         mercenaryInProgressHatcheryLabels = [];
         _mercenaryInProgressViews = [];
         _mercenaryInProgressStatusTextFields = [];
         hiringQuarterLockedIcons = [];
         hiringQuarterLockedTextFields = [];
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            _loc1_ = new CaptionTextField();
            _loc1_.defaultTextFormat = WomTextFormats.CENTER_16;
            _loc1_.height = 20;
            _loc1_.width = 85;
            var _temp_15:* = _loc1_;
            var _temp_14:* = "ui.windows.centralhiring.hatchery";
            var _loc8_:Number = _loc3_ + 1;
            var _loc9_:String = _temp_14;
            _temp_15.text = peak.i18n.PText.INSTANCE.getText1(_loc9_,_loc8_);
            addChild(_loc1_);
            mercenaryInProgressHatcheryLabels[_loc3_] = _loc1_;
            _loc2_ = new WomTextField();
            _loc2_.defaultTextFormat = WomTextFormats.CENTER_16;
            _loc2_.height = 20;
            _loc2_.width = 85;
            _loc2_.visible = false;
            addChild(_loc2_);
            _mercenaryInProgressStatusTextFields[_loc3_] = _loc2_;
            hiringQuarterLockedIcons[_loc3_] = assetRepository.getDisplayObject("Lock");
            hiringQuarterLockedIcons[_loc3_].visible = false;
            addChild(hiringQuarterLockedIcons[_loc3_]);
            hiringQuarterLockedTextFields[_loc3_] = new WomTextField();
            (hiringQuarterLockedTextFields[_loc3_] as TextField).defaultTextFormat = WomTextFormats.CENTER_16_CONDENSED;
            (hiringQuarterLockedTextFields[_loc3_] as TextField).height = 54;
            (hiringQuarterLockedTextFields[_loc3_] as TextField).width = 85;
            (hiringQuarterLockedTextFields[_loc3_] as TextField).visible = false;
            (hiringQuarterLockedTextFields[_loc3_] as TextField).multiline = true;
            (hiringQuarterLockedTextFields[_loc3_] as TextField).wordWrap = true;
            var _temp_16:* = hiringQuarterLockedTextFields[_loc3_] as TextField;
            var _loc10_:String = "ui.windows.centralhiring.buildnew";
            _temp_16.text = peak.i18n.PText.INSTANCE.getText0(_loc10_);
            addChild(hiringQuarterLockedTextFields[_loc3_]);
            _loc3_++;
         }
         queuedSpaceProgressBar = new ProgressBar65();
         queuedSpaceProgressBar.width = 140;
         addChild(queuedSpaceProgressBar);
         housingSpaceProgressBar = new CentralHiringBigTransparentProgressBar();
         housingSpaceProgressBar.width = 140;
         addChild(housingSpaceProgressBar);
         housingSpaceLabel = new CaptionTextField();
         housingSpaceLabel.defaultTextFormat = WomTextFormats.FONT_SIZE_14;
         housingSpaceLabel.autoSize = "left";
         var _temp_20:* = housingSpaceLabel;
         var _loc11_:String = "ui.windows.centralhiring.housingspace";
         _temp_20.text = peak.i18n.PText.INSTANCE.getText0(_loc11_);
         addChild(housingSpaceLabel);
         housingRatioTextField = new CaptionTextField();
         housingRatioTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         housingRatioTextField.autoSize = "left";
         housingRatioTextField.text = "0 / 0";
         addChild(housingRatioTextField);
         queuedUpLabel = new CaptionTextField();
         queuedUpLabel.defaultTextFormat = WomTextFormats.FONT_SIZE_14;
         queuedUpLabel.autoSize = "left";
         var _temp_23:* = queuedUpLabel;
         var _loc12_:String = "ui.windows.centralhiring.queuedup";
         _temp_23.text = peak.i18n.PText.INSTANCE.getText0(_loc12_);
         addChild(queuedUpLabel);
         totalHousingTextField = new CaptionTextField();
         totalHousingTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_14;
         totalHousingTextField.autoSize = "left";
         var _temp_26:* = totalHousingTextField;
         var _temp_25:* = NumberUtil.format(0) + " ";
         var _loc13_:String = "ui.windows.centralhiring.over";
         _temp_26.text = _temp_25 + peak.i18n.PText.INSTANCE.getText0(_loc13_);
         addChild(totalHousingTextField);
         resourceUsageLabel = new CaptionTextField();
         resourceUsageLabel.defaultTextFormat = WomTextFormats.FONT_SIZE_14;
         resourceUsageLabel.autoSize = "left";
         var _temp_28:* = resourceUsageLabel;
         var _loc14_:String = "ui.windows.centralhiring.resourceusage";
         _temp_28.text = peak.i18n.PText.INSTANCE.getText0(_loc14_);
         addChild(resourceUsageLabel);
         resourceUsageProgressBar = new ProgressBar36();
         resourceUsageProgressBar.width = 140;
         addChild(resourceUsageProgressBar);
         _speedupButton = new WomBlueSmallButton();
         var _temp_31:* = _speedupButton;
         var _loc15_:String = "ui.windows.centralhiring.speedup";
         _temp_31.label = peak.i18n.PText.INSTANCE.getText0(_loc15_);
         _speedupButton.width = 90;
         addChild(_speedupButton);
         _finishNowButton = new WomGreenSmallButton();
         var _temp_33:* = _finishNowButton;
         var _loc16_:String = "ui.windows.centralhiring.finishnow";
         _temp_33.label = peak.i18n.PText.INSTANCE.getText0(_loc16_);
         _finishNowButton.width = 90;
         addChild(_finishNowButton);
         _topOffButton = new WomBlueSmallButton();
         var _temp_35:* = _topOffButton;
         var _loc17_:String = "ui.windows.centralhiring.topoff";
         _temp_35.label = peak.i18n.PText.INSTANCE.getText0(_loc17_);
         _topOffButton.width = 90;
         addChild(_topOffButton);
         arrowIcon = assetRepository.getDisplayObject("HiringQuarterArrowRight");
         addChild(arrowIcon);
         drawLayout();
      }
      
      override protected function drawBackground() : void
      {
         var _loc9_:int = 0;
         var _loc8_:DisplayObject = null;
         var _loc6_:DisplayObject = null;
         var _loc5_:DisplayObject = null;
         var _loc2_:int = 0;
         var _loc3_:QueuedMercenaryCancelIcon = null;
         super.drawBackground();
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.lineStyle(1,10915407);
         _loc1_.graphics.moveTo(0,15);
         _loc1_.graphics.lineTo(0,0);
         _loc1_.graphics.lineTo(230,0);
         _loc1_.graphics.moveTo(453,0);
         _loc1_.graphics.lineTo(683,0);
         _loc1_.graphics.lineTo(683,15);
         _loc1_.graphics.lineStyle(1,15391657);
         _loc1_.graphics.moveTo(1,1);
         _loc1_.graphics.lineTo(231,1);
         _loc1_.graphics.moveTo(453,1);
         _loc1_.graphics.lineTo(682,1);
         _loc1_.x = 32;
         _loc1_.y = 36;
         addChild(_loc1_);
         hiringQuarterSlotBackgrounds = [];
         mercenaryInProgressBackgrounds = [];
         _loc9_ = 0;
         while(_loc9_ < 5)
         {
            _loc8_ = assetRepository.getDisplayObject("BackgroundLight");
            _loc8_.width = 85;
            _loc8_.height = 123;
            if(_loc9_ == 0)
            {
               _loc8_.x = 21;
               _loc8_.y = 292;
            }
            else
            {
               AlignmentUtil.alignRightOf(_loc8_,hiringQuarterSlotBackgrounds[_loc9_ - 1],1);
            }
            hiringQuarterSlotBackgrounds[_loc9_] = _loc8_;
            addChild(_loc8_);
            _loc6_ = assetRepository.getDisplayObject("BackgroundDark");
            _loc6_.width = 52;
            _loc6_.height = 49;
            AlignmentUtil.alignMiddleOf(_loc6_,_loc8_);
            mercenaryInProgressBackgrounds[_loc9_] = _loc6_;
            addChild(_loc6_);
            _loc9_++;
         }
         var _loc4_:Sprite = new Sprite();
         _loc4_.graphics.lineStyle(1,10915407);
         _loc4_.graphics.moveTo(0,15);
         _loc4_.graphics.lineTo(0,0);
         _loc4_.graphics.lineTo(190,0);
         _loc4_.graphics.moveTo(493,0);
         _loc4_.graphics.lineTo(683,0);
         _loc4_.graphics.lineTo(683,15);
         _loc4_.graphics.lineStyle(1,15391657);
         _loc4_.graphics.moveTo(1,1);
         _loc4_.graphics.lineTo(191,1);
         _loc4_.graphics.moveTo(493,1);
         _loc4_.graphics.lineTo(682,1);
         _loc4_.x = 32;
         _loc4_.y = 269;
         addChild(_loc4_);
         var _loc7_:Sprite = new Sprite();
         _loc7_.graphics.lineStyle(1,10915407);
         _loc7_.graphics.moveTo(0,15);
         _loc7_.graphics.lineTo(0,0);
         _loc7_.graphics.lineTo(190,0);
         _loc7_.graphics.moveTo(493,0);
         _loc7_.graphics.lineTo(683,0);
         _loc7_.graphics.lineTo(683,15);
         _loc7_.graphics.lineStyle(1,15391657);
         _loc7_.graphics.moveTo(1,1);
         _loc7_.graphics.lineTo(191,1);
         _loc7_.graphics.moveTo(493,1);
         _loc7_.graphics.lineTo(682,1);
         _loc7_.x = 32;
         _loc7_.y = 440;
         addChild(_loc7_);
         queuedMercenaryBackgrounds = [];
         _queuedMercenaryCancelIcons = new Vector.<QueuedMercenaryCancelIcon>();
         _loc9_ = 0;
         while(_loc9_ < 7)
         {
            _loc5_ = assetRepository.getDisplayObject("BackgroundDark");
            _loc5_.width = 98;
            _loc5_.height = 98;
            if(_loc9_ == 0)
            {
               _loc5_.x = 27;
               _loc5_.y = 460;
            }
            else
            {
               AlignmentUtil.alignRightOf(_loc5_,queuedMercenaryBackgrounds[_loc9_ - 1],1);
            }
            queuedMercenaryBackgrounds[_loc9_] = _loc5_;
            addChild(_loc5_);
            _loc2_ = _loc9_ + 1;
            _loc3_ = new QueuedMercenaryCancelIcon(assetRepository.getDisplayObject("HiringQuartersCancel"),_loc2_);
            addChild(_loc3_);
            _queuedMercenaryCancelIcons.push(_loc3_);
            AlignmentUtil.alignAccordingToPositionOf(_loc3_,_loc5_,0,0);
            _loc9_++;
         }
      }
      
      public function drawLayout() : void
      {
         var _loc1_:int = 0;
         _selectMercenaryPanel.x = 21;
         _selectMercenaryPanel.y = 58;
         chooseMercenaryHeader.y = 23;
         AlignmentUtil.alignBelowOf(hiringQuarterStatusHeader,chooseMercenaryHeader,210);
         AlignmentUtil.alignBelowOf(inQueueHeader,hiringQuarterStatusHeader,149);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            AlignmentUtil.alignAccordingToPositionOf(mercenaryInProgressHatcheryLabels[_loc1_],hiringQuarterSlotBackgrounds[_loc1_],0,10);
            AlignmentUtil.alignAccordingToPositionOf(_mercenaryInProgressStatusTextFields[_loc1_],hiringQuarterSlotBackgrounds[_loc1_],0,95);
            AlignmentUtil.alignBelowOf(hiringQuarterLockedIcons[_loc1_],mercenaryInProgressHatcheryLabels[_loc1_]);
            AlignmentUtil.alignMiddleXAxisOf(hiringQuarterLockedIcons[_loc1_],mercenaryInProgressHatcheryLabels[_loc1_]);
            AlignmentUtil.alignBelowOf(hiringQuarterLockedTextFields[_loc1_],mercenaryInProgressHatcheryLabels[_loc1_],47);
            _loc1_++;
         }
         AlignmentUtil.alignRightWithYMarginOf(housingSpaceProgressBar,hiringQuarterSlotBackgrounds[4],4,45);
         AlignmentUtil.alignAccordingToPositionOf(queuedSpaceProgressBar,housingSpaceProgressBar,0,0);
         AlignmentUtil.alignAboveWithXMarginOf(housingSpaceLabel,housingSpaceProgressBar,3,2);
         AlignmentUtil.alignAccordingToPositionOf(queuedUpLabel,housingSpaceProgressBar,9,24);
         AlignmentUtil.alignAboveOf(housingRatioTextField,queuedUpLabel,-2);
         AlignmentUtil.alignBelowOf(totalHousingTextField,queuedUpLabel,-2);
         AlignmentUtil.alignHeightSpecifiedBelowOf(resourceUsageProgressBar,housingSpaceProgressBar,20,65);
         AlignmentUtil.alignAboveWithXMarginOf(resourceUsageLabel,resourceUsageProgressBar,3,1);
         AlignmentUtil.alignRightWithYMarginOf(_speedupButton,housingSpaceProgressBar,1,2);
         AlignmentUtil.alignBelowOf(_finishNowButton,_speedupButton,1);
         AlignmentUtil.alignRightWithYMarginOf(_topOffButton,resourceUsageProgressBar,3,2);
         AlignmentUtil.alignRightWithYMarginOf(arrowIcon,hiringQuarterSlotBackgrounds[4],46,8);
      }
      
      public function get buildingInstanceId() : int
      {
         return _buildingInstanceId;
      }
      
      public function fillQueuedMercenaries(param1:HiringQueueInfo) : void
      {
         if(queuedMercenaryViews)
         {
            for each(var _loc5_ in queuedMercenaryViews)
            {
               removeChild(_loc5_);
            }
         }
         _queuedMercenaryViews = new Vector.<HiringQuartersQueuedMercenaryView>();
         var _loc2_:int = 0;
         for each(var _loc4_ in param1.hiringSlots)
         {
            _loc5_ = new HiringQuartersQueuedMercenaryView(_loc4_.unitId,_loc4_.numberOfUnits,_loc2_ + 1,_buildingInstanceId);
            AlignmentUtil.alignAccordingToPositionOf(_loc5_,queuedMercenaryBackgrounds[_loc2_],0,0);
            addChildAt(_loc5_,getChildIndex(_queuedMercenaryCancelIcons[_loc2_]));
            queuedMercenaryViews.push(_loc5_);
            _loc2_++;
         }
         for each(var _loc3_ in _queuedMercenaryCancelIcons)
         {
            if(_loc2_ < _loc3_.slotIndex)
            {
               _loc3_.visible = false;
            }
         }
      }
      
      public function setMercenaryInProgress(param1:int, param2:String = null, param3:int = -1) : void
      {
         mercenaryInProgressBackgrounds[param1].visible = true;
         hiringQuarterLockedIcons[param1].visible = false;
         hiringQuarterLockedTextFields[param1].visible = false;
         if(_mercenaryInProgressViews[param1])
         {
            removeChild(_mercenaryInProgressViews[param1]);
            _mercenaryInProgressViews[param1] = null;
         }
         if(param2)
         {
            _mercenaryInProgressViews[param1] = new CentralHiringQuartersInProgressView(param2,param3,_dontAskForOverflow);
            AlignmentUtil.alignAccordingToPositionOf(_mercenaryInProgressViews[param1],mercenaryInProgressBackgrounds[param1],0,0);
            addChildAt(_mercenaryInProgressViews[param1],getChildIndex(hiringQuarterLockedIcons[param1]) - 1);
         }
      }
      
      public function get speedupButton() : WomButton
      {
         return _speedupButton;
      }
      
      public function get finishNowButton() : WomButton
      {
         return _finishNowButton;
      }
      
      public function get selectMercenaryPanel() : HiringQuartersSelectMercenaryPanel
      {
         return _selectMercenaryPanel;
      }
      
      public function get mercenaryInProgressStatusTextFields() : Array
      {
         return _mercenaryInProgressStatusTextFields;
      }
      
      public function get hiringQuarterIds() : Array
      {
         return _hiringQuarterIds;
      }
      
      public function set hiringQuarterIds(param1:Array) : void
      {
         _hiringQuarterIds = param1;
      }
      
      public function updateWithResourceInfo(param1:int, param2:int) : void
      {
         resourceUsageProgressBar.maximum = param2 >> 2;
         resourceUsageProgressBar.value = param1;
         resourceUsageProgressBar.progressText = NumberUtil.format(param1);
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
      
      public function set queuedHousing(param1:int) : void
      {
         var _loc2_:String;
         totalHousingTextField.text = NumberUtil.format(param1 + housingSpaceProgressBar.value) + (param1 + housingSpaceProgressBar.value > queuedSpaceProgressBar.maximum ? (_loc2_ = "ui.windows.centralhiring.over",peak.i18n.PText.INSTANCE.getText0(_loc2_)) : "");
         queuedSpaceProgressBar.value = param1 + housingSpaceProgressBar.value > queuedSpaceProgressBar.maximum ? queuedSpaceProgressBar.maximum : param1 + housingSpaceProgressBar.value;
      }
      
      public function get topOffButton() : WomButton
      {
         return _topOffButton;
      }
      
      public function get initialUnitTypeId() : int
      {
         return _initialUnitTypeId;
      }
      
      public function updateNonBuiltHiringQuarterSlot(param1:int, param2:Boolean = false) : void
      {
         mercenaryInProgressBackgrounds[param1].visible = false;
         hiringQuarterLockedIcons[param1].visible = true;
         hiringQuarterLockedTextFields[param1].visible = true;
         var _loc3_:String;
         var _loc4_:String;
         hiringQuarterLockedTextFields[param1].text = param2 ? (_loc3_ = "ui.windows.centralhiring.waiting" + HiringPauseReasonType.HIRING_BUILDING_BEING_UPGRADED.id,peak.i18n.PText.INSTANCE.getText0(_loc3_)) : (_loc4_ = "ui.windows.centralhiring.buildnew",peak.i18n.PText.INSTANCE.getText0(_loc4_));
         AlignmentUtil.alignBelowOf(hiringQuarterLockedTextFields[param1],mercenaryInProgressHatcheryLabels[param1],param2 ? 57 : 47);
      }
      
      public function get queuedMercenaryCancelIcons() : Vector.<QueuedMercenaryCancelIcon>
      {
         return _queuedMercenaryCancelIcons;
      }
      
      public function get queuedMercenaryViews() : Vector.<HiringQuartersQueuedMercenaryView>
      {
         return _queuedMercenaryViews;
      }
      
      public function get dontAskForOverflow() : Boolean
      {
         return _dontAskForOverflow;
      }
      
      public function set dontAskForOverflow(param1:Boolean) : void
      {
         _dontAskForOverflow = param1;
      }
   }
}

