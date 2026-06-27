package wom.view.screen.windows.quest
{
   import feathers.controls.Button;
   import peak.component.mobile.MPBitmapFontTextFormat;
   import peak.component.mobile.MPButton;
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Quad;
   import starling.display.Sprite;
   import wom.model.dto.QuestRewardDTO;
   import wom.model.dto.RewardDTO;
   import wom.model.dto.TaskDTO;
   import wom.model.game.quest.QuestInfo;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   
   public class MobileQuestRowView extends Sprite
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _questInfo:QuestInfo;
      
      private var bg:DisplayObject;
      
      private var taskSeparator:Quad;
      
      private var questIconBg:DisplayObject;
      
      private var questIcon:DisplayObject;
      
      private var currentTaskProgressTextField:MPTextField;
      
      private var maxTaskProgressTextField:MPTextField;
      
      private var questNameTextField:MPTextField;
      
      private var _rewardView:MobileRewardGroupView;
      
      private var _detailsButton:MPButton;
      
      public function MobileQuestRowView(param1:QuestInfo)
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
         var _loc3_:int = 0;
         for each(var _loc1_ in questInfo.tasks)
         {
            if(_loc1_.completed)
            {
               _loc3_++;
            }
         }
         bg = assetRepository.getDisplayObject("MobileBeigeBackground");
         bg.width = 751;
         bg.height = 143;
         addChild(bg);
         taskSeparator = new Quad(25,1,3615242);
         addChild(taskSeparator);
         questIconBg = assetRepository.getDisplayObject("QuestsBackground");
         addChild(questIconBg);
         questIcon = assetRepository.getDisplayObject("Q" + _questInfo.questId);
         addChild(questIcon);
         currentTaskProgressTextField = createAndAddCaptionTextField("" + _loc3_,25,true,getCaptionTextFormat(21,"center"));
         maxTaskProgressTextField = createAndAddCaptionTextField("" + _questInfo.tasks.length,25,true,getCaptionTextFormat(21,"center"));
         var _loc9_:String = "quest." + _questInfo.questId + ".title";
         questNameTextField = createAndAddCaptionTextField(peak.i18n.PText.INSTANCE.getText0(_loc9_),null,false,getCaptionTextFormat(30));
         var _temp_9:* = §§findproperty(MobileRewardGroupView);
         var _loc10_:String = "ui.popups.questcompleted.rewards";
         _rewardView = new MobileRewardGroupView(peak.i18n.PText.INSTANCE.getText0(_loc10_),getCaptionTextFormat(23),0,412,95);
         addChild(_rewardView);
         var _loc2_:Vector.<RewardDTO> = new Vector.<RewardDTO>();
         for each(var _loc4_ in _questInfo.rewards)
         {
            _loc2_.push(_loc4_);
         }
         _rewardView.updateWithRewards(_loc2_);
         _detailsButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Medium");
         _detailsButton.setPaddings(606,18,42,38);
         _detailsButton.width = 127;
         var _temp_12:* = _detailsButton;
         var _loc11_:String = "ui.windows.quest.details";
         _temp_12.label = peak.i18n.PText.INSTANCE.getText0(_loc11_);
         addChild(_detailsButton);
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
         addChild(_loc5_);
         _loc5_.text = param1;
         return _loc5_;
      }
      
      private function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(questIconBg,bg,23,20);
         MobileAlignmentUtil.alignAccordingToPositionOf(questIcon,questIconBg,0,0);
         MobileAlignmentUtil.alignAccordingToPositionOf(taskSeparator,bg,135,66);
         MobileAlignmentUtil.alignAccordingToPositionOf(currentTaskProgressTextField,bg,133,47);
         MobileAlignmentUtil.alignAccordingToPositionOf(maxTaskProgressTextField,bg,133,71);
         MobileAlignmentUtil.alignAccordingToPositionOf(questNameTextField,bg,29,-(questNameTextField.height >> 1) + 3);
         MobileAlignmentUtil.alignAccordingToPositionOf(_rewardView,bg,180,21);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_detailsButton,_rewardView,_rewardView.width + 14);
      }
      
      public function get questInfo() : QuestInfo
      {
         return _questInfo;
      }
      
      public function get detailsButton() : Button
      {
         return _detailsButton;
      }
   }
}

