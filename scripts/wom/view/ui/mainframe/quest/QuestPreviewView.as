package wom.view.ui.mainframe.quest
{
   import com.greensock.TweenMax;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import peak.display.CustomCursorAwareSprite;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.game.quest.QuestInfo;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextFormats;
   
   public class QuestPreviewView extends CustomCursorAwareSprite
   {
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      private var _questIcon:DisplayObject;
      
      private var questPreviewTooltip:QuestPreviewTooltipView;
      
      private var _questInfo:QuestInfo;
      
      private var _newQuestIndicatorContainer:Sprite;
      
      private var _newQuestIndicator:DisplayObject;
      
      private var _newQuestLabel:TextField;
      
      private var _progressIndicatorContainer:Sprite;
      
      private var _progressIndicator:DisplayObject;
      
      private var _progressLabel:TextField;
      
      public function QuestPreviewView(param1:QuestInfo)
      {
         super();
         _questInfo = param1;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      private function initLayout() : void
      {
         _questIcon = assetRepository.getDisplayObject("Q" + _questInfo.questId);
         addChild(_questIcon);
         _newQuestIndicatorContainer = new Sprite();
         _newQuestIndicatorContainer.alpha = 0;
         _newQuestIndicatorContainer.visible = _questInfo.isNew;
         addChild(_newQuestIndicatorContainer);
         _newQuestIndicator = assetRepository.getDisplayObject("QuestTooltipYellowBackground");
         _newQuestIndicator.width = 153;
         _newQuestIndicatorContainer.addChild(_newQuestIndicator);
         _newQuestLabel = new CaptionTextField(WomTextFormats.BLACK_FILTER);
         _newQuestLabel.width = 120;
         _newQuestLabel.defaultTextFormat = WomTextFormats.CENTER;
         var _temp_5:* = _newQuestLabel;
         var _loc1_:String = "ui.windows.quest.new";
         var _loc2_:* = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         _temp_5.text = peak.i18n.PText.INSTANCE.activeLanguage.stringTools.toUpperCase(_loc2_);
         _newQuestIndicatorContainer.addChild(_newQuestLabel);
         _progressIndicatorContainer = new Sprite();
         _progressIndicatorContainer.alpha = 0;
         _progressIndicatorContainer.visible = _questInfo.progress;
         addChild(_progressIndicatorContainer);
         _progressIndicator = assetRepository.getDisplayObject("QuestTooltipYellowBackground");
         _progressIndicator.width = 153;
         _progressIndicatorContainer.addChild(_progressIndicator);
         _progressLabel = new CaptionTextField(WomTextFormats.BLACK_FILTER);
         _progressLabel.width = 120;
         _progressLabel.defaultTextFormat = WomTextFormats.CENTER;
         var _temp_9:* = _progressLabel;
         var _loc3_:String = "ui.windows.quest.progress";
         var _loc4_:* = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         _temp_9.text = peak.i18n.PText.INSTANCE.activeLanguage.stringTools.toUpperCase(_loc4_);
         _progressIndicatorContainer.addChild(_progressLabel);
         questPreviewTooltip = new QuestPreviewTooltipView(_questInfo);
         questPreviewTooltip.visible = false;
         addChild(questPreviewTooltip);
         drawLayout();
      }
      
      public function showIndicators() : void
      {
         if(_newQuestIndicatorContainer.visible)
         {
            TweenMax.to(_newQuestIndicatorContainer,1,{
               "onComplete":onNewQuestTweenComplete,
               "alpha":1,
               "repeat":1,
               "repeatDelay":4,
               "yoyo":true
            });
         }
         if(_progressIndicatorContainer.visible)
         {
            TweenMax.to(_progressIndicatorContainer,1,{
               "onComplete":onProgressQuestTweenComplete,
               "alpha":1,
               "repeat":1,
               "repeatDelay":4,
               "yoyo":true
            });
         }
      }
      
      private function onNewQuestTweenComplete() : void
      {
         _newQuestIndicatorContainer.alpha = 0;
         _newQuestIndicatorContainer.visible = false;
      }
      
      private function onProgressQuestTweenComplete() : void
      {
         _progressIndicatorContainer.alpha = 0;
         _progressIndicatorContainer.visible = false;
      }
      
      private function drawLayout() : void
      {
         _questIcon.x = 0;
         _questIcon.y = 0;
         questPreviewTooltip.x = 70;
         questPreviewTooltip.y = 70 - questPreviewTooltip.height;
         _newQuestIndicator.x = _progressIndicator.x = 70;
         _newQuestIndicator.y = _progressIndicator.y = 10;
         AlignmentUtil.alignAccordingToPositionOf(_newQuestLabel,_newQuestIndicator,24,9);
         AlignmentUtil.alignAccordingToPositionOf(_progressLabel,_progressIndicator,24,9);
      }
      
      public function showTooltip() : void
      {
         questPreviewTooltip.visible = true;
      }
      
      public function hideTooltip() : void
      {
         questPreviewTooltip.visible = false;
      }
      
      public function get questIcon() : DisplayObject
      {
         return _questIcon;
      }
      
      public function get questInfo() : QuestInfo
      {
         return _questInfo;
      }
   }
}

