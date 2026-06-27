package wom.view.screen.windows.league
{
   import flash.text.TextField;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.game.league.LeagueBonusAndRewardDTO;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.util.BaseWindowPanel;
   
   public class LeagueBonusAndRewardPanel extends BaseWindowPanel
   {
      
      private static const WIDTH:int = 156;
      
      private static const HEIGHT:int = 42;
      
      private static const MARGIN_X:int = 10;
      
      private static const MARGIN_Y:int = 5;
      
      private var _bonuses:Vector.<LeagueBonusAndRewardDTO>;
      
      private var _displayBonusTitle:Boolean;
      
      private var _rewards:Vector.<LeagueBonusAndRewardDTO>;
      
      private var _displayRewardTitle:Boolean;
      
      private var _bonusTitleTextField:TextField;
      
      private var _bonusViews:Vector.<LeagueBonusAndRewardView>;
      
      private var _bonusViewSeparators:Vector.<TextField>;
      
      private var _rewardTitleTextField:TextField;
      
      private var _rewardViews:Vector.<LeagueBonusAndRewardView>;
      
      private var _rewardViewSeparators:Vector.<TextField>;
      
      public function LeagueBonusAndRewardPanel(param1:Vector.<LeagueBonusAndRewardDTO> = null, param2:Boolean = true, param3:Vector.<LeagueBonusAndRewardDTO> = null, param4:Boolean = true)
      {
         super(156,42);
         _bonuses = param1 != null ? param1 : new Vector.<LeagueBonusAndRewardDTO>();
         _displayBonusTitle = param2;
         _rewards = param3 != null ? param3 : new Vector.<LeagueBonusAndRewardDTO>();
         _displayRewardTitle = param4;
      }
      
      override public function initLayout() : void
      {
         var _loc2_:LeagueBonusAndRewardView = null;
         var _loc3_:TextField = null;
         var _loc6_:int = 0;
         var _loc5_:TextField = null;
         super.initLayout();
         if(_displayBonusTitle)
         {
            _bonusTitleTextField = new WomTextField();
            _bonusTitleTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_18;
            _bonusTitleTextField.autoSize = "left";
            var _temp_2:* = _bonusTitleTextField;
            var _loc11_:String = "ui.windows.league.bonus.title";
            _temp_2.text = peak.i18n.PText.INSTANCE.getText0(_loc11_);
            addChild(_bonusTitleTextField);
         }
         _bonusViews = new Vector.<LeagueBonusAndRewardView>();
         for each(var _loc4_ in _bonuses)
         {
            _loc2_ = new LeagueBonusAndRewardView(_loc4_);
            _bonusViews.push(_loc2_);
            addChild(_loc2_);
         }
         _bonusViewSeparators = new Vector.<TextField>();
         _loc6_ = 0;
         while(_loc6_ < _bonuses.length - 1)
         {
            _loc3_ = new CaptionTextField(WomTextFormats.RED_BUTTON_FILTER);
            _loc3_.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
            _loc3_.autoSize = "left";
            _loc3_.text = ",";
            addChild(_loc3_);
            _bonusViewSeparators.push(_loc3_);
            _loc6_++;
         }
         if(_displayRewardTitle)
         {
            _rewardTitleTextField = new WomTextField();
            _rewardTitleTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_18;
            _rewardTitleTextField.autoSize = "left";
            var _temp_6:* = _rewardTitleTextField;
            var _loc12_:String = "ui.windows.league.reward.title";
            _temp_6.text = peak.i18n.PText.INSTANCE.getText0(_loc12_);
            addChild(_rewardTitleTextField);
         }
         _rewardViews = new Vector.<LeagueBonusAndRewardView>();
         for each(var _loc1_ in _rewards)
         {
            _loc2_ = new LeagueBonusAndRewardView(_loc1_);
            _rewardViews.push(_loc2_);
            addChild(_loc2_);
         }
         _rewardViewSeparators = new Vector.<TextField>();
         _loc6_ = 0;
         while(_loc6_ < _rewards.length - 1)
         {
            _loc5_ = new CaptionTextField(WomTextFormats.RED_BUTTON_FILTER);
            _loc5_.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
            _loc5_.autoSize = "left";
            _loc5_.text = ",";
            addChild(_loc5_);
            _rewardViewSeparators.push(_loc5_);
            _loc6_++;
         }
         drawLayout();
      }
      
      override public function drawLayout() : void
      {
         var _loc8_:int = 0;
         var _loc7_:LeagueBonusAndRewardView = null;
         var _loc1_:LeagueBonusAndRewardView = null;
         var _loc5_:Boolean = false;
         var _loc3_:int = 10;
         if(_displayBonusTitle)
         {
            AlignmentUtil.alignAccordingToPositionOf(_bonusTitleTextField,bg,_loc3_,5 + 5);
            _loc3_ += _bonusTitleTextField.width + 4;
            _loc5_ = true;
         }
         if(_bonusViews.length > 0)
         {
            _loc8_ = 0;
            while(_loc8_ < _bonusViews.length)
            {
               _loc7_ = _bonusViews[_loc8_];
               if(_loc8_ > 0)
               {
                  AlignmentUtil.alignAccordingToPositionOf(_bonusViewSeparators[_loc8_ - 1],bg,_loc3_,5 + 7);
                  _loc3_ += _bonusViewSeparators[_loc8_ - 1].width + 5;
               }
               AlignmentUtil.alignAccordingToPositionOf(_loc7_,bg,_loc3_,5);
               _loc3_ += _loc7_.width;
               _loc8_++;
            }
            _loc5_ = true;
         }
         _loc3_ += 10;
         var _loc6_:Boolean = false;
         var _loc4_:int = 10;
         var _loc2_:int = int(_loc3_ == 10 * 2 ? 5 : 28);
         if(_displayRewardTitle)
         {
            AlignmentUtil.alignAccordingToPositionOf(_rewardTitleTextField,bg,_loc4_,_loc2_ + 5);
            _loc4_ += _rewardTitleTextField.width + 4;
            _loc6_ = true;
         }
         if(_rewardViews.length > 0)
         {
            _loc8_ = 0;
            while(_loc8_ < _rewardViews.length)
            {
               _loc1_ = _rewardViews[_loc8_];
               if(_loc8_ > 0)
               {
                  AlignmentUtil.alignAccordingToPositionOf(_rewardViewSeparators[_loc8_ - 1],bg,_loc4_,_loc2_ + 7);
                  _loc4_ += _rewardViewSeparators[_loc8_ - 1].width + 5;
               }
               AlignmentUtil.alignAccordingToPositionOf(_loc1_,bg,_loc4_,_loc2_);
               _loc4_ += _loc1_.width;
               _loc8_++;
            }
            _loc6_ = true;
         }
         _loc4_ += 10;
         super.updateBackground(_loc3_ > _loc4_ ? _loc3_ : _loc4_,_loc5_ && _loc6_ ? 60 : 37);
         super.drawLayout();
      }
      
      override protected function get backgroundAssetId() : String
      {
         return "BackgroundLight";
      }
   }
}

