package wom.view.screen.windows.quest
{
   import peak.component.mobile.MPBitmapFontTextFormat;
   import peak.component.mobile.MPTextField;
   import peak.display.View;
   import peak.util.MobileAlignmentUtil;
   import peak.util.NumberUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.dto.QuestRewardDTO;
   import wom.model.dto.RewardDTO;
   import wom.model.game.quest.QuestRewardType;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.ui.common.MobileIconLabelView;
   
   public class MobileRewardGroupView extends Sprite implements View
   {
      
      public static const TYPE_DEFAULT:int = 0;
      
      public static const TYPE_QUEST_COMPLETED:int = 1;
      
      private static const VIEW_WIDTH:int = 100;
      
      private static const VIEW_HEIGHT:int = 50;
      
      private static const MARGIN:int = 5;
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _rewardLabel:String;
      
      private var _textFormat:MPBitmapFontTextFormat;
      
      private var _type:int;
      
      private var _viewWidth:int;
      
      private var _viewHeight:int;
      
      private var _background:DisplayObject;
      
      private var _rewardLabelTextField:MPTextField;
      
      private var _rewardViews:Vector.<MobileIconLabelView>;
      
      public function MobileRewardGroupView(param1:String, param2:MPBitmapFontTextFormat, param3:int = 0, param4:int = 100, param5:int = 50)
      {
         super();
         _rewardLabel = param1;
         _textFormat = param2;
         _type = param3;
         _viewWidth = param4;
         _viewHeight = param5;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         _background = assetRepository.getDisplayObject("MobileDarkBackground");
         _background.width = _viewWidth;
         _background.height = _viewHeight;
         addChild(_background);
         _rewardLabelTextField = new MobileCaptionTextField();
         _rewardLabelTextField.textRendererProperties.textFormat = _textFormat;
         addChild(_rewardLabelTextField);
         _rewardLabelTextField.text = _rewardLabel;
         _rewardViews = new Vector.<MobileIconLabelView>();
      }
      
      public function drawLayout() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(_type == 1)
         {
            MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_rewardLabelTextField,_background,-13);
         }
         else
         {
            MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_rewardLabelTextField,_background,-10);
         }
         if(_rewardViews.length > 0)
         {
            _loc1_ = _rewardViews[0].width;
            _loc2_ = 1;
            while(_loc2_ < _rewardViews.length)
            {
               _loc1_ += _rewardViews[_loc2_].width + 5;
               _loc2_++;
            }
            MobileAlignmentUtil.alignAccordingToPositionOf(_rewardViews[0],_background,(_background.width - _loc1_) / 2 << 0,(_viewHeight - 70 >> 1) + 10);
            _loc2_ = 1;
            while(_loc2_ < _rewardViews.length)
            {
               MobileAlignmentUtil.alignRightOf(_rewardViews[_loc2_],_rewardViews[_loc2_ - 1],5);
               _loc2_++;
            }
         }
      }
      
      public function updateWithRewards(param1:Vector.<RewardDTO>) : void
      {
         var _loc5_:int = 0;
         var _loc3_:RewardDTO = null;
         var _loc2_:MobileIconLabelView = null;
         for each(var _loc4_ in _rewardViews)
         {
            if(contains(_loc4_))
            {
               removeChild(_loc4_);
            }
         }
         _rewardViews.length = 0;
         _loc5_ = 0;
         while(_loc5_ < param1.length)
         {
            _loc3_ = param1[_loc5_];
            _loc2_ = new MobileIconLabelView(_loc3_.visualId,_loc3_.amount > 0 ? NumberUtil.format(_loc3_.amount) : _loc3_.textualAmount,null,null,null,null,true,(_loc3_ as QuestRewardDTO).rewardType == QuestRewardType.QRT_UNIT ? 0.7 : 1);
            addChild(_loc2_);
            _rewardViews.push(_loc2_);
            _loc5_++;
         }
         drawLayout();
      }
   }
}

