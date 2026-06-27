package wom.view.screen.windows.league
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.game.league.LeagueMemberInfo;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.screen.windows.alliance.coa.CoatOfArmsView;
   import wom.view.screen.windows.rank.RankView;
   import wom.view.util.LineUtil;
   
   public class LeagueMemberView extends Sprite implements View
   {
      
      private static const WIDTH:int = 603;
      
      private static const HEIGHT:int = 70;
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      private var _rankView:RankView;
      
      private var _avatar:DisplayObject;
      
      private var _starIcon:DisplayObject;
      
      private var _levelTextField:TextField;
      
      private var _coatOfArmsView:CoatOfArmsView = null;
      
      private var _nameTextField:TextField;
      
      private var _allianceNameTextField:TextField = null;
      
      private var _numberOfWinsAsAttackerTextField:TextField;
      
      private var _numberOfWinsAsDefenderTextField:TextField;
      
      private var _battlePointsIcon:DisplayObject;
      
      private var _battlePointsTextField:TextField;
      
      private var _member:LeagueMemberInfo;
      
      private var _headerWidths:Dictionary;
      
      private var _viewOrderInPage:int;
      
      private var _me:Boolean;
      
      public function LeagueMemberView(param1:LeagueMemberInfo, param2:Dictionary, param3:int, param4:Boolean)
      {
         super();
         _member = param1;
         _headerWidths = param2;
         _viewOrderInPage = param3;
         _me = param4;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         graphics.beginFill(determineBackgroundColor(),1);
         if(_viewOrderInPage % 5 == 0)
         {
            graphics.drawRoundRectComplex(2,2,603 - 4,70 - 4,0,0,8,8);
         }
         else
         {
            graphics.drawRect(2,2,603 - 4,70 - 2);
         }
         graphics.endFill();
         if(_viewOrderInPage % 5 != 1)
         {
            LineUtil.drawHorizontalSeparatorLine(this,2,603 - 2,12430186,16310409);
         }
         _rankView = new RankView(_member.rank);
         addChild(_rankView);
         _avatar = assetRepository.getAvatarByProfile(_member.profile);
         addChild(_avatar);
         _starIcon = assetRepository.getDisplayObject("Level");
         addChild(_starIcon);
         _levelTextField = new CaptionTextField(WomTextFormats.MIGHT_FILTER);
         _levelTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_18;
         _levelTextField.autoSize = "left";
         _levelTextField.text = String(_member.level);
         addChild(_levelTextField);
         if(_member.allianceSummary != null)
         {
            _coatOfArmsView = new CoatOfArmsView(assetRepository);
            addChild(_coatOfArmsView);
            _coatOfArmsView.updateWithCoatOfArmsInfo(_member.allianceSummary.coaInfo);
         }
         _nameTextField = new CaptionTextField(WomTextFormats.GREEN_BUTTON_FILTER);
         _nameTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_20;
         _nameTextField.autoSize = "left";
         _nameTextField.text = _member.profile.gameId;
         addChild(_nameTextField);
         if(_member.allianceSummary != null)
         {
            _allianceNameTextField = new WomTextField();
            _allianceNameTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_18;
            _allianceNameTextField.autoSize = "left";
            _allianceNameTextField.text = _member.allianceSummary.name;
            addChild(_allianceNameTextField);
         }
         _numberOfWinsAsAttackerTextField = new WomTextField();
         _numberOfWinsAsAttackerTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_18;
         _numberOfWinsAsAttackerTextField.autoSize = "left";
         var _temp_10:* = _numberOfWinsAsAttackerTextField;
         var _temp_9:* = "ui.windows.league.attackswon";
         var _loc1_:int = _member.numberOfWinsAsAttacker;
         var _loc2_:String = _temp_9;
         _temp_10.text = peak.i18n.PText.INSTANCE.getText1(_loc2_,_loc1_);
         addChild(_numberOfWinsAsAttackerTextField);
         _numberOfWinsAsDefenderTextField = new WomTextField();
         _numberOfWinsAsDefenderTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_18;
         _numberOfWinsAsDefenderTextField.autoSize = "left";
         var _temp_13:* = _numberOfWinsAsDefenderTextField;
         var _temp_12:* = "ui.windows.league.defenceswon";
         var _loc3_:int = _member.numberOfWinsAsDefender;
         var _loc4_:String = _temp_12;
         _temp_13.text = peak.i18n.PText.INSTANCE.getText1(_loc4_,_loc3_);
         addChild(_numberOfWinsAsDefenderTextField);
         _battlePointsIcon = assetRepository.getDisplayObject("CrownIcon");
         addChild(_battlePointsIcon);
         _battlePointsTextField = new CaptionTextField(WomTextFormats.RED_BUTTON_FILTER);
         _battlePointsTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         _battlePointsTextField.autoSize = "left";
         _battlePointsTextField.text = String(_member.battlePoints);
         addChild(_battlePointsTextField);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         var _loc1_:int = 2;
         _rankView.x = (_member.rank > 50 ? 12 : _headerWidths["rank"] - _rankView.width >> 1) + _loc1_;
         _rankView.y = 70 - _rankView.height >> 1;
         _loc1_ += _headerWidths["rank"] + 1;
         _avatar.x = (_headerWidths["level"] - _avatar.width >> 1) + _loc1_;
         _avatar.y = 70 - _avatar.height >> 1;
         _loc1_ += _headerWidths["level"] + 1;
         AlignmentUtil.alignAccordingToPositionOf(_starIcon,_avatar,-5,-5);
         AlignmentUtil.alignMiddleOf(_levelTextField,_starIcon);
         if(_coatOfArmsView != null)
         {
            _coatOfArmsView.x = (_headerWidths["alliance"] - _coatOfArmsView.width >> 1) + _loc1_;
            _coatOfArmsView.y = 70 - _coatOfArmsView.height >> 1;
         }
         _loc1_ += _headerWidths["alliance"] + 1;
         _nameTextField.x = 6 + _loc1_;
         _nameTextField.y = 15;
         _loc1_ += _headerWidths["name"] + 1;
         if(_allianceNameTextField != null)
         {
            AlignmentUtil.alignBelowOf(_allianceNameTextField,_nameTextField,0);
         }
         _numberOfWinsAsAttackerTextField.x = 6 + _loc1_;
         _numberOfWinsAsAttackerTextField.y = 15;
         AlignmentUtil.alignBelowOf(_numberOfWinsAsDefenderTextField,_numberOfWinsAsAttackerTextField,0);
         _loc1_ += _headerWidths["history"] + 1;
         _battlePointsIcon.x = 12 + _loc1_;
         _battlePointsIcon.y = 70 - _battlePointsIcon.height >> 1;
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_battlePointsTextField,_battlePointsIcon,_battlePointsIcon.width + 2);
         _loc1_ += _headerWidths["battle_points"] + 1;
      }
      
      private function determineBackgroundColor() : uint
      {
         if(_me)
         {
            return 14803787;
         }
         if(_member.rank == 1)
         {
            return 16762399;
         }
         if(_member.rank == 2)
         {
            return 12566463;
         }
         if(_member.rank == 3)
         {
            return 13277541;
         }
         return 13876339;
      }
      
      public function updateName() : void
      {
         _nameTextField.text = _member.name;
         drawLayout();
      }
      
      public function get member() : LeagueMemberInfo
      {
         return _member;
      }
      
      public function get avatar() : DisplayObject
      {
         return _avatar;
      }
   }
}

