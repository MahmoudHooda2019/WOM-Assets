package wom.view.ui.mainframe.quest
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import peak.util.NumberUtil;
   import wom.model.dto.TaskDTO;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   
   public class QuestPreviewTaskView extends Sprite
   {
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      private var _taskInfo:TaskDTO;
      
      private var bg:DisplayObject;
      
      private var progressPanel:DisplayObject;
      
      private var descriptionTextField:TextField;
      
      private var currentProgressTextField:TextField;
      
      private var maxProgressTextField:TextField;
      
      private var progressLine:DisplayObject;
      
      private var completedIcon:DisplayObject;
      
      public function QuestPreviewTaskView(param1:TaskDTO)
      {
         super();
         this.mouseChildren = false;
         this.mouseEnabled = false;
         this.buttonMode = false;
         _taskInfo = param1;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      private function initLayout() : void
      {
         drawBackground();
         descriptionTextField = new WomTextField();
         descriptionTextField.width = 155;
         descriptionTextField.multiline = true;
         descriptionTextField.wordWrap = true;
         var _loc1_:String = "";
         var _temp_3:* = descriptionTextField;
         var _temp_2:* = _loc1_;
         var _loc2_:String = "task." + _taskInfo.taskId + ".title";
         _temp_3.text = _temp_2 + peak.i18n.PText.INSTANCE.getText0(_loc2_);
         addChild(descriptionTextField);
         descriptionTextField.height = descriptionTextField.textHeight + 4;
         completedIcon = assetRepository.getDisplayObject("MainQuestPreviewComplete");
         completedIcon.visible = _taskInfo.completed;
         addChild(completedIcon);
         currentProgressTextField = new CaptionTextField();
         currentProgressTextField.defaultTextFormat = WomTextFormats.RIGHT_16;
         currentProgressTextField.width = 45;
         currentProgressTextField.height = 20;
         currentProgressTextField.autoSize = "left";
         currentProgressTextField.text = NumberUtil.prettyFormat(_taskInfo.progressValue,null,null,null,3,6);
         addChild(currentProgressTextField);
         maxProgressTextField = new CaptionTextField();
         maxProgressTextField.defaultTextFormat = WomTextFormats.RIGHT_16;
         maxProgressTextField.width = 45;
         maxProgressTextField.height = 20;
         maxProgressTextField.autoSize = "left";
         maxProgressTextField.text = NumberUtil.prettyFormat(_taskInfo.maxProgressValue,null,null,null,3,6);
         addChild(maxProgressTextField);
         progressLine = assetRepository.getDisplayObject("QuestPanelProgressLine");
         progressLine.width = 38;
         addChild(progressLine);
         currentProgressTextField.visible = maxProgressTextField.visible = progressLine.visible = !completedIcon.visible && _taskInfo.maxProgressValue > 1;
         drawLayout();
      }
      
      private function drawBackground() : void
      {
         var _loc1_:String = _taskInfo.completed ? "BackgroundGreen" : "BackgroundLight";
         bg = assetRepository.getDisplayObject(_loc1_);
         bg.width = 222;
         bg.height = 43;
         addChildAt(bg,0);
         progressPanel = assetRepository.getDisplayObject("QuestTooltipBar");
         progressPanel.visible = !_taskInfo.completed && _taskInfo.maxProgressValue > 1;
         addChildAt(progressPanel,1);
         AlignmentUtil.alignAccordingToPositionOf(progressPanel,bg,bg.width - progressPanel.width,1);
      }
      
      private function drawLayout() : void
      {
         var _loc1_:TextFormat = null;
         descriptionTextField.width = progressPanel.visible || completedIcon.visible ? 155 : 205;
         if(descriptionTextField.numLines >= 3)
         {
            _loc1_ = WomTextFormats.FONT_SIZE_14;
            descriptionTextField.defaultTextFormat = _loc1_;
            descriptionTextField.setTextFormat(_loc1_);
            descriptionTextField.height = descriptionTextField.textHeight + 4;
         }
         descriptionTextField.x = 10;
         descriptionTextField.y = (bg.height - descriptionTextField.textHeight - 4 >> 1) + (descriptionTextField.numLines >= 3 ? 2 : 0);
         AlignmentUtil.alignMiddleOf(progressLine,progressPanel);
         AlignmentUtil.alignAboveOf(currentProgressTextField,progressLine,-5);
         AlignmentUtil.alignMiddleXAxisOf(currentProgressTextField,progressPanel);
         AlignmentUtil.alignBelowOf(maxProgressTextField,progressLine,-5);
         AlignmentUtil.alignMiddleXAxisOf(maxProgressTextField,progressPanel);
         AlignmentUtil.alignMiddleOf(completedIcon,progressPanel);
      }
   }
}

