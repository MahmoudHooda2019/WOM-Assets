package wom.view.screen.windows.alliance.mobile
{
   import feathers.controls.renderers.IListItemRenderer;
   import peak.component.mobile.MPButton;
   import peak.component.mobile.MPItemRenderer;
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.game.alliance.AllianceDetailInfo;
   import wom.model.game.alliance.AllianceSummaryInfo;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   import wom.view.screen.windows.alliance.coa.mobile.MobileCoatOfArmsView;
   import wom.view.screen.windows.rank.MobileRankView;
   
   public class MobileBrowseAllianceViewRenderer extends MPItemRenderer implements IListItemRenderer
   {
      
      private static const HEIGHT:int = 96;
      
      private static const WIDTH:int = 948;
      
      public var assetRepository:MobileWomAssetRepository;
      
      private var _alliance:AllianceDetailInfo;
      
      private var _myAllianceExists:Boolean;
      
      private var _isRankingView:Boolean;
      
      private var _myAllianceSummary:AllianceSummaryInfo;
      
      private var background:DisplayObject;
      
      private var backgroundAssetId:String;
      
      private var rankView:MobileRankView;
      
      private var coatOfArmsView:MobileCoatOfArmsView;
      
      private var textFieldName:MPTextField;
      
      private var textFieldRankingMembers:MPTextField;
      
      private var textFieldMembers:MPTextField;
      
      private var bpIcon:DisplayObject;
      
      private var textFieldScore:MPTextField;
      
      private var textFieldMinScore:MPTextField;
      
      private var textFieldMinLevel:MPTextField;
      
      private var _infoButton:MPButton;
      
      private var _joinButton:MPButton;
      
      public function MobileBrowseAllianceViewRenderer(param1:MobileWomAssetRepository, param2:AllianceSummaryInfo, param3:Boolean = false)
      {
         super();
         this.assetRepository = param1;
         _isRankingView = param3;
         _myAllianceSummary = param2;
         drawBackground();
         rankView = new MobileRankView(param1);
         addChild(rankView);
         coatOfArmsView = new MobileCoatOfArmsView(param1);
         addChild(coatOfArmsView);
         textFieldName = new MobileCaptionTextField();
         textFieldName.textRendererProperties.textFormat = getCaptionTextFormat(27);
         textFieldName.width = (_isRankingView ? 312 : 312) - 71;
         addChild(textFieldName);
         textFieldRankingMembers = new MobileCaptionTextField();
         textFieldRankingMembers.textRendererProperties.textFormat = getCaptionTextFormat(27,"center");
         textFieldRankingMembers.visible = _isRankingView;
         textFieldRankingMembers.width = _isRankingView ? 145 : 94;
         addChild(textFieldRankingMembers);
         textFieldMembers = new MobileWomTextField();
         textFieldMembers.textRendererProperties.textFormat = getWomTextFormat(25,"center");
         textFieldMembers.width = _isRankingView ? 145 : 94;
         var _loc4_:String;
         textFieldMembers.text = _isRankingView ? (_loc4_ = "m.ui.windows.alliance.browse.list.members",peak.i18n.PText.INSTANCE.getText0(_loc4_)) : "";
         addChild(textFieldMembers);
         bpIcon = param1.getDisplayObject("IconBPM");
         addChild(bpIcon);
         textFieldScore = new MobileCaptionTextField();
         textFieldScore.textRendererProperties.textFormat = getCaptionTextFormat(30);
         addChild(textFieldScore);
         if(!_isRankingView)
         {
            textFieldMinScore = new MobileCaptionTextField();
            textFieldMinScore.textRendererProperties.textFormat = getCaptionTextFormat(27,"center");
            textFieldMinScore.width = 86;
            addChild(textFieldMinScore);
            textFieldMinLevel = new MobileWomTextField();
            textFieldMinLevel.textRendererProperties.textFormat = getWomTextFormat(25,"center");
            textFieldMinLevel.width = 95;
            addChild(textFieldMinLevel);
            _infoButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Medium");
            _infoButton.width = 115;
            var _temp_13:* = _infoButton;
            var _loc5_:String = "ui.windows.alliance.browse.action.info";
            _temp_13.label = peak.i18n.PText.INSTANCE.getText0(_loc5_);
            addChild(_infoButton);
         }
         _joinButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Medium");
         _joinButton.width = 115;
         var _temp_15:* = _joinButton;
         var _loc6_:String = "ui.windows.alliance.browse.action.join";
         _temp_15.label = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         addChild(_joinButton);
      }
      
      private function drawBackground() : void
      {
         var _loc1_:String = _alliance == null ? "MobileBeigeBackground" : (_alliance.rank == 1 ? "MobileYellowBackground" : (_alliance.rank == 2 ? "MobileGrayBackground" : (_alliance.rank == 3 ? "MobileBrownBackground" : (_myAllianceSummary && _alliance.id == _myAllianceSummary.id ? "MobileGreenBackground" : "MobileBeigeBackground"))));
         var _loc2_:Boolean = false;
         if(background != null)
         {
            if(backgroundAssetId != _loc1_ && contains(background))
            {
               removeChild(background);
               _loc2_ = true;
            }
         }
         else
         {
            _loc2_ = true;
         }
         if(_loc2_)
         {
            background = assetRepository.getDisplayObject(_loc1_);
            background.width = 948;
            background.height = 96;
            addChildAt(background,0);
            backgroundAssetId = _loc1_;
         }
      }
      
      override public function set data(param1:Object) : void
      {
         if(param1)
         {
            _alliance = param1.alliance as AllianceDetailInfo;
            _myAllianceExists = param1.myAllianceExists;
            drawBackground();
            rankView.updateWithRankInfo(_alliance.rank);
            coatOfArmsView.updateWithCoatOfArmsInfo(_alliance.coatOfArmsInfo);
            textFieldName.text = _alliance.name;
            _joinButton.isEnabled = !_myAllianceExists && !_alliance.requestSent;
            var _loc2_:String;
            textFieldScore.text = _alliance.score < 0 ? (_loc2_ = "ui.windows.alliance.myalliance.invalidlevelscore",peak.i18n.PText.INSTANCE.getText0(_loc2_)) : String(_alliance.score);
            bpIcon.visible = _alliance.score >= 0;
            if(!_isRankingView)
            {
               textFieldMembers.text = String(_alliance.members);
               var _loc3_:String;
               textFieldMinScore.text = _alliance.minScore != -1 ? String(_alliance.minScore) : (_loc3_ = "ui.windows.alliance.myalliance.invalidlevelscore",peak.i18n.PText.INSTANCE.getText0(_loc3_));
               var _loc4_:String;
               textFieldMinLevel.text = _alliance.minLevel != -1 ? String(_alliance.minLevel) : (_loc4_ = "ui.windows.alliance.myalliance.invalidlevelscore",peak.i18n.PText.INSTANCE.getText0(_loc4_));
            }
            else
            {
               textFieldRankingMembers.text = _alliance.members.toString();
            }
            drawLayout();
         }
         super.data = param1;
      }
      
      override public function isInvalid(param1:String = null) : Boolean
      {
         if(_alliance && _joinButton.isEnabled != (!_myAllianceExists && !_alliance.requestSent))
         {
            _joinButton.isEnabled = !_myAllianceExists && !_alliance.requestSent;
            return true;
         }
         return super.isInvalid(param1);
      }
      
      public function drawLayout() : void
      {
         textFieldName.validate();
         textFieldMembers.validate();
         var _loc3_:int = 5;
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(rankView,background,3);
         _loc3_ += _isRankingView ? 118 : 109;
         if(coatOfArmsView.height != 71)
         {
            coatOfArmsView.scaleX = coatOfArmsView.scaleY = 71 / coatOfArmsView.height;
         }
         coatOfArmsView.x = _loc3_;
         coatOfArmsView.y = 96 - coatOfArmsView.height >> 1;
         textFieldName.x = _loc3_ + coatOfArmsView.width;
         textFieldName.y = 96 - textFieldName.height >> 1;
         _loc3_ += (_isRankingView ? 312 : 215) - 5;
         if(_isRankingView)
         {
            textFieldRankingMembers.validate();
            textFieldRankingMembers.x = _loc3_;
            textFieldRankingMembers.y = 96 - textFieldMembers.height - textFieldRankingMembers.height >> 1;
            MobileAlignmentUtil.alignBelowOf(textFieldMembers,textFieldRankingMembers,-3);
            _loc3_ += textFieldMembers.width;
         }
         else
         {
            textFieldMembers.x = _loc3_;
            textFieldMembers.y = 96 - textFieldMembers.height >> 1;
            _loc3_ += textFieldMembers.width;
         }
         textFieldScore.validate();
         var _loc1_:int = _isRankingView ? 165 : 85;
         var _loc2_:int = bpIcon.visible ? textFieldScore.width + 35 : textFieldScore.width;
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(bpIcon,background,_loc3_ + (_loc1_ - _loc2_ >> 1));
         bpIcon.y -= 3;
         textFieldScore.x = bpIcon.visible ? bpIcon.x + 35 : bpIcon.x;
         textFieldScore.y = 96 - textFieldScore.height >> 1;
         _loc3_ += _loc1_;
         _joinButton.validate();
         if(!_isRankingView)
         {
            textFieldMinScore.validate();
            textFieldMinLevel.validate();
            _infoButton.validate();
            textFieldMinScore.x = (86 - textFieldMinScore.width >> 1) + _loc3_;
            textFieldMinScore.y = 96 - textFieldMinScore.height >> 1;
            _loc3_ += textFieldMinScore.width;
            textFieldMinLevel.x = (95 - textFieldMinLevel.width >> 1) + _loc3_;
            textFieldMinLevel.y = 96 - textFieldMinLevel.height >> 1;
            MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_infoButton,background,695);
            MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_joinButton,background,816);
         }
         else
         {
            MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_joinButton,background,background.width - _joinButton.width - 15);
         }
      }
      
      public function get alliance() : AllianceDetailInfo
      {
         return _alliance;
      }
      
      public function get infoButton() : MPButton
      {
         return _infoButton;
      }
      
      public function get joinButton() : MPButton
      {
         return _joinButton;
      }
   }
}

