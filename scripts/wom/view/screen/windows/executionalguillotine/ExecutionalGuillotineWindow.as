package wom.view.screen.windows.executionalguillotine
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.WomButton;
   import wom.view.component.button.colored.WomBrownSmallButton;
   import wom.view.component.button.colored.WomGreenLargeButton;
   import wom.view.component.button.colored.WomRedLargeButton;
   import wom.view.component.progressbar.ProgressBar30;
   import wom.view.component.progressbar.WomProgressBar;
   import wom.view.util.GenericWindow;
   
   public class ExecutionalGuillotineWindow extends GenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 731;
      
      private static const WINDOW_HEIGHT:int = 470;
      
      public static const EXECUTIONAL_GUILLOTINE:int = 1;
      
      public static const MERCENARY_BARRACKS:int = 2;
      
      public static const ALLIANCE_BARRACKS:int = 3;
      
      public static const FRIEND_WATCHPOST:int = 4;
      
      protected var executeQuestion:TextField;
      
      protected var executeExplanation:TextField;
      
      protected var _mercenaryViews:Vector.<ExecutionalGuillotineMercenaryView>;
      
      private var mercenaryViewHolder:Sprite;
      
      private var capacityLabel:TextField;
      
      private var _capacityStatus:TextField;
      
      protected var _capacityPercentage:TextField;
      
      private var _capacityProgress:WomProgressBar;
      
      protected var _selectAllButton:WomButton;
      
      protected var _executeButton:WomButton;
      
      protected var _cancelButton:WomButton;
      
      private var _closeRedButton:WomButton;
      
      private var _viewType:int;
      
      public function ExecutionalGuillotineWindow(param1:int = 1, param2:int = 731, param3:int = 470)
      {
         super(param2,param3);
         _viewType = param1;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.windows." + (_viewType == 1 ? "executionalguillotine" : (_viewType == 2 ? "mercenarybarracks" : (_viewType == 3 ? "alliancebarracks" : (_viewType == 4 ? "friendwatchpost" : "watchpost")))) + ".header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         executeQuestion = new CaptionTextField();
         executeQuestion.defaultTextFormat = WomTextFormats.CENTER_18;
         executeQuestion.width = 731;
         executeQuestion.height = 22;
         var _loc2_:String;
         var _loc3_:String;
         var _loc4_:String;
         var _loc5_:String;
         executeQuestion.text = _viewType == 1 ? (_loc2_ = "ui.windows.executionalguillotine.question",peak.i18n.PText.INSTANCE.getText0(_loc2_)) : (_viewType == 2 ? (_loc3_ = "ui.windows.mercenarybarracks.subheadernew",peak.i18n.PText.INSTANCE.getText0(_loc3_)) : (_viewType == 3 ? (_loc4_ = "ui.windows.alliancebarracks.subheader",peak.i18n.PText.INSTANCE.getText0(_loc4_)) : (_loc5_ = "ui.windows.friendwatchpost.subheader",peak.i18n.PText.INSTANCE.getText0(_loc5_))));
         addChild(executeQuestion);
         executeExplanation = new WomTextField();
         executeExplanation.defaultTextFormat = WomTextFormats.CENTER_18;
         executeExplanation.width = 731;
         executeExplanation.height = 22;
         var _temp_4:* = executeExplanation;
         var _loc6_:String = "ui.windows.executionalguillotine.explanation";
         _temp_4.text = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         executeExplanation.visible = _viewType == 1;
         addChild(executeExplanation);
         mercenaryViewHolder = new Sprite();
         addChild(mercenaryViewHolder);
         capacityLabel = new CaptionTextField(WomTextFormats.BLACK_FILTER);
         capacityLabel.defaultTextFormat = WomTextFormats.FONT_SIZE_18;
         capacityLabel.multiline = true;
         capacityLabel.wordWrap = true;
         capacityLabel.autoSize = "left";
         capacityLabel.width = 260;
         var _loc7_:String;
         var _loc8_:String;
         var _loc9_:String;
         capacityLabel.text = _viewType == 3 ? (_loc7_ = "ui.windows.alliancebarracks.capacity",peak.i18n.PText.INSTANCE.getText0(_loc7_)) : (_viewType == 4 ? (_loc8_ = "ui.windows.friendwatchpost.capacity",peak.i18n.PText.INSTANCE.getText0(_loc8_)) : (_loc9_ = "ui.windows.executionalguillotine.capacitycombined",peak.i18n.PText.INSTANCE.getText0(_loc9_)));
         addChild(capacityLabel);
         _capacityProgress = new ProgressBar30();
         _capacityProgress.width = 388;
         _capacityProgress.height = 30;
         addChild(_capacityProgress);
         _capacityStatus = new CaptionTextField();
         _capacityStatus.defaultTextFormat = WomTextFormats.CENTER_18;
         _capacityStatus.autoSize = "left";
         addChild(_capacityStatus);
         _capacityPercentage = new CaptionTextField();
         _capacityPercentage.defaultTextFormat = WomTextFormats.CENTER_18;
         _capacityPercentage.autoSize = "right";
         _capacityPercentage.visible = _viewType == 1;
         addChild(_capacityPercentage);
         _selectAllButton = new WomBrownSmallButton();
         _selectAllButton.textField.defaultTextFormat = WomTextFormats.CENTER_18;
         _selectAllButton.width = 132;
         var _temp_11:* = _selectAllButton;
         var _loc10_:String = "ui.windows.executionalguillotine.selectall";
         _temp_11.label = peak.i18n.PText.INSTANCE.getText0(_loc10_);
         _selectAllButton.visible = _viewType == 1;
         addChild(_selectAllButton);
         _cancelButton = new WomRedLargeButton();
         _cancelButton.width = 138;
         var _temp_13:* = _cancelButton;
         var _loc11_:String = "ui.windows.executionalguillotine.cancel";
         _temp_13.label = peak.i18n.PText.INSTANCE.getText0(_loc11_);
         _cancelButton.visible = _viewType == 1;
         addChild(_cancelButton);
         _executeButton = new WomGreenLargeButton();
         _executeButton.width = 179;
         var _temp_15:* = _executeButton;
         var _loc12_:String = "ui.windows.executionalguillotine.execute";
         _temp_15.label = peak.i18n.PText.INSTANCE.getText0(_loc12_);
         _executeButton.visible = _viewType == 1;
         addChild(_executeButton);
         _closeRedButton = new WomRedLargeButton();
         _closeRedButton.width = 138;
         var _temp_17:* = _closeRedButton;
         var _loc13_:String = "ui.windows.mercenarybarracks.close";
         _temp_17.label = peak.i18n.PText.INSTANCE.getText0(_loc13_);
         _closeRedButton.visible = _viewType != 1;
         addChild(_closeRedButton);
      }
      
      public function drawLayout() : void
      {
         var _loc1_:int = 0;
         executeQuestion.y = _viewType != 1 ? 32 : 24;
         AlignmentUtil.alignBelowOf(executeExplanation,executeQuestion,1);
         mercenaryViewHolder.x = 28;
         mercenaryViewHolder.y = _viewType != 1 ? 61 : 71;
         _loc1_ = 1;
         while(_loc1_ < _mercenaryViews.length)
         {
            if(_loc1_ % 3 == 0)
            {
               AlignmentUtil.alignBelowOf(_mercenaryViews[_loc1_],_mercenaryViews[_loc1_ - 3],3);
            }
            else
            {
               AlignmentUtil.alignRightOf(_mercenaryViews[_loc1_],_mercenaryViews[_loc1_ - 1],3);
            }
            _loc1_++;
         }
         AlignmentUtil.alignBelowWithXMarginOf(_selectAllButton,mercenaryViewHolder,mercenaryViewHolder.width - _selectAllButton.width);
         AlignmentUtil.alignBelowWithXMarginOf(_capacityProgress,mercenaryViewHolder,mercenaryViewHolder.width - _capacityProgress.width,_viewType != 1 ? 5 : 10 + _selectAllButton.height);
         AlignmentUtil.alignBelowOf(capacityLabel,mercenaryViewHolder);
         AlignmentUtil.alignMiddleYAxisOf(capacityLabel,_capacityProgress);
         _capacityStatus.x = _capacityProgress.x + 14;
         _capacityStatus.y = _capacityProgress.y + 5;
         _capacityPercentage.x = _capacityProgress.x + _capacityProgress.width - _capacityPercentage.width - 20;
         _capacityPercentage.y = _capacityProgress.y + 5;
         _cancelButton.x = _background.width - _cancelButton.width - _executeButton.width - 8 >> 1;
         _cancelButton.y = _background.height - (_cancelButton.height >> 1) - 4;
         AlignmentUtil.alignRightOf(_executeButton,_cancelButton,8);
         AlignmentUtil.alignMiddleXAxisOf(_closeRedButton,_background);
         _closeRedButton.y = _cancelButton.y;
      }
      
      public function addMercenaries(param1:Vector.<UnitTypeDIO>) : void
      {
         var _loc3_:ExecutionalGuillotineMercenaryView = null;
         clearMercenaryViewHolder();
         _mercenaryViews = new Vector.<ExecutionalGuillotineMercenaryView>();
         for each(var _loc2_ in param1)
         {
            _loc3_ = new ExecutionalGuillotineMercenaryView(_loc2_,_viewType);
            _mercenaryViews.push(_loc3_);
            mercenaryViewHolder.addChild(_loc3_);
         }
         drawLayout();
      }
      
      private function clearMercenaryViewHolder() : void
      {
         removeChild(mercenaryViewHolder);
         mercenaryViewHolder = new Sprite();
         addChild(mercenaryViewHolder);
      }
      
      public function get mercenaryViews() : Vector.<ExecutionalGuillotineMercenaryView>
      {
         return _mercenaryViews;
      }
      
      public function get capacityStatus() : TextField
      {
         return _capacityStatus;
      }
      
      public function get capacityPercentage() : TextField
      {
         return _capacityPercentage;
      }
      
      public function get capacityProgress() : WomProgressBar
      {
         return _capacityProgress;
      }
      
      public function get selectAllButton() : WomButton
      {
         return _selectAllButton;
      }
      
      public function get executeButton() : WomButton
      {
         return _executeButton;
      }
      
      public function get cancelButton() : WomButton
      {
         return _cancelButton;
      }
      
      public function get closeRedButton() : WomButton
      {
         return _closeRedButton;
      }
      
      public function get viewType() : int
      {
         return _viewType;
      }
   }
}

