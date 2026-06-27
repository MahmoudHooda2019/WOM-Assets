package wom.view.screen.windows.alliance
{
   import fl.controls.Button;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import peak.display.View;
   import peak.i18n.PText;
   import wom.model.game.alliance.AllianceDetailInfo;
   import wom.model.game.alliance.AllianceSummaryInfo;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.AutoSizingCaptionTextField;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.colored.WomBlueSmallButton;
   import wom.view.component.button.colored.WomBrownSmallButton;
   import wom.view.screen.windows.alliance.coa.CoatOfArmsView;
   import wom.view.screen.windows.rank.RankView;
   import wom.view.util.LineUtil;
   
   public class BrowseAllianceView extends Sprite implements View
   {
      
      private static const HEIGHT:int = 71;
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      private var _alliance:AllianceDetailInfo;
      
      private var _myAlliance:Boolean;
      
      private var _viewOrderInPage:int;
      
      private var _isRankingView:Boolean;
      
      private var _rankView:RankView;
      
      private var _coatOfArmsView:CoatOfArmsView;
      
      private var _textFieldName:TextField;
      
      private var _textFieldMembers:TextField;
      
      private var _textFieldScore:TextField;
      
      private var _textFieldMinScore:TextField;
      
      private var _textFieldMinLevel:TextField;
      
      private var _infoButton:Button;
      
      private var _joinButton:Button;
      
      public function BrowseAllianceView(param1:AllianceDetailInfo, param2:AllianceSummaryInfo, param3:int, param4:Boolean = false)
      {
         super();
         _alliance = param1;
         _myAlliance = param2 != null ? param1.id == param2.id : false;
         _viewOrderInPage = param3;
         _isRankingView = param4;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         var _loc3_:int = 0;
         var _loc1_:int = _isRankingView ? 603 : 665;
         if(_myAlliance || _alliance.rank <= 3)
         {
            _loc3_ = _myAlliance ? 14803787 : (_alliance.rank == 1 ? 16762399 : (_alliance.rank == 2 ? 12566463 : 13277541));
            graphics.beginFill(_loc3_,1);
            if(_viewOrderInPage % 5 == 0)
            {
               graphics.drawRoundRectComplex(2,1,_loc1_ - 4,_isRankingView ? 71 - 1 : 71 + 7,0,0,8,8);
            }
            else
            {
               graphics.drawRect(2,1,_loc1_ - 4,71 - 2);
            }
            graphics.endFill();
         }
         LineUtil.drawHorizontalSeparatorLine(this,2,_loc1_ - 2);
         _rankView = new RankView(_alliance.rank);
         addChild(_rankView);
         _coatOfArmsView = new CoatOfArmsView(assetRepository);
         addChild(_coatOfArmsView);
         _coatOfArmsView.updateWithCoatOfArmsInfo(_alliance.coatOfArmsInfo);
         var _loc2_:TextFormat = WomTextFormats.FONT_SIZE_22;
         _textFieldName = new AutoSizingCaptionTextField(WomTextFormats.GREEN_BUTTON_FILTER);
         _textFieldName.defaultTextFormat = _loc2_;
         _textFieldName.width = _isRankingView ? 150 : 120;
         _textFieldName.text = _alliance.name;
         addChild(_textFieldName);
         _textFieldMembers = new WomTextField();
         _textFieldMembers.defaultTextFormat = _loc2_;
         _textFieldMembers.autoSize = "left";
         _textFieldMembers.width = _isRankingView ? 140 : 73;
         addChild(_textFieldMembers);
         _textFieldMembers.text = String(_alliance.members);
         _textFieldScore = new WomTextField();
         _textFieldScore.defaultTextFormat = WomTextFormats.CENTER_22;
         _textFieldScore.height = 25;
         _textFieldScore.width = _isRankingView ? 120 : 55;
         addChild(_textFieldScore);
         var _loc4_:String;
         _textFieldScore.text = _alliance.score < 0 ? (_loc4_ = "ui.windows.alliance.myalliance.invalidlevelscore",peak.i18n.PText.INSTANCE.getText0(_loc4_)) : String(_alliance.score);
         if(!_isRankingView)
         {
            _textFieldMinScore = new WomTextField();
            _textFieldMinScore.defaultTextFormat = _loc2_;
            _textFieldMinScore.autoSize = "left";
            _textFieldMinScore.width = 76;
            addChild(_textFieldMinScore);
            var _loc5_:String;
            _textFieldMinScore.text = _alliance.minScore != -1 ? String(_alliance.minScore) : (_loc5_ = "ui.windows.alliance.myalliance.invalidlevelscore",peak.i18n.PText.INSTANCE.getText0(_loc5_));
            _textFieldMinLevel = new WomTextField();
            _textFieldMinLevel.defaultTextFormat = _loc2_;
            _textFieldMinLevel.autoSize = "left";
            _textFieldMinLevel.width = 74;
            addChild(_textFieldMinLevel);
            var _loc6_:String;
            _textFieldMinLevel.text = _alliance.minLevel != -1 ? String(_alliance.minLevel) : (_loc6_ = "ui.windows.alliance.myalliance.invalidlevelscore",peak.i18n.PText.INSTANCE.getText0(_loc6_));
            _infoButton = new WomBrownSmallButton();
            _infoButton.width = 98;
            var _temp_10:* = _infoButton;
            var _loc7_:String = "ui.windows.alliance.browse.action.info";
            _temp_10.label = peak.i18n.PText.INSTANCE.getText0(_loc7_);
            addChild(_infoButton);
            _joinButton = new WomBlueSmallButton();
            _joinButton.width = 98;
            var _temp_12:* = _joinButton;
            var _loc8_:String = "ui.windows.alliance.browse.action.join";
            _temp_12.label = peak.i18n.PText.INSTANCE.getText0(_loc8_);
            addChild(_joinButton);
         }
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         var _loc1_:int = 5;
         _rankView.x = _alliance.rank > 50 ? 12 : (72 - _rankView.width >> 1) + _loc1_;
         _rankView.y = 71 - _rankView.height >> 1;
         _loc1_ += _isRankingView ? 116 : 72 + 1;
         _coatOfArmsView.x = _loc1_;
         _coatOfArmsView.y = 71 - _coatOfArmsView.height >> 1;
         _textFieldName.x = _loc1_ + _coatOfArmsView.width;
         _textFieldName.y = 71 - _textFieldName.height >> 1;
         _loc1_ += _isRankingView ? 230 : 185 + 1;
         _textFieldMembers.x = (73 - _textFieldMembers.width >> 1) + _loc1_;
         _textFieldMembers.y = 71 - _textFieldMembers.height >> 1;
         _loc1_ += _isRankingView ? 140 : 73 + 1;
         if(_isRankingView)
         {
            _textFieldScore.x = 460;
            _textFieldScore.y = 71 - _textFieldScore.height >> 1;
            _loc1_ += _isRankingView ? 120 : 55 + 1;
         }
         else
         {
            _textFieldScore.x = (55 - _textFieldScore.width >> 1) + _loc1_;
            _textFieldScore.y = 71 - _textFieldScore.height >> 1;
            _loc1_ += _isRankingView ? 120 : 55 + 1;
         }
         if(!_isRankingView)
         {
            _textFieldMinScore.x = (76 - _textFieldMinScore.width >> 1) + _loc1_;
            _textFieldMinScore.y = 71 - _textFieldMinScore.height >> 1;
            _loc1_ += 76 + 1;
            _textFieldMinLevel.x = (74 - _textFieldMinLevel.width >> 1) + _loc1_;
            _textFieldMinLevel.y = 71 - _textFieldMinLevel.height >> 1;
            _infoButton.x = 552;
            _infoButton.y = 5;
            _joinButton.x = 552;
            _joinButton.y = 36;
         }
      }
      
      public function get alliance() : AllianceDetailInfo
      {
         return _alliance;
      }
      
      public function get infoButton() : Button
      {
         return _infoButton;
      }
      
      public function get joinButton() : Button
      {
         return _joinButton;
      }
      
      public function get isRankingView() : Boolean
      {
         return _isRankingView;
      }
   }
}

