package wom.view.ui.mainframe.quest
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.game.quest.QuestInfo;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.AutoSizingCaptionTextField;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   
   public class QuestPreviewTooltipView extends Sprite
   {
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      private var _questInfo:QuestInfo;
      
      private var _bg:DisplayObject;
      
      private var titleTextField:TextField;
      
      private var taskViews:Vector.<QuestPreviewTaskView>;
      
      private var detailsTextField:TextField;
      
      public function QuestPreviewTooltipView(param1:QuestInfo)
      {
         super();
         this.mouseChildren = false;
         this.mouseEnabled = false;
         this.buttonMode = false;
         _questInfo = param1;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      private function initLayout() : void
      {
         var _loc3_:int = 0;
         var _loc1_:QuestPreviewTaskView = null;
         drawBackground();
         titleTextField = new AutoSizingCaptionTextField();
         titleTextField.defaultTextFormat = WomTextFormats.CENTER_18;
         titleTextField.width = _bg.width - 10;
         var _loc2_:String = "";
         var _temp_3:* = titleTextField;
         var _temp_2:* = _loc2_;
         var _loc4_:String = "quest." + _questInfo.questId + ".title";
         _temp_3.text = _temp_2 + peak.i18n.PText.INSTANCE.getText0(_loc4_);
         addChild(titleTextField);
         taskViews = new Vector.<QuestPreviewTaskView>();
         _loc3_ = 0;
         while(_loc3_ < _questInfo.tasks.length)
         {
            _loc1_ = new QuestPreviewTaskView(_questInfo.tasks[_loc3_]);
            addChild(_loc1_);
            taskViews.push(_loc1_);
            _loc3_++;
         }
         detailsTextField = new WomTextField();
         detailsTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         detailsTextField.autoSize = "left";
         var _temp_6:* = detailsTextField;
         var _loc5_:String = "ui.windows.quest.clickfordetails";
         _temp_6.text = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         addChild(detailsTextField);
         drawLayout();
      }
      
      private function drawBackground() : void
      {
         _bg = assetRepository.getDisplayObject("QuestPreviewYellowBackground");
         _bg.width = 257;
         _bg.height = _questInfo.tasks.length == 3 ? 191 : (_questInfo.tasks.length == 2 ? 146 : 101);
         addChildAt(_bg,0);
      }
      
      private function drawLayout() : void
      {
         var _loc2_:int = 0;
         titleTextField.x = 5;
         titleTextField.y = 10;
         var _loc1_:DisplayObject = null;
         _loc2_ = 0;
         while(_loc2_ < taskViews.length)
         {
            if(_loc2_ == 0)
            {
               taskViews[_loc2_].x = 21;
               taskViews[_loc2_].y = 32;
            }
            else
            {
               AlignmentUtil.alignHeightSpecifiedBelowOf(taskViews[_loc2_],_loc1_,2,43);
            }
            _loc1_ = taskViews[_loc2_];
            _loc2_++;
         }
         detailsTextField.y = _bg.height - 26;
         AlignmentUtil.alignMiddleXAxisOf(detailsTextField,_bg);
      }
   }
}

