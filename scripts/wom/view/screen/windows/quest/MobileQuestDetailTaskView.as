package wom.view.screen.windows.quest
{
   import peak.component.mobile.MPBitmapFontTextFormat;
   import peak.component.mobile.MPRigidButton;
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import peak.util.NumberUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.dto.TaskDTO;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   
   public class MobileQuestDetailTaskView extends Sprite
   {
      
      public static const BG_WIDTH:int = 549;
      
      public static const BG_HEIGHT:int = 140;
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _taskInfo:TaskDTO;
      
      private var _bg:DisplayObject;
      
      private var descriptionTextField:MPTextField;
      
      private var hintTextField:MPTextField;
      
      private var progressTextField:MPTextField;
      
      private var currentProgress:int;
      
      private var maxProgress:int;
      
      private var _completedIcon:DisplayObject;
      
      private var _skipButton:MobileWomButton;
      
      private var _hintButton:MPRigidButton;
      
      private var _directionButton:MobileWomButton;
      
      private var _directionButtonVisible:Boolean;
      
      public function MobileQuestDetailTaskView(param1:TaskDTO)
      {
         super();
         _taskInfo = param1;
         _directionButtonVisible = false;
      }
      
      public static function get visibleHeight() : int
      {
         return 140;
      }
      
      public static function get visibleWidth() : int
      {
         return 549;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      private function initLayout() : void
      {
         drawBackground();
         progressTextField = createAndAddCaptionTextField("",120,true,getCaptionTextFormat(38));
         descriptionTextField = createAndAddCaptionTextField("",330,true,getCaptionTextFormat(21,"center"));
         hintTextField = createAndAddCaptionTextField("",430,true,getCaptionTextFormat(21));
         hintTextField.visible = false;
         _completedIcon = assetRepository.getDisplayObject("SymbolTickApproved");
         addChild(_completedIcon);
         var _loc1_:DisplayObject = assetRepository.getDisplayObject("IconGoldM");
         _skipButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Medium");
         _skipButton.width = 226;
         var _temp_6:* = _skipButton;
         var _loc3_:String = "ui.windows.quest.skiptask";
         _temp_6.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         _skipButton.defaultIcon = _loc1_;
         addChild(_skipButton);
         _directionButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Medium");
         _directionButton.width = 217;
         var _loc4_:String = "task." + _taskInfo.taskId + ".gototext";
         var _loc2_:String = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         var _loc5_:String;
         _directionButton.label = _loc2_ != "[notext]" ? _loc2_ : (_loc5_ = "ui.windows.quest.direction",peak.i18n.PText.INSTANCE.getText0(_loc5_));
         addChild(_directionButton);
         _hintButton = new MPRigidButton("ButtonInfo","ButtonInfoHover");
         addChild(_hintButton);
         progressTextField.visible = _taskInfo.maxProgressValue > 1;
         drawLayout();
      }
      
      private function createAndAddCaptionTextField(param1:String, param2:Object, param3:Boolean, param4:MPBitmapFontTextFormat) : MobileCaptionTextField
      {
         var _loc5_:MobileCaptionTextField = new MobileCaptionTextField();
         _loc5_.textRendererProperties.textFormat = param4;
         _loc5_.textRendererProperties.wordWrap = param3;
         if(param2)
         {
            _loc5_.width = int(param2);
         }
         _loc5_.text = param1;
         addChild(_loc5_);
         return _loc5_;
      }
      
      private function drawBackground() : void
      {
         var _loc1_:String = "MobileDarkBackground";
         _bg = assetRepository.getDisplayObject(_loc1_);
         _bg.width = 549;
         _bg.height = 140;
         addChildAt(_bg,0);
      }
      
      private function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(progressTextField,_bg,20,25);
         MobileAlignmentUtil.alignAccordingToPositionOf(_directionButton,_bg,77,62);
         MobileAlignmentUtil.alignAccordingToPositionOf(_hintButton,_bg,-10,-10);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_completedIcon,_bg,35);
         hintTextField.validate();
         hintTextField.y = (_bg.height - (hintTextField.height + 5)) / 2 << 0;
         hintTextField.x = 115;
         if(_skipButton.visible || _directionButton.visible)
         {
            MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(descriptionTextField,_bg,30);
            if(_skipButton.visible && !_directionButton.visible)
            {
               MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_skipButton,_bg,72);
            }
            else if(!_skipButton.visible && _directionButton.visible)
            {
               MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_directionButton,_bg,72);
            }
            else
            {
               MobileAlignmentUtil.alignAccordingToPositionOf(_directionButton,_bg,45,72);
               MobileAlignmentUtil.alignRightOf(_skipButton,_directionButton,16);
            }
         }
         else
         {
            MobileAlignmentUtil.alignMiddleOf(descriptionTextField,_bg);
         }
         if(_taskInfo.completed)
         {
            progressTextField.visible = false;
         }
      }
      
      private function checkMapQuestTasks(param1:TaskDTO) : Boolean
      {
         return param1.taskId == 62003 || param1.taskId == 45003;
      }
      
      public function updateWithTaskInfo(param1:TaskDTO, param2:Boolean = false) : void
      {
         progressTextField.visible = _taskInfo.maxProgressValue > 1;
         _taskInfo = param1;
         _directionButtonVisible = !checkMapQuestTasks(param1) && param2 && !_taskInfo.completed;
         currentProgress = _taskInfo.progressValue;
         maxProgress = _taskInfo.maxProgressValue;
         updateProgressTextField();
         var _temp_7:* = descriptionTextField;
         var _loc5_:String = "task." + _taskInfo.taskId + ".title";
         _temp_7.text = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         _hintButton.visible = !_taskInfo.completed;
         var _loc6_:String = "m.task." + _taskInfo.taskId + ".hint";
         var _loc3_:String = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         if(_loc3_ == "[notext]")
         {
            var _temp_8:* = hintTextField;
            var _loc7_:String = "task." + _taskInfo.taskId + ".hint";
            _temp_8.text = peak.i18n.PText.INSTANCE.getText0(_loc7_);
         }
         else
         {
            hintTextField.text = _loc3_;
         }
         _completedIcon.visible = _taskInfo.completed;
         _skipButton.visible = _taskInfo.skippable && !_completedIcon.visible;
         _skipButton.rightLabel = _taskInfo.skipCost.toString();
         var _loc8_:String = "task." + _taskInfo.taskId + ".gototext";
         var _loc4_:String = peak.i18n.PText.INSTANCE.getText0(_loc8_);
         var _loc9_:String;
         _directionButton.label = _loc4_ != "[notext]" ? _loc4_ : (_loc9_ = "ui.windows.quest.direction",peak.i18n.PText.INSTANCE.getText0(_loc9_));
         _directionButton.visible = _directionButtonVisible;
         drawLayout();
      }
      
      public function get skipButton() : MobileWomButton
      {
         return _skipButton;
      }
      
      public function get taskInfo() : TaskDTO
      {
         return _taskInfo;
      }
      
      public function get hintButton() : MPRigidButton
      {
         return _hintButton;
      }
      
      public function toggleHint(param1:Boolean) : void
      {
         hintTextField.visible = param1;
         descriptionTextField.visible = !param1;
         _completedIcon.visible = _taskInfo.completed && !param1;
         _skipButton.visible = _taskInfo.skippable && !_completedIcon.visible && !param1;
         _directionButton.visible = _directionButtonVisible && !param1;
         drawLayout();
      }
      
      public function get directionButton() : MobileWomButton
      {
         return _directionButton;
      }
      
      public function isHintVisible() : Boolean
      {
         return hintTextField.visible;
      }
      
      public function updateProgressTextField() : void
      {
         var _loc2_:String = NumberUtil.prettyFormat(currentProgress,null,null,null,3,6);
         var _loc1_:String = NumberUtil.prettyFormat(maxProgress,null,null,null,3,6);
         progressTextField.text = _loc2_ + "/" + _loc1_;
      }
      
      public function get bg() : DisplayObject
      {
         return _bg;
      }
   }
}

