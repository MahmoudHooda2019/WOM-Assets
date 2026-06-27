package wom.view.screen.windows.alliance.mobile
{
   import feathers.controls.renderers.IListItemRenderer;
   import peak.component.mobile.MPItemRenderer;
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.game.alliance.AllianceDetailInfo;
   import wom.model.game.alliance.AllianceSummaryInfo;
   import wom.model.game.alliance.AllianceTournamentReward;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   import wom.view.screen.windows.alliance.coa.mobile.MobileCoatOfArmsView;
   import wom.view.screen.windows.rank.MobileRankView;
   
   public class MobileAllianceTournamentViewRenderer extends MPItemRenderer implements IListItemRenderer
   {
      
      private static const HEIGHT:int = 96;
      
      private static const WIDTH:int = 948;
      
      public var assetRepository:MobileWomAssetRepository;
      
      private var _alliance:AllianceDetailInfo;
      
      private var _myAllianceExists:Boolean;
      
      private var _myAllianceSummary:AllianceSummaryInfo;
      
      private var background:DisplayObject;
      
      private var backgroundAssetId:String;
      
      private var rankView:MobileRankView;
      
      private var coatOfArmsView:MobileCoatOfArmsView;
      
      private var textFieldName:MPTextField;
      
      private var textFieldMembers:MPTextField;
      
      private var rewardIcon:DisplayObject;
      
      private var textFieldReward:MPTextField;
      
      private var textFieldScore:MPTextField;
      
      public function MobileAllianceTournamentViewRenderer(param1:MobileWomAssetRepository, param2:AllianceSummaryInfo)
      {
         super();
         this.assetRepository = param1;
         _myAllianceSummary = param2;
         drawBackground();
         rankView = new MobileRankView(param1);
         addChild(rankView);
         coatOfArmsView = new MobileCoatOfArmsView(param1);
         addChild(coatOfArmsView);
         textFieldName = new MobileCaptionTextField();
         textFieldName.textRendererProperties.textFormat = getCaptionTextFormat(27);
         textFieldName.width = 250;
         addChild(textFieldName);
         textFieldMembers = new MobileWomTextField();
         textFieldMembers.textRendererProperties.textFormat = getWomTextFormat(25,"center");
         textFieldMembers.width = 140;
         var _temp_6:* = textFieldMembers;
         var _loc3_:String = "m.ui.windows.alliance.browse.list.members";
         _temp_6.text = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         addChild(textFieldMembers);
         rewardIcon = param1.getDisplayObject("IconGoldM");
         addChild(rewardIcon);
         textFieldReward = new MobileCaptionTextField();
         textFieldReward.textRendererProperties.textFormat = getCaptionTextFormat(30);
         addChild(textFieldReward);
         textFieldScore = new MobileCaptionTextField();
         textFieldScore.textRendererProperties.textFormat = getCaptionTextFormat(30,"center");
         textFieldScore.width = 263;
         addChild(textFieldScore);
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
            textFieldReward.text = String(AllianceTournamentReward.getAllianceTournamentReward(_alliance.rank));
            var _loc2_:String;
            textFieldScore.text = _alliance.score < 0 ? (_loc2_ = "ui.windows.alliance.myalliance.invalidlevelscore",peak.i18n.PText.INSTANCE.getText0(_loc2_)) : String(_alliance.score);
            textFieldMembers.text = String(_alliance.members);
            drawLayout();
         }
         super.data = param1;
      }
      
      public function drawLayout() : void
      {
         textFieldName.validate();
         textFieldMembers.validate();
         var _loc1_:int = 5;
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(rankView,background,15);
         _loc1_ += 140;
         if(coatOfArmsView.height != 71)
         {
            coatOfArmsView.scaleX = coatOfArmsView.scaleY = 71 / coatOfArmsView.height;
         }
         coatOfArmsView.x = _loc1_ + 10;
         coatOfArmsView.y = 96 - coatOfArmsView.height >> 1;
         textFieldName.x = coatOfArmsView.x + coatOfArmsView.width + 5;
         textFieldName.y = 96 - textFieldName.height >> 1;
         _loc1_ += 250 - 5;
         textFieldMembers.x = _loc1_;
         textFieldMembers.y = 96 - textFieldMembers.height >> 1;
         _loc1_ += textFieldMembers.width;
         rewardIcon.x = _loc1_ + 15;
         rewardIcon.y = 96 - rewardIcon.height >> 1;
         textFieldReward.validate();
         textFieldReward.x = rewardIcon.x + 35;
         textFieldReward.y = 96 - textFieldReward.height >> 1;
         _loc1_ += 151;
         textFieldScore.x = _loc1_;
         textFieldScore.y = 96 - textFieldScore.height >> 1;
      }
      
      public function get alliance() : AllianceDetailInfo
      {
         return _alliance;
      }
   }
}

