package wom.view.screen.windows.alliance
{
   import fl.controls.Button;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.logging.log;
   import peak.util.AlignmentUtil;
   import wom.model.game.Profile;
   import wom.model.game.alliance.AllianceMemberInfo;
   import wom.model.resource.WomAssetRepository;
   import wom.service.logging.WomLoggerContexts;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.ReinforceButton;
   import wom.view.component.button.colored.WomBlueSmallButton;
   import wom.view.component.button.colored.WomBrownSmallButton;
   import wom.view.component.button.colored.WomRedMiniButton;
   import wom.view.component.button.colored.WomRedSmallButton;
   import wom.view.util.LineUtil;
   
   public class AllianceMemberView extends Sprite implements View
   {
      
      private static const HEIGHT:int = 70;
      
      public static const ROW_TYPE_VIEW:int = 1;
      
      public static const ROW_TYPE_CANDIDATE:int = 2;
      
      public static const ROW_TYPE_REINFORCE_KICK_OUT:int = 3;
      
      public static const ROW_TYPE_INVITE:int = 4;
      
      public static const ROW_TYPE_CANCEL_INVITATION:int = 5;
      
      public static const ROW_TYPE_INVITATION_REJECTED:int = 6;
      
      public static const ROW_TYPE_INVITATION_ACCEPTED:int = 7;
      
      public static const ROW_TYPE_REINFORCE:int = 8;
      
      public static const ROW_TYPE_KICKOUT:int = 9;
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      private var _avatar:DisplayObject;
      
      private var _starIcon:DisplayObject;
      
      private var _textFieldLevel:TextField;
      
      private var _textFieldName:TextField;
      
      private var _textFieldContributionPoints:TextField;
      
      private var _battlePointsIcon:DisplayObject;
      
      private var _battlePointsTextField:TextField;
      
      private var _buttonView:Button;
      
      private var _buttonAccept:Button;
      
      private var _buttonReject:Button;
      
      private var _buttonKickOut:Button;
      
      private var _buttonInvite:Button;
      
      private var _buttonCancelInvitation:Button;
      
      private var _textFieldInvitationRejected:TextField;
      
      private var _buttonInvitationRejected:Button;
      
      private var _textFieldInvitationAccepted:TextField;
      
      private var _buttonInvitationAccepted:Button;
      
      private var _buttonReinforce:ReinforceButton;
      
      private var _member:AllianceMemberInfo;
      
      private var _headerWidths:Dictionary;
      
      private var _rowType:int;
      
      private var _viewOrderInPage:int;
      
      private var _allianceBarracksCapacity:int;
      
      public function AllianceMemberView(param1:AllianceMemberInfo, param2:Dictionary, param3:int, param4:int = 1)
      {
         super();
         _member = param1;
         _headerWidths = param2;
         _rowType = param4;
         _viewOrderInPage = param3;
      }
      
      public static function determineRowType(param1:int) : int
      {
         var _loc2_:int = 1;
         switch(param1)
         {
            case 0:
               _loc2_ = 2;
               break;
            case 1:
               _loc2_ = 5;
               break;
            case 2:
               _loc2_ = 6;
               break;
            default:
               log(WomLoggerContexts.GAME,"Unexpected alliance candidate type: " + param1);
         }
         return _loc2_;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         var _loc1_:String = null;
         if(_member.isLeader)
         {
            graphics.beginFill(16762399,1);
            if(_viewOrderInPage % 5 == 0)
            {
               graphics.drawRoundRectComplex(0,0,661,70 + 7,0,0,8,8);
            }
            else
            {
               graphics.drawRect(0,0,661,70 - 2);
            }
            graphics.endFill();
         }
         _avatar = assetRepository.getAvatarByProfile(_member.profile);
         addChild(_avatar);
         _starIcon = assetRepository.getDisplayObject("Level");
         addChild(_starIcon);
         _textFieldLevel = new CaptionTextField(WomTextFormats.MIGHT_FILTER);
         _textFieldLevel.defaultTextFormat = WomTextFormats.FONT_SIZE_18;
         _textFieldLevel.autoSize = "left";
         _textFieldLevel.text = String(_member.level);
         addChild(_textFieldLevel);
         _textFieldName = new CaptionTextField(WomTextFormats.GREEN_BUTTON_FILTER);
         _textFieldName.defaultTextFormat = WomTextFormats.FONT_SIZE_24;
         _textFieldName.autoSize = "left";
         _textFieldName.text = _member.profile.gameId;
         addChild(_textFieldName);
         if("contribution_points" in _headerWidths)
         {
            _textFieldContributionPoints = new WomTextField();
            _textFieldContributionPoints.defaultTextFormat = WomTextFormats.FONT_SIZE_22;
            _textFieldContributionPoints.autoSize = "left";
            _textFieldContributionPoints.width = _headerWidths["contribution_points"];
            _textFieldContributionPoints.text = String(_member.contributionPoints);
            addChild(_textFieldContributionPoints);
         }
         else
         {
            _battlePointsIcon = assetRepository.getDisplayObject("CrownIcon");
            addChild(_battlePointsIcon);
         }
         _battlePointsTextField = new WomTextField();
         _battlePointsTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_22;
         _battlePointsTextField.autoSize = "left";
         _battlePointsTextField.width = _headerWidths["battle_points"];
         if("contribution_points" in _headerWidths)
         {
            _loc1_ = String(_member.tournamentContributionPoint);
         }
         else
         {
            _loc1_ = String(_member.battlePoints);
         }
         _battlePointsTextField.text = _loc1_;
         addChild(_battlePointsTextField);
         if(_rowType == 1 || _rowType == 2 || _rowType == 3 || _rowType == 8 || _rowType == 9)
         {
            _buttonView = new WomBrownSmallButton();
            _buttonView.width = _rowType == 3 ? 68 : 88;
            var _temp_13:* = _buttonView;
            var _loc2_:String = "ui.windows.alliance.members.action.view";
            _temp_13.label = peak.i18n.PText.INSTANCE.getText0(_loc2_);
            addChild(_buttonView);
            if(_rowType == 2)
            {
               _buttonAccept = new WomBlueSmallButton();
               _buttonAccept.width = 88;
               var _temp_15:* = _buttonAccept;
               var _loc3_:String = "ui.windows.alliance.members.action.accept";
               _temp_15.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
               addChild(_buttonAccept);
               _buttonReject = new WomRedSmallButton();
               _buttonReject.width = 88;
               var _temp_17:* = _buttonReject;
               var _loc4_:String = "ui.windows.alliance.members.action.reject";
               _temp_17.label = peak.i18n.PText.INSTANCE.getText0(_loc4_);
               addChild(_buttonReject);
            }
            if(_rowType == 3 || _rowType == 8)
            {
               _buttonReinforce = new ReinforceButton();
               var _temp_20:* = _buttonReinforce;
               var _loc5_:String = "ui.windows.alliance.members.action.reinforce";
               _temp_20.label = peak.i18n.PText.INSTANCE.getText0(_loc5_);
               if(_allianceBarracksCapacity == 0)
               {
                  _buttonReinforce.maximum = 1;
                  _buttonReinforce.value = 0;
                  _buttonReinforce.enabled = false;
               }
               else
               {
                  _buttonReinforce.maximum = _allianceBarracksCapacity;
                  _buttonReinforce.value = _allianceBarracksCapacity - _member.availableAllianceBarracksCapacity;
                  if(_member.availableAllianceBarracksCapacity == 0)
                  {
                     _buttonReinforce.enabled = false;
                  }
               }
               addChild(_buttonReinforce);
            }
            if(_rowType == 3 || _rowType == 9)
            {
               _buttonKickOut = new WomRedSmallButton();
               _buttonKickOut.width = 31;
               _buttonKickOut.setStyle("icon",assetRepository.getDisplayObject("IconCancel"));
               addChild(_buttonKickOut);
            }
         }
         else if(_rowType == 4)
         {
            _buttonInvite = new WomBlueSmallButton();
            _buttonInvite.width = 150;
            var _temp_24:* = _buttonInvite;
            var _loc6_:String = "ui.windows.alliance.members.action.invite";
            _temp_24.label = peak.i18n.PText.INSTANCE.getText0(_loc6_);
            addChild(_buttonInvite);
         }
         else if(_rowType == 5)
         {
            _buttonCancelInvitation = new WomRedSmallButton();
            _buttonCancelInvitation.width = 88;
            var _temp_26:* = _buttonCancelInvitation;
            var _loc7_:String = "ui.windows.alliance.members.action.cancel";
            _temp_26.label = peak.i18n.PText.INSTANCE.getText0(_loc7_);
            addChild(_buttonCancelInvitation);
         }
         else if(_rowType == 6)
         {
            _textFieldInvitationRejected = new CaptionTextField(WomTextFormats.RED_BUTTON_FILTER);
            _textFieldInvitationRejected.defaultTextFormat = WomTextFormats.FONT_SIZE_24;
            _textFieldInvitationRejected.autoSize = "left";
            var _temp_28:* = _textFieldInvitationRejected;
            var _loc8_:String = "ui.windows.alliance.members.action.invitationrejected";
            _temp_28.text = peak.i18n.PText.INSTANCE.getText0(_loc8_);
            addChild(_textFieldInvitationRejected);
            _buttonInvitationRejected = new WomRedMiniButton();
            _buttonInvitationRejected.width = 20;
            _buttonInvitationRejected.setStyle("icon",assetRepository.getDisplayObject("IconCancel"));
            addChild(_buttonInvitationRejected);
         }
         else if(_rowType == 7)
         {
            _textFieldInvitationAccepted = new CaptionTextField(WomTextFormats.GREEN_BUTTON_FILTER);
            _textFieldInvitationAccepted.defaultTextFormat = WomTextFormats.FONT_SIZE_24;
            _textFieldInvitationAccepted.autoSize = "left";
            var _temp_31:* = _textFieldInvitationAccepted;
            var _loc9_:String = "ui.windows.alliance.members.action.invitationaccepted";
            _temp_31.text = peak.i18n.PText.INSTANCE.getText0(_loc9_);
            addChild(_textFieldInvitationAccepted);
            _buttonInvitationAccepted = new WomRedMiniButton();
            _buttonInvitationAccepted.width = 20;
            _buttonInvitationAccepted.setStyle("icon",assetRepository.getDisplayObject("IconCancel"));
            addChild(_buttonInvitationAccepted);
         }
         LineUtil.drawHorizontalSeparatorLine(this,0,661,null,null,68);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         var _loc1_:int = 3;
         _avatar.x = (_headerWidths["level"] - _avatar.width >> 1) + _loc1_;
         _avatar.y = 70 - _avatar.height >> 1;
         _loc1_ += _headerWidths["level"] + 1;
         AlignmentUtil.alignAccordingToPositionOf(_starIcon,_avatar,-5,-5);
         AlignmentUtil.alignMiddleOf(_textFieldLevel,_starIcon);
         _textFieldName.x = 12 + _loc1_;
         _textFieldName.y = 70 - _textFieldName.height >> 1;
         _loc1_ += _headerWidths["name"] + 1;
         if("contribution_points" in _headerWidths)
         {
            _textFieldContributionPoints.x = (_headerWidths["contribution_points"] - _textFieldContributionPoints.width >> 1) + _loc1_;
            _textFieldContributionPoints.y = 70 - _textFieldContributionPoints.height >> 1;
            _loc1_ += _headerWidths["contribution_points"] + 1;
         }
         if(_battlePointsIcon != null)
         {
            _battlePointsIcon.x = 12 + _loc1_;
            _battlePointsIcon.y = 70 - _battlePointsIcon.height >> 1;
            AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_battlePointsTextField,_battlePointsIcon,_battlePointsIcon.width + 2);
         }
         else
         {
            _battlePointsTextField.x = (_headerWidths["battle_points"] - _battlePointsTextField.width >> 1) + _loc1_;
            _battlePointsTextField.y = 70 - _battlePointsTextField.height >> 1;
         }
         _loc1_ += _headerWidths["battle_points"] + 1;
         switch(_rowType - 1)
         {
            case 0:
               _buttonView.x = (_headerWidths["actions"] - _buttonView.width >> 1) + _loc1_;
               _buttonView.y = 70 - _buttonView.height >> 1;
               break;
            case 1:
               _buttonView.x = (_headerWidths["actions"] - (_buttonView.width + _buttonAccept.width + _buttonReject.width + 2) >> 1) + _loc1_;
               _buttonView.y = 70 - _buttonView.height >> 1;
               AlignmentUtil.alignRightOf(_buttonAccept,_buttonView,1);
               AlignmentUtil.alignRightOf(_buttonReject,_buttonAccept,1);
               break;
            case 2:
               _buttonReinforce.x = (_headerWidths["actions"] - (_buttonView.width + _buttonReinforce.width + _buttonKickOut.width + 2) >> 1) + _loc1_;
               _buttonReinforce.y = 70 - _buttonView.height >> 1;
               AlignmentUtil.alignRightOf(_buttonView,_buttonReinforce,1);
               AlignmentUtil.alignRightOf(_buttonKickOut,_buttonView,1);
               break;
            case 3:
               _buttonInvite.x = (_headerWidths["actions"] - _buttonInvite.width >> 1) + _loc1_;
               _buttonInvite.y = 70 - _buttonInvite.height >> 1;
               break;
            case 4:
               _buttonCancelInvitation.x = _loc1_ + (_headerWidths["actions"] - 25 - _buttonCancelInvitation.width);
               _buttonCancelInvitation.y = 70 - _buttonCancelInvitation.height >> 1;
               break;
            case 5:
               _buttonInvitationRejected.x = _loc1_ + (_headerWidths["actions"] - 25 - _buttonInvitationRejected.width);
               _buttonInvitationRejected.y = 70 - _buttonInvitationRejected.height >> 1;
               _textFieldInvitationRejected.x = _buttonInvitationRejected.x - 40 - _textFieldInvitationRejected.width;
               _textFieldInvitationRejected.y = 70 - _textFieldInvitationRejected.height >> 1;
               break;
            case 6:
               _buttonInvitationAccepted.x = _loc1_ + (_headerWidths["actions"] - 25 - _buttonInvitationAccepted.width);
               _buttonInvitationAccepted.y = 70 - _buttonInvitationAccepted.height >> 1;
               _textFieldInvitationAccepted.x = _buttonInvitationAccepted.x - 40 - _textFieldInvitationAccepted.width;
               _textFieldInvitationAccepted.y = 70 - _textFieldInvitationAccepted.height >> 1;
               break;
            case 7:
               _buttonReinforce.x = (_headerWidths["actions"] - (_buttonView.width + _buttonReinforce.width + 1) >> 1) + _loc1_;
               _buttonReinforce.y = 70 - _buttonReinforce.height >> 1;
               AlignmentUtil.alignRightOf(_buttonView,_buttonReinforce,1);
               break;
            case 8:
               _buttonView.x = (_headerWidths["actions"] - (_buttonView.width + _buttonKickOut.width + 1) >> 1) + _loc1_;
               _buttonView.y = 70 - _buttonView.height >> 1;
               AlignmentUtil.alignRightOf(_buttonKickOut,_buttonView,1);
         }
      }
      
      public function updateName() : void
      {
         _textFieldName.text = _member.name;
         drawLayout();
      }
      
      public function updateButtonEnabling(param1:Profile) : void
      {
         if(_member.profile.gameId == param1.gameId)
         {
            if(_buttonView)
            {
               _buttonView.enabled = false;
            }
            if(_buttonKickOut)
            {
               _buttonKickOut.enabled = false;
            }
            if(_buttonReinforce)
            {
               _buttonReinforce.enabled = false;
            }
         }
      }
      
      public function get member() : AllianceMemberInfo
      {
         return _member;
      }
      
      public function get avatar() : DisplayObject
      {
         return _avatar;
      }
      
      public function get buttonView() : Button
      {
         return _buttonView;
      }
      
      public function get buttonAccept() : Button
      {
         return _buttonAccept;
      }
      
      public function get buttonReject() : Button
      {
         return _buttonReject;
      }
      
      public function get buttonKickOut() : Button
      {
         return _buttonKickOut;
      }
      
      public function get buttonInvite() : Button
      {
         return _buttonInvite;
      }
      
      public function get buttonCancelInvitation() : Button
      {
         return _buttonCancelInvitation;
      }
      
      public function get buttonInvitationRejected() : Button
      {
         return _buttonInvitationRejected;
      }
      
      public function get buttonInvitationAccepted() : Button
      {
         return _buttonInvitationAccepted;
      }
      
      public function get rowType() : int
      {
         return _rowType;
      }
      
      public function set allianceBarracksCapacity(param1:int) : void
      {
         _allianceBarracksCapacity = param1;
      }
      
      public function get buttonReinforce() : Button
      {
         return _buttonReinforce;
      }
   }
}

