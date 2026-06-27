package wom.view.screen.windows.quest
{
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.dto.TaskDTO;
   import wom.model.game.quest.QuestInfo;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.util.MobileGenericWindow;
   
   public class MobileQuestDetailWindow extends MobileGenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 653;
      
      private static const WINDOW_HEIGHT:int = 578;
      
      private var _questInfo:QuestInfo;
      
      private var _skipAllAvailable:Boolean;
      
      private var _skipAllCost:int = 0;
      
      private var _taskViews:Vector.<MobileQuestDetailTaskView>;
      
      private var _skipAllButton:MobileWomButton;
      
      private var bg:DisplayObject;
      
      private var _backButton:MobileWomButton;
      
      public function MobileQuestDetailWindow(param1:QuestInfo, param2:Vector.<WindowEnumeration> = null)
      {
         _questInfo = param1;
         super(653,578,param2);
      }
      
      override protected function initLayout() : void
      {
         var _loc3_:int = 0;
         var _loc1_:MobileQuestDetailTaskView = null;
         super.initLayout();
         var _temp_1:* = "ui.windows.quest.header";
         var _loc4_:String = "quest." + _questInfo.questId + ".title";
         var _loc5_:* = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         var _loc6_:String = _temp_1;
         setHeader(peak.i18n.PText.INSTANCE.getText1(_loc6_,_loc5_));
         bg = assetRepository.getDisplayObject("MobileBeigeBackground");
         bg.width = this._windowWidth - 60;
         bg.height = this._windowHeight - 60;
         addChild(bg);
         _skipAllButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Large");
         _skipAllButton.width = 286;
         var _temp_5:* = _skipAllButton;
         var _loc7_:String = "m.ui.windows.quest.skipalltasks";
         _temp_5.label = peak.i18n.PText.INSTANCE.getText0(_loc7_);
         addChild(_skipAllButton);
         var _loc2_:DisplayObject = assetRepository.getDisplayObject("IconBack");
         _backButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Medium");
         _backButton.iconAndRightLabelMargin = 0;
         _backButton.width = 130;
         _backButton.defaultIcon = _loc2_;
         var _temp_7:* = _backButton;
         var _loc8_:String = "ui.popups.event.main.back";
         _temp_7.rightLabel = peak.i18n.PText.INSTANCE.getText0(_loc8_);
         addChild(_backButton);
         _taskViews = new Vector.<MobileQuestDetailTaskView>();
         _loc3_ = 0;
         while(_loc3_ < _questInfo.tasks.length)
         {
            _loc1_ = new MobileQuestDetailTaskView(_questInfo.tasks[_loc3_]);
            addChild(_loc1_);
            _taskViews.push(_loc1_);
            _loc3_++;
         }
         calculateAndShowSkipAllCost();
         drawLayout();
      }
      
      public function calculateAndShowSkipAllCost() : void
      {
         var _loc2_:int = 0;
         var _loc1_:TaskDTO = null;
         _skipAllCost = 0;
         _skipAllAvailable = true;
         _loc2_ = 0;
         while(_loc2_ < _questInfo.tasks.length)
         {
            _loc1_ = _questInfo.tasks[_loc2_];
            if(!_loc1_.skippable && !_loc1_.completed)
            {
               _skipAllAvailable = false;
            }
            if(_loc1_.skippable && !_loc1_.skipped && !_loc1_.completed)
            {
               _skipAllCost += _loc1_.skipCost;
            }
            _loc2_++;
         }
         if(_skipAllAvailable && _skipAllCost > 0)
         {
            _skipAllButton.rightLabel = _skipAllCost.toString();
            _skipAllButton.defaultIcon = assetRepository.getDisplayObject("IconGoldM");
            _skipAllButton.invalidate("styles");
         }
         else
         {
            _skipAllButton.rightLabel = "";
            var _temp_9:* = _skipAllButton;
            var _loc3_:String = "ui.windows.quest.ok";
            _temp_9.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
            _skipAllButton.defaultIcon = null;
            _skipAllButton.invalidate("styles");
         }
      }
      
      public function drawLayout() : void
      {
         var _loc2_:int = 0;
         MobileAlignmentUtil.alignMiddleOf(bg,_background);
         var _loc1_:MobileQuestDetailTaskView = null;
         _loc2_ = 0;
         while(_loc2_ < _taskViews.length)
         {
            if(_loc2_ == 0)
            {
               var _temp_4:* = MobileAlignmentUtil;
               var _temp_3:* = _taskViews[0];
               var _temp_2:* = bg;
               var _temp_1:* = bg.width;
               var _loc3_:MobileQuestDetailTaskView = MobileQuestDetailTaskView;
               _temp_4.alignAccordingToPositionOf(_temp_3,_temp_2,_temp_1 - 549 >> 1,20);
            }
            else
            {
               var _temp_8:* = MobileAlignmentUtil;
               var _temp_7:* = _taskViews[_loc2_];
               var _temp_6:* = _loc1_;
               var _temp_5:* = 20;
               var _loc4_:MobileQuestDetailTaskView = MobileQuestDetailTaskView;
               _temp_8.alignHeightSpecifiedBelowOf(_temp_7,_temp_6,_temp_5,140);
            }
            _loc1_ = _taskViews[_loc2_] as MobileQuestDetailTaskView;
            _loc2_++;
         }
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_skipAllButton,_background,_background.height - int(_skipAllButton.height / 2));
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_backButton,_skipAllButton,-_backButton.width - 10);
      }
      
      public function get questInfo() : QuestInfo
      {
         return _questInfo;
      }
      
      public function get skipAllButton() : MobileWomButton
      {
         return _skipAllButton;
      }
      
      public function checkQuestComplete() : Boolean
      {
         return _questInfo.completed;
      }
      
      public function set questInfo(param1:QuestInfo) : void
      {
         _questInfo = param1;
      }
      
      public function get taskViews() : Vector.<MobileQuestDetailTaskView>
      {
         return _taskViews;
      }
      
      public function get skipAllCost() : int
      {
         return _skipAllCost;
      }
      
      public function get backButton() : MobileWomButton
      {
         return _backButton;
      }
      
      public function get skipAllAvailable() : Boolean
      {
         return _skipAllAvailable;
      }
   }
}

