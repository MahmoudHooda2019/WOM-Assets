package wom.view.screen.windows.hiringquarters
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.game.hiring.HiringQueueInfo;
   import wom.model.game.hiring.HiringSlotView;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.WomButton;
   import wom.view.component.button.colored.WomBlueSmallButton;
   import wom.view.component.button.colored.WomGreenSmallButton;
   import wom.view.component.progressbar.ProgressBar19;
   import wom.view.component.progressbar.WomProgressBar;
   import wom.view.mediator.screen.windows.hiringquarters.QueuedMercenaryCancelIcon;
   import wom.view.util.GenericWindow;
   
   public class HiringQuartersWindow extends GenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 750;
      
      private static const WINDOW_HEIGHT:int = 492;
      
      private var inProgressBackground:DisplayObject;
      
      private var inQueueBackground:DisplayObject;
      
      private var chooseMercenaryHeader:TextField;
      
      private var hiringQuarterStatusHeader:TextField;
      
      private var _selectMercenaryPanel:HiringQuartersSelectMercenaryPanel;
      
      private var _speedupButton:WomButton;
      
      private var _finishNowButton:WomButton;
      
      private var _remainingDurationProgressBar:WomProgressBar;
      
      private var _remainingDurationTextField:TextField;
      
      private var clockIcon:DisplayObject;
      
      private var arrowIcon:DisplayObject;
      
      private var _mercenaryInProgressView:HiringQuartersInProgressView;
      
      private var inProgressLabel:TextField;
      
      private var inQueueLabel:TextField;
      
      private var inProgressMercenaryBackground:DisplayObject;
      
      private var _buildingInstanceId:int;
      
      private var _currentBuildingLevel:int;
      
      private var _queuedMercenaryViews:Vector.<HiringQuartersQueuedMercenaryView>;
      
      private var _queuedMercenaryCancelIcons:Vector.<QueuedMercenaryCancelIcon>;
      
      private var _waitingText:TextField;
      
      private var _initialUnitTypeId:int;
      
      private var _dontAskForOverflow:Boolean = false;
      
      public function HiringQuartersWindow(param1:int, param2:int, param3:int = 10, param4:Vector.<WindowEnumeration> = null)
      {
         super(750,492,param4);
         _buildingInstanceId = param1;
         _currentBuildingLevel = param2;
         _initialUnitTypeId = param3;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.windows.hiringquarters.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         chooseMercenaryHeader = new CaptionTextField(WomTextFormats.BLACK_FILTER);
         chooseMercenaryHeader.defaultTextFormat = WomTextFormats.CENTER_20;
         chooseMercenaryHeader.height = 22;
         chooseMercenaryHeader.width = 750;
         var _temp_3:* = chooseMercenaryHeader;
         var _loc2_:String = "ui.windows.hiringquarters.header1";
         _temp_3.text = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         addChild(chooseMercenaryHeader);
         hiringQuarterStatusHeader = new CaptionTextField(WomTextFormats.BLACK_FILTER);
         hiringQuarterStatusHeader.defaultTextFormat = WomTextFormats.CENTER_20;
         hiringQuarterStatusHeader.height = 22;
         hiringQuarterStatusHeader.width = 750;
         var _temp_5:* = hiringQuarterStatusHeader;
         var _loc3_:String = "ui.windows.hiringquarters.header2";
         _temp_5.text = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         addChild(hiringQuarterStatusHeader);
         _selectMercenaryPanel = new HiringQuartersSelectMercenaryPanel(assetRepository);
         addChild(_selectMercenaryPanel);
         _speedupButton = new WomBlueSmallButton();
         var _temp_8:* = _speedupButton;
         var _loc4_:String = "ui.windows.hiringquarters.speedup";
         _temp_8.label = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _speedupButton.width = 112;
         addChild(_speedupButton);
         _finishNowButton = new WomGreenSmallButton();
         var _temp_10:* = _finishNowButton;
         var _loc5_:String = "ui.windows.hiringquarters.finishnow";
         _temp_10.label = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         _finishNowButton.width = 112;
         addChild(_finishNowButton);
         _remainingDurationProgressBar = new ProgressBar19();
         _remainingDurationProgressBar.width = 92;
         addChild(_remainingDurationProgressBar);
         _remainingDurationTextField = new WomTextField();
         _remainingDurationTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         _remainingDurationTextField.autoSize = "left";
         addChild(_remainingDurationTextField);
         clockIcon = assetRepository.getDisplayObject("Clock45");
         clockIcon.scaleX = clockIcon.scaleY = 0.66;
         addChild(clockIcon);
         inProgressLabel = new CaptionTextField();
         inProgressLabel.defaultTextFormat = WomTextFormats.CENTER_16;
         inProgressLabel.width = 114;
         inProgressLabel.height = 20;
         var _temp_15:* = inProgressLabel;
         var _loc6_:String = "ui.windows.hiringquarters.inprogress";
         _temp_15.text = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         addChild(inProgressLabel);
         inQueueLabel = new CaptionTextField();
         inQueueLabel.defaultTextFormat = WomTextFormats.CENTER_16;
         inQueueLabel.width = 425;
         inQueueLabel.height = 20;
         var _temp_17:* = inQueueLabel;
         var _loc7_:String = "ui.windows.hiringquarters.inqueue";
         _temp_17.text = peak.i18n.PText.INSTANCE.getText0(_loc7_);
         addChild(inQueueLabel);
         _waitingText = new WomTextField();
         _waitingText.defaultTextFormat = WomTextFormats.CENTER_18;
         _waitingText.width = 99;
         _waitingText.height = 20;
         var _temp_19:* = _waitingText;
         var _loc8_:String = "ui.windows.hiringquarters.waiting";
         _temp_19.text = peak.i18n.PText.INSTANCE.getText0(_loc8_);
         _waitingText.visible = false;
         addChild(_waitingText);
         arrowIcon = assetRepository.getDisplayObject("HiringQuarterArrow");
         addChild(arrowIcon);
         drawLayout();
      }
      
      override protected function drawBackground() : void
      {
         var _loc7_:int = 0;
         var _loc4_:DisplayObject = null;
         var _loc6_:DisplayObject = null;
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
         _loc1_.y = 49;
         addChild(_loc1_);
         var _loc5_:Sprite = new Sprite();
         _loc5_.graphics.lineStyle(1,10915407);
         _loc5_.graphics.moveTo(0,15);
         _loc5_.graphics.lineTo(0,0);
         _loc5_.graphics.lineTo(190,0);
         _loc5_.graphics.moveTo(493,0);
         _loc5_.graphics.lineTo(683,0);
         _loc5_.graphics.lineTo(683,15);
         _loc5_.graphics.lineStyle(1,15391657);
         _loc5_.graphics.moveTo(1,1);
         _loc5_.graphics.lineTo(191,1);
         _loc5_.graphics.moveTo(493,1);
         _loc5_.graphics.lineTo(682,1);
         _loc5_.x = 32;
         _loc5_.y = 296;
         addChild(_loc5_);
         inProgressBackground = assetRepository.getDisplayObject("BackgroundLight");
         inProgressBackground.width = 115;
         inProgressBackground.height = 146;
         inProgressBackground.x = 21;
         inProgressBackground.y = 322;
         addChild(inProgressBackground);
         inProgressMercenaryBackground = assetRepository.getDisplayObject("BackgroundDark");
         inProgressMercenaryBackground.width = 99;
         inProgressMercenaryBackground.height = 99;
         addChild(inProgressMercenaryBackground);
         AlignmentUtil.alignAccordingToPositionOf(inProgressMercenaryBackground,inProgressBackground,8,20);
         inQueueBackground = assetRepository.getDisplayObject("BackgroundLight");
         inQueueBackground.width = 427;
         inQueueBackground.height = 145;
         addChild(inQueueBackground);
         AlignmentUtil.alignRightOf(inQueueBackground,inProgressBackground,170);
         var _loc8_:Array = [];
         _queuedMercenaryCancelIcons = new Vector.<QueuedMercenaryCancelIcon>();
         _loc7_ = 0;
         while(_loc7_ < 4)
         {
            _loc4_ = assetRepository.getDisplayObject("BackgroundDark");
            _loc4_.width = 99;
            _loc4_.height = 99;
            addChild(_loc4_);
            _loc8_[_loc7_] = _loc4_;
            if(_loc7_ == 0)
            {
               AlignmentUtil.alignAccordingToPositionOf(_loc4_,inQueueBackground,11,20);
            }
            else
            {
               AlignmentUtil.alignRightOf(_loc4_,_loc8_[_loc7_ - 1],3);
            }
            if(_loc7_ > _currentBuildingLevel)
            {
               _loc6_ = assetRepository.getDisplayObject("Lock");
               _loc4_.alpha = _loc6_.alpha = 0.5;
               addChild(_loc6_);
               AlignmentUtil.alignMiddleOf(_loc6_,_loc4_);
            }
            _loc2_ = _loc7_ + 1;
            _loc3_ = new QueuedMercenaryCancelIcon(assetRepository.getDisplayObject("HiringQuartersCancel"),_loc2_);
            addChild(_loc3_);
            _queuedMercenaryCancelIcons.push(_loc3_);
            AlignmentUtil.alignAccordingToPositionOf(_loc3_,_loc4_,0,0);
            _loc7_++;
         }
      }
      
      public function drawLayout() : void
      {
         _selectMercenaryPanel.x = 21;
         _selectMercenaryPanel.y = 80;
         chooseMercenaryHeader.y = 38;
         AlignmentUtil.alignBelowOf(hiringQuarterStatusHeader,chooseMercenaryHeader,224);
         AlignmentUtil.alignRightOf(_speedupButton,inProgressBackground,12);
         AlignmentUtil.alignMiddleYAxisOf(_speedupButton,inProgressBackground);
         AlignmentUtil.alignAboveOf(clockIcon,_speedupButton,5);
         AlignmentUtil.alignBelowOf(_finishNowButton,_speedupButton);
         AlignmentUtil.alignAccordingToPositionOf(_remainingDurationProgressBar,clockIcon,20,5);
         AlignmentUtil.alignAccordingToPositionOf(remainingDurationTextField,remainingDurationProgressBar,0,-18);
         remainingDurationTextField.x += 10;
         AlignmentUtil.alignRightWithYMarginOf(arrowIcon,_speedupButton,-1,6);
         AlignmentUtil.alignAccordingToPositionOf(inProgressLabel,inProgressBackground,0,-10);
         AlignmentUtil.alignAccordingToPositionOf(inQueueLabel,inQueueBackground,0,-10);
         AlignmentUtil.alignBelowOf(_waitingText,inProgressMercenaryBackground);
         if(_mercenaryInProgressView)
         {
            AlignmentUtil.alignAccordingToPositionOf(_mercenaryInProgressView,inProgressMercenaryBackground,0,0);
         }
      }
      
      public function get buildingInstanceId() : int
      {
         return _buildingInstanceId;
      }
      
      public function setMercenaryInProgress(param1:String = null) : void
      {
         if(_mercenaryInProgressView)
         {
            removeChild(_mercenaryInProgressView);
            _mercenaryInProgressView = null;
         }
         if(param1)
         {
            _mercenaryInProgressView = new HiringQuartersInProgressView(param1,buildingInstanceId,_dontAskForOverflow);
            addChild(_mercenaryInProgressView);
            drawLayout();
         }
      }
      
      public function get remainingDurationProgressBar() : WomProgressBar
      {
         return _remainingDurationProgressBar;
      }
      
      public function fillQueuedMercenaries(param1:HiringQueueInfo) : void
      {
         if(_queuedMercenaryViews)
         {
            for each(var _loc5_ in _queuedMercenaryViews)
            {
               removeChild(_loc5_);
            }
         }
         _queuedMercenaryViews = new Vector.<HiringQuartersQueuedMercenaryView>();
         var _loc2_:int = 0;
         for each(var _loc4_ in param1.hiringSlots)
         {
            _loc5_ = new HiringQuartersQueuedMercenaryView(_loc4_.unitId,_loc4_.numberOfUnits,_loc2_ + 1,_buildingInstanceId);
            if(_loc2_ == 0)
            {
               AlignmentUtil.alignAccordingToPositionOf(_loc5_,inQueueBackground,11,20);
            }
            else
            {
               AlignmentUtil.alignAccordingToPositionOf(_loc5_,_queuedMercenaryViews[_loc2_ - 1],102,0);
            }
            addChildAt(_loc5_,getChildIndex(_queuedMercenaryCancelIcons[_loc2_]));
            _queuedMercenaryViews.push(_loc5_);
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
      
      public function get waitingText() : TextField
      {
         return _waitingText;
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
      
      public function get currentBuildingLevel() : int
      {
         return _currentBuildingLevel;
      }
      
      public function get initialUnitTypeId() : int
      {
         return _initialUnitTypeId;
      }
      
      public function get remainingDurationTextField() : TextField
      {
         return _remainingDurationTextField;
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

