package wom.view.screen.windows.alliance
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import peak.display.View;
   import peak.resource.asset.display.AssetDisplayObject;
   import wom.model.game.alliance.AllianceDetailInfo;
   import wom.model.game.alliance.AllianceSummaryInfo;
   import wom.model.game.alliance.AllianceTournamentReward;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.AutoSizingCaptionTextField;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.screen.windows.alliance.coa.CoatOfArmsView;
   import wom.view.screen.windows.rank.RankView;
   import wom.view.util.LineUtil;
   
   public class AllianceTournamentView extends Sprite implements View
   {
      
      private static const HEIGHT:int = 71;
      
      private static const WIDTH:int = 665;
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      private var _alliance:AllianceDetailInfo;
      
      private var _myAlliance:Boolean;
      
      private var _viewOrderInPage:int;
      
      private var _rankView:RankView;
      
      private var _coatOfArmsView:CoatOfArmsView;
      
      private var _textFieldName:TextField;
      
      private var _textFieldMembers:TextField;
      
      private var _textFieldScore:TextField;
      
      private var _textFieldReward:TextField;
      
      private var _goldIcon:DisplayObject;
      
      private var _rewardAsset:AssetDisplayObject;
      
      public function AllianceTournamentView(param1:AllianceDetailInfo, param2:AllianceSummaryInfo, param3:int)
      {
         super();
         _alliance = param1;
         _myAlliance = param2 != null ? param1.id == param2.id : false;
         _viewOrderInPage = param3;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         var _loc2_:int = 0;
         if(_myAlliance || _alliance.rank <= 3)
         {
            _loc2_ = _myAlliance ? 14803787 : (_alliance.rank == 1 ? 16762399 : (_alliance.rank == 2 ? 12566463 : 13277541));
            graphics.beginFill(_loc2_,1);
            if(_viewOrderInPage % 5 == 0)
            {
               graphics.drawRoundRectComplex(2,1,665 - 4,71 + 7,0,0,8,8);
            }
            else
            {
               graphics.drawRect(2,1,665 - 4,71 - 2);
            }
            graphics.endFill();
            _rewardAsset = assetRepository.getDisplayObject("TournamentReward" + _alliance.rank);
            _rewardAsset.scaleX = _rewardAsset.scaleY = 0.4;
            addChild(_rewardAsset);
         }
         LineUtil.drawHorizontalSeparatorLine(this,2,665 - 2);
         _rankView = new RankView(_alliance.rank);
         addChild(_rankView);
         _coatOfArmsView = new CoatOfArmsView(assetRepository);
         addChild(_coatOfArmsView);
         _coatOfArmsView.updateWithCoatOfArmsInfo(_alliance.coatOfArmsInfo);
         var _loc1_:TextFormat = WomTextFormats.FONT_SIZE_22;
         _textFieldName = new AutoSizingCaptionTextField(WomTextFormats.GREEN_BUTTON_FILTER);
         _textFieldName.defaultTextFormat = _loc1_;
         _textFieldName.width = 120;
         _textFieldName.text = _alliance.name;
         addChild(_textFieldName);
         _textFieldMembers = new WomTextField();
         _textFieldMembers.defaultTextFormat = _loc1_;
         _textFieldMembers.autoSize = "left";
         _textFieldMembers.width = 100;
         addChild(_textFieldMembers);
         _textFieldMembers.text = String(_alliance.members);
         _goldIcon = assetRepository.getDisplayObject("Gold");
         addChild(_goldIcon);
         _textFieldReward = new WomTextField();
         _textFieldReward.defaultTextFormat = _loc1_;
         _textFieldReward.autoSize = "left";
         _textFieldReward.width = 130;
         addChild(_textFieldReward);
         _textFieldReward.text = String(AllianceTournamentReward.getAllianceTournamentReward(_alliance.rank));
         _textFieldScore = new WomTextField();
         _textFieldScore.defaultTextFormat = WomTextFormats.CENTER_22;
         _textFieldScore.height = 25;
         _textFieldScore.width = 130;
         addChild(_textFieldScore);
         _textFieldScore.text = String(_alliance.score);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         var _loc1_:int = 5;
         _rankView.x = _alliance.rank > 50 ? 12 : (72 - _rankView.width >> 1) + _loc1_;
         _rankView.y = 71 - _rankView.height >> 1;
         _loc1_ += 88 + 1;
         _coatOfArmsView.x = _loc1_;
         _coatOfArmsView.y = 71 - _coatOfArmsView.height >> 1;
         _textFieldName.x = _loc1_ + _coatOfArmsView.width;
         _textFieldName.y = 71 - _textFieldName.height >> 1;
         _loc1_ += 190 + 1;
         _textFieldMembers.x = (100 - _textFieldMembers.width >> 1) + _loc1_;
         _textFieldMembers.y = 71 - _textFieldMembers.height >> 1;
         _loc1_ += 100 + 1;
         if(_rewardAsset != null)
         {
            _rewardAsset.x = _loc1_ + 2;
            _rewardAsset.y = 4;
         }
         _goldIcon.x = _loc1_ + 60;
         _goldIcon.y = 71 - _goldIcon.height >> 1;
         _textFieldReward.x = _goldIcon.x + _goldIcon.width + 3;
         _textFieldReward.y = 71 - _textFieldReward.height >> 1;
         _loc1_ += 130 + 1;
         _textFieldScore.x = (130 - _textFieldScore.width >> 1) + _loc1_;
         _textFieldScore.y = 71 - _textFieldScore.height >> 1;
      }
      
      public function get alliance() : AllianceDetailInfo
      {
         return _alliance;
      }
   }
}

