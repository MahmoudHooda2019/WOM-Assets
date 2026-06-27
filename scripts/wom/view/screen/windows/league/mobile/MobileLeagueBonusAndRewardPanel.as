package wom.view.screen.windows.league.mobile
{
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.game.league.LeagueBonusAndRewardDTO;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileWomTextField;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   
   public class MobileLeagueBonusAndRewardPanel extends Sprite
   {
      
      private static const MARGIN_X:int = 20;
      
      private static const MARGIN_Y:int = 22;
      
      private var assetRepository:MobileWomAssetRepository;
      
      private var background:DisplayObject;
      
      private var _bonuses:Vector.<LeagueBonusAndRewardDTO>;
      
      private var _displayBonusTitle:Boolean;
      
      private var _rewards:Vector.<LeagueBonusAndRewardDTO>;
      
      private var _displayRewardTitle:Boolean;
      
      private var _bonusTitleTextField:MPTextField;
      
      private var _bonusViews:Vector.<MobileLeagueBonusAndRewardView>;
      
      private var _bonusViewSeparators:Vector.<MPTextField>;
      
      private var _rewardTitleTextField:MPTextField;
      
      private var _rewardViews:Vector.<MobileLeagueBonusAndRewardView>;
      
      private var _rewardViewSeparators:Vector.<MPTextField>;
      
      public function MobileLeagueBonusAndRewardPanel(param1:MobileWomAssetRepository, param2:Vector.<LeagueBonusAndRewardDTO> = null, param3:Boolean = true, param4:Vector.<LeagueBonusAndRewardDTO> = null, param5:Boolean = true)
      {
         super();
         this.assetRepository = param1;
         _bonuses = param2 != null ? param2 : new Vector.<LeagueBonusAndRewardDTO>();
         _displayBonusTitle = param3;
         _rewards = param4 != null ? param4 : new Vector.<LeagueBonusAndRewardDTO>();
         _displayRewardTitle = param5;
         init();
      }
      
      private function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         var _loc2_:MobileLeagueBonusAndRewardView = null;
         var _loc3_:MPTextField = null;
         var _loc6_:int = 0;
         var _loc5_:MPTextField = null;
         background = assetRepository.getDisplayObject("MobileDarkBackground");
         background.width = 490;
         background.height = 90;
         if(_displayBonusTitle || _displayRewardTitle)
         {
            addChild(background);
         }
         if(_displayBonusTitle)
         {
            _bonusTitleTextField = new MobileWomTextField();
            _bonusTitleTextField.textRendererProperties.textFormat = getWomTextFormat(21,"left",16777215);
            var _temp_4:* = _bonusTitleTextField;
            var _loc11_:String = "ui.windows.league.bonus.title";
            _temp_4.text = peak.i18n.PText.INSTANCE.getText0(_loc11_);
            addChild(_bonusTitleTextField);
         }
         _bonusViews = new Vector.<MobileLeagueBonusAndRewardView>();
         for each(var _loc4_ in _bonuses)
         {
            _loc2_ = new MobileLeagueBonusAndRewardView(assetRepository,_loc4_);
            _bonusViews.push(_loc2_);
            addChild(_loc2_);
         }
         _bonusViewSeparators = new Vector.<MPTextField>();
         _loc6_ = 0;
         while(_loc6_ < _bonuses.length - 1)
         {
            _loc3_ = new MobileWomTextField();
            _loc3_.textRendererProperties.textFormat = getCaptionTextFormat(21);
            _loc3_.text = ",";
            addChild(_loc3_);
            _bonusViewSeparators.push(_loc3_);
            _loc6_++;
         }
         if(_displayRewardTitle)
         {
            _rewardTitleTextField = new MobileWomTextField();
            _rewardTitleTextField.textRendererProperties.textFormat = getWomTextFormat(21,"left",16777215);
            var _temp_8:* = _rewardTitleTextField;
            var _loc12_:String = "ui.windows.league.reward.title";
            _temp_8.text = peak.i18n.PText.INSTANCE.getText0(_loc12_);
            addChild(_rewardTitleTextField);
         }
         _rewardViews = new Vector.<MobileLeagueBonusAndRewardView>();
         for each(var _loc1_ in _rewards)
         {
            _loc2_ = new MobileLeagueBonusAndRewardView(assetRepository,_loc1_);
            _rewardViews.push(_loc2_);
            addChild(_loc2_);
         }
         _rewardViewSeparators = new Vector.<MPTextField>();
         _loc6_ = 0;
         while(_loc6_ < _rewards.length - 1)
         {
            _loc5_ = new MobileWomTextField();
            _loc5_.textRendererProperties.textFormat = getCaptionTextFormat(23);
            _loc5_.text = ",";
            addChild(_loc5_);
            _rewardViewSeparators.push(_loc5_);
            _loc6_++;
         }
      }
      
      public function drawLayout() : void
      {
         var _loc8_:int = 0;
         var _loc7_:MobileLeagueBonusAndRewardView = null;
         var _loc1_:MobileLeagueBonusAndRewardView = null;
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         if(_displayBonusTitle)
         {
            _bonusTitleTextField.validate();
            MobileAlignmentUtil.alignAccordingToPositionOf(_bonusTitleTextField,background,20,22);
            _loc4_ += 20 + _bonusTitleTextField.width + 4;
            _loc3_ = true;
         }
         if(_bonusViews.length > 0)
         {
            _loc8_ = 0;
            while(_loc8_ < _bonusViews.length)
            {
               _loc7_ = _bonusViews[_loc8_];
               _loc7_.drawLayout();
               if(_loc8_ > 0)
               {
                  _bonusViewSeparators[_loc8_ - 1].validate();
                  MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_bonusViewSeparators[_loc8_ - 1],_bonusViews[_loc8_ - 1],_loc4_ - _bonusViews[_loc8_ - 1].x);
                  _loc4_ += _bonusViewSeparators[_loc8_ - 1].width + 10;
               }
               if(_bonusTitleTextField)
               {
                  MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_loc7_,_bonusTitleTextField,_loc4_ - _bonusTitleTextField.x);
               }
               else
               {
                  _loc7_.x = _loc4_;
               }
               _loc4_ += _loc7_.width;
               _loc8_++;
            }
            if(_bonusTitleTextField)
            {
               _bonusTitleTextField.y -= 2;
            }
            _loc3_ = true;
         }
         _loc4_ += 20;
         var _loc6_:Boolean = false;
         var _loc5_:int = 0;
         var _loc2_:int = int(!_displayBonusTitle ? 22 : 54);
         if(_displayRewardTitle)
         {
            _rewardTitleTextField.validate();
            MobileAlignmentUtil.alignAccordingToPositionOf(_rewardTitleTextField,background,20,_loc2_);
            _loc5_ += 20 + _rewardTitleTextField.width + 4;
            _loc6_ = true;
         }
         if(_rewardViews.length > 0)
         {
            _loc8_ = 0;
            while(_loc8_ < _rewardViews.length)
            {
               _loc1_ = _rewardViews[_loc8_];
               _loc1_.drawLayout();
               if(_loc8_ > 0)
               {
                  _rewardViewSeparators[_loc8_ - 1].validate();
                  MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_rewardViewSeparators[_loc8_ - 1],_rewardViews[_loc8_ - 1],_loc5_ - _rewardViews[_loc8_ - 1].x);
                  _loc5_ += _rewardViewSeparators[_loc8_ - 1].width + 10;
               }
               if(_rewardTitleTextField)
               {
                  MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_loc1_,_rewardTitleTextField,_loc5_ - _rewardTitleTextField.x);
               }
               else
               {
                  _loc1_.x = _loc5_;
               }
               _loc5_ += _loc1_.width;
               _loc8_++;
            }
            if(_rewardTitleTextField)
            {
               _rewardTitleTextField.y -= 2;
            }
            _loc6_ = true;
         }
         _loc5_ += 20;
         background.width = _loc4_ > _loc5_ ? _loc4_ : _loc5_;
         background.height = _loc3_ && _loc6_ ? 90 : 60;
      }
   }
}

