package wom.view.screen.windows.rank
{
   import fl.controls.Button;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import peak.util.NumberUtil;
   import wom.model.game.rank.RankingRow;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.colored.WomBlueSmallButton;
   import wom.view.screen.windows.alliance.coa.CoatOfArmsView;
   import wom.view.ui.common.IconLabelView;
   import wom.view.util.LineUtil;
   
   public class BaseRankingRowView extends Sprite implements View
   {
      
      private static const HEIGHT:int = 71;
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      private var _rankingRow:RankingRow;
      
      private var _rank:int;
      
      private var _me:Boolean;
      
      private var _rankingIsBP:Boolean;
      
      private var _background:Sprite;
      
      private var _rankView:RankView;
      
      private var _playerAvatar:DisplayObject;
      
      private var levelIndicator:DisplayObject;
      
      private var levelTextField:TextField;
      
      private var _coatOfArmsView:CoatOfArmsView;
      
      private var _playerNameTextField:TextField;
      
      private var _allianceNameTextField:WomTextField;
      
      private var _enterButton:Button;
      
      private var _rankedValueView:IconLabelView;
      
      private var _rankedValueTextField:TextField;
      
      public function BaseRankingRowView(param1:RankingRow, param2:int, param3:Boolean = false, param4:Boolean = false)
      {
         super();
         _rankingRow = param1;
         _rank = param2;
         _me = param3;
         _rankingIsBP = param4;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Boolean = _me || _rank <= 3;
         if(_loc1_)
         {
            _loc2_ = _me ? 14803787 : (_rank == 1 ? 16762399 : (_rank == 2 ? 12566463 : 13277541));
            graphics.beginFill(_loc2_,1);
            if(_rank % 5 == 0)
            {
               graphics.drawRoundRectComplex(2,1,599,71 - 1,0,0,8,8);
            }
            else
            {
               graphics.drawRect(2,1,599,71 - 2);
            }
            graphics.endFill();
         }
         LineUtil.drawHorizontalSeparatorLine(this,1,601);
         _background = new Sprite();
         _background.graphics.beginFill(16777215,0);
         _background.graphics.drawRect(0,0,1,71);
         _background.graphics.endFill();
         addChild(_background);
         _playerAvatar = assetRepository.getAvatarByProfile(_rankingRow.profile);
         addChild(_playerAvatar);
         _coatOfArmsView = null;
         if(_rankingRow.alliance)
         {
            _coatOfArmsView = new CoatOfArmsView(assetRepository);
            addChild(_coatOfArmsView);
            _coatOfArmsView.updateWithCoatOfArmsInfo(_rankingRow.alliance.coaInfo);
         }
         _rankView = new RankView(_rank);
         addChild(_rankView);
         levelIndicator = assetRepository.getDisplayObject("Level");
         addChild(levelIndicator);
         levelTextField = new CaptionTextField(WomTextFormats.MIGHT_FILTER);
         levelTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_18;
         levelTextField.autoSize = "left";
         levelTextField.mouseEnabled = false;
         levelTextField.text = _rankingRow.level.toString();
         addChild(levelTextField);
         _playerNameTextField = new CaptionTextField(WomTextFormats.GREEN_BUTTON_FILTER);
         _playerNameTextField.defaultTextFormat = _rank <= 3 ? WomTextFormats.FONT_SIZE_22 : WomTextFormats.FONT_SIZE_16;
         _playerNameTextField.autoSize = "left";
         addChild(_playerNameTextField);
         _playerNameTextField.text = _rankingRow.profile.gameId;
         _allianceNameTextField = new WomTextField();
         _allianceNameTextField.autoSize = "left";
         _allianceNameTextField.width = 113;
         _allianceNameTextField.wordWrap = true;
         _allianceNameTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_18;
         _allianceNameTextField.text = _rankingRow.alliance != null ? _rankingRow.alliance.name : "";
         addChild(_allianceNameTextField);
         _enterButton = new WomBlueSmallButton();
         _enterButton.width = 80;
         _enterButton.visible = !_me;
         var _temp_12:* = _enterButton;
         var _loc3_:String = "ui.mainframe.city.friend.enter";
         _temp_12.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         addChild(_enterButton);
         _rankedValueView = new IconLabelView("CrownIcon",NumberUtil.numberFormat(_rankingRow.score,2,false,false),-1);
         _rankedValueView.align = "left";
         _rankedValueView.visible = _rankingIsBP;
         addChild(_rankedValueView);
         _rankedValueTextField = new WomTextField();
         _rankedValueTextField.defaultTextFormat = WomTextFormats.CENTER_20;
         _rankedValueTextField.width = 145;
         _rankedValueTextField.height = 30;
         _rankedValueTextField.visible = !_rankingIsBP;
         addChild(_rankedValueTextField);
         _rankedValueTextField.text = NumberUtil.numberFormat(_rankingRow.score,2,false,false);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         _rankView.x = _rank > 50 ? 12 : (55 - _rankView.width >> 1) + 27;
         AlignmentUtil.alignMiddleYAxisOf(_rankView,_background);
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_playerAvatar,_background,109);
         AlignmentUtil.alignAccordingToPositionOf(levelIndicator,_playerAvatar,-7,-6);
         AlignmentUtil.alignMiddleOf(levelTextField,levelIndicator);
         if(_coatOfArmsView)
         {
            AlignmentUtil.alignRightOf(_coatOfArmsView,_playerAvatar,13);
            AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_playerNameTextField,_background,232);
            _playerNameTextField.y -= 6;
            AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_allianceNameTextField,_background,232);
            _allianceNameTextField.y += 15;
         }
         else
         {
            AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_playerNameTextField,_background,170);
         }
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_enterButton,_background,494);
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_rankedValueView,_background,369 + (100 - _rankedValueView.width >> 1));
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_rankedValueTextField,_background,347);
      }
      
      public function get rankingRow() : RankingRow
      {
         return _rankingRow;
      }
      
      public function get playerAvatar() : DisplayObject
      {
         return _playerAvatar;
      }
      
      public function updatePlayerNameTextField(param1:String) : void
      {
         _playerNameTextField.text = param1;
      }
      
      public function get enterButton() : Button
      {
         return _enterButton;
      }
   }
}

