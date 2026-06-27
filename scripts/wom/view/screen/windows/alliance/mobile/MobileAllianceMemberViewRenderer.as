package wom.view.screen.windows.alliance.mobile
{
   import feathers.controls.renderers.IListItemRenderer;
   import flash.utils.Dictionary;
   import peak.component.mobile.MPItemRenderer;
   import peak.component.mobile.MPRigidButton;
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.logging.log;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.game.Profile;
   import wom.model.game.alliance.AllianceMemberInfo;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.service.logging.WomLoggerContexts;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.button.MobileReinforceButton;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   
   public class MobileAllianceMemberViewRenderer extends MPItemRenderer implements IListItemRenderer
   {
      
      public static const WIDTH:int = 969;
      
      public static const HEIGHT:int = 94;
      
      public static const ROW_TYPE_VIEW:int = 1;
      
      public static const ROW_TYPE_CANDIDATE:int = 2;
      
      public static const ROW_TYPE_REINFORCE_KICK_OUT:int = 3;
      
      public static const ROW_TYPE_INVITE:int = 4;
      
      public static const ROW_TYPE_CANCEL_INVITATION:int = 5;
      
      public static const ROW_TYPE_INVITATION_REJECTED:int = 6;
      
      public static const ROW_TYPE_INVITATION_ACCEPTED:int = 7;
      
      public static const ROW_TYPE_REINFORCE:int = 8;
      
      public static const ROW_TYPE_KICKOUT:int = 9;
      
      private var background:DisplayObject;
      
      private var _avatar:DisplayObject;
      
      private var _starIcon:DisplayObject;
      
      private var _textFieldLevel:MPTextField;
      
      private var _textFieldName:MPTextField;
      
      private var _textFieldContributionPoints:MPTextField;
      
      private var _battlePointsIcon:DisplayObject;
      
      private var _battlePointsTextField:MPTextField;
      
      private var _buttonView:MobileWomButton;
      
      private var _buttonAccept:MobileWomButton;
      
      private var _buttonReject:MobileWomButton;
      
      private var _buttonKickOut:MobileWomButton;
      
      private var _buttonInvite:MobileWomButton;
      
      private var _buttonCancelInvitation:MobileWomButton;
      
      private var _textFieldInvitationRejected:MPTextField;
      
      private var _buttonInvitationRejected:MPRigidButton;
      
      private var _textFieldInvitationAccepted:MPTextField;
      
      private var _buttonInvitationAccepted:MPRigidButton;
      
      private var _buttonReinforce:MobileReinforceButton;
      
      private var assetRepository:MobileWomAssetRepository;
      
      private var _headerWidths:Dictionary;
      
      private var _member:AllianceMemberInfo;
      
      private var _rowType:int;
      
      private var _allianceBarracksCapacity:int;
      
      private var _fromBrowseTab:Boolean;
      
      private var _ownGameId:String;
      
      public function MobileAllianceMemberViewRenderer(param1:MobileWomAssetRepository, param2:Dictionary, param3:String, param4:Boolean = false)
      {
         super();
         this.assetRepository = param1;
         _headerWidths = param2;
         _fromBrowseTab = param4;
         _ownGameId = param3;
         _starIcon = param1.getDisplayObject("IconLevelM");
         _starIcon.scaleX = _starIcon.scaleY = 36 / _starIcon.height;
         addChild(_starIcon);
         _textFieldLevel = new MobileCaptionTextField();
         _textFieldLevel.textRendererProperties.textFormat = getCaptionTextFormat(27,"center");
         _textFieldLevel.width = _starIcon.width;
         addChild(_textFieldLevel);
         _textFieldName = new MobileCaptionTextField();
         _textFieldName.textRendererProperties.textFormat = getCaptionTextFormat(25);
         addChild(_textFieldName);
         _battlePointsIcon = param1.getDisplayObject("IconBPM");
         addChild(_battlePointsIcon);
         _battlePointsTextField = new MobileCaptionTextField();
         _battlePointsTextField.textRendererProperties.textFormat = getCaptionTextFormat(25);
         addChild(_battlePointsTextField);
         if("contribution_points" in _headerWidths)
         {
            _textFieldContributionPoints = new MobileCaptionTextField();
            _textFieldContributionPoints.textRendererProperties.textFormat = getCaptionTextFormat(25);
            addChild(_textFieldContributionPoints);
         }
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
      
      private function initWithRowType() : void
      {
         var _loc1_:String = _member.isLeader ? "MobileYellowBackground" : (_member.profile.gameId == _ownGameId ? "MobileGreenBackground" : "MobileBeigeBackground");
         background = assetRepository.getDisplayObject(_loc1_);
         background.width = 969;
         background.height = 94;
         addChildAt(background,0);
         _avatar = assetRepository.getAvatarByProfile(_member.profile);
         addChildAt(_avatar,getChildIndex(_starIcon));
         if(_rowType == 1 || _rowType == 2 || _rowType == 3 || _rowType == 8 || _rowType == 9)
         {
            _buttonView = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Medium");
            _buttonView.width = 121;
            var _temp_8:* = _buttonView;
            var _loc2_:String = "ui.windows.alliance.members.action.enter";
            _temp_8.label = peak.i18n.PText.INSTANCE.getText0(_loc2_);
            addChild(_buttonView);
            if(_rowType == 2)
            {
               _buttonAccept = MobileWomUIComponentFactory.createMobileColoredButton("Green","Medium");
               _buttonAccept.width = 121;
               var _temp_10:* = _buttonAccept;
               var _loc3_:String = "ui.windows.alliance.members.action.accept";
               _temp_10.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
               addChild(_buttonAccept);
               _buttonReject = MobileWomUIComponentFactory.createMobileColoredButton("Red","Medium");
               _buttonReject.width = 121;
               var _temp_12:* = _buttonReject;
               var _loc4_:String = "ui.windows.alliance.members.action.reject";
               _temp_12.label = peak.i18n.PText.INSTANCE.getText0(_loc4_);
               addChild(_buttonReject);
            }
            if(_rowType == 3 || _rowType == 8)
            {
               _buttonReinforce = new MobileReinforceButton(MobileReinforceButton.TYPE_REINFORCE,"Blue");
               addChild(_buttonReinforce);
            }
            if(_rowType == 3 || _rowType == 9)
            {
               _buttonKickOut = MobileWomUIComponentFactory.createMobileColoredButton("Red","Medium");
               _buttonKickOut.width = 150;
               var _temp_17:* = _buttonKickOut;
               var _loc5_:String = "ui.windows.alliance.members.action.kickout";
               _temp_17.label = peak.i18n.PText.INSTANCE.getText0(_loc5_);
               addChild(_buttonKickOut);
            }
         }
         else if(_rowType == 4)
         {
            _buttonInvite = MobileWomUIComponentFactory.createMobileColoredButton("Green","Medium");
            _buttonInvite.width = 255;
            var _temp_19:* = _buttonInvite;
            var _loc6_:String = "ui.windows.alliance.members.action.invite";
            _temp_19.label = peak.i18n.PText.INSTANCE.getText0(_loc6_);
            addChild(_buttonInvite);
         }
         else if(_rowType == 5)
         {
            _buttonCancelInvitation = MobileWomUIComponentFactory.createMobileColoredButton("Green","Medium");
            _buttonCancelInvitation.width = 255;
            var _temp_21:* = _buttonCancelInvitation;
            var _loc7_:String = "ui.windows.alliance.members.action.mcancel";
            _temp_21.label = peak.i18n.PText.INSTANCE.getText0(_loc7_);
            addChild(_buttonCancelInvitation);
         }
         else if(_rowType == 6)
         {
            _textFieldInvitationRejected = new MobileCaptionTextField();
            _textFieldInvitationRejected.textRendererProperties.textFormat = getCaptionTextFormat(27,null,15016227);
            addChild(_textFieldInvitationRejected);
            var _temp_23:* = _textFieldInvitationRejected;
            var _loc8_:String = "ui.windows.alliance.members.action.invitationrejected";
            _temp_23.text = peak.i18n.PText.INSTANCE.getText0(_loc8_);
            _buttonInvitationRejected = new MPRigidButton("IconRedDecrease","IconRedDecreaseHover");
            addChild(_buttonInvitationRejected);
         }
         else if(_rowType == 7)
         {
            _textFieldInvitationAccepted = new MobileCaptionTextField();
            _textFieldInvitationAccepted.textRendererProperties.textFormat = getCaptionTextFormat(27,null,2849024);
            addChild(_textFieldInvitationAccepted);
            var _temp_26:* = _textFieldInvitationAccepted;
            var _loc9_:String = "ui.windows.alliance.members.action.invitationaccepted";
            _temp_26.text = peak.i18n.PText.INSTANCE.getText0(_loc9_);
            _buttonInvitationAccepted = new MPRigidButton("IconRedClose","IconRedCloseHover");
            addChild(_buttonInvitationAccepted);
         }
      }
      
      override public function get data() : Object
      {
         return _member;
      }
      
      override public function set data(param1:Object) : void
      {
         if(param1)
         {
            clearAll();
            _member = param1 as AllianceMemberInfo;
            _rowType = _member.type;
            _textFieldLevel.text = String(_member.level);
            _battlePointsTextField.text = String(_member.battlePoints);
            if(_textFieldContributionPoints)
            {
               _textFieldContributionPoints.text = String(_fromBrowseTab ? _member.battlePoints : _member.contributionPoints);
               _battlePointsTextField.text = String(_fromBrowseTab ? _member.battlePoints : member.tournamentContributionPoint);
               _battlePointsIcon.visible = _fromBrowseTab;
            }
            initWithRowType();
         }
         drawLayout();
      }
      
      public function clearAll() : void
      {
         if(_avatar && contains(_avatar))
         {
            removeChild(_avatar);
            _avatar = null;
         }
         if(background && contains(background))
         {
            removeChild(background);
            background = null;
         }
         if(_buttonView && contains(_buttonView))
         {
            removeChild(_buttonView);
            _buttonView = null;
         }
         if(_buttonAccept && contains(_buttonAccept))
         {
            removeChild(_buttonAccept);
            _buttonAccept = null;
         }
         if(_buttonReject && contains(_buttonReject))
         {
            removeChild(_buttonReject);
            _buttonReject = null;
         }
         if(_buttonReinforce && contains(_buttonReinforce))
         {
            removeChild(_buttonReinforce);
            _buttonReinforce = null;
         }
         if(_buttonKickOut && contains(_buttonKickOut))
         {
            removeChild(_buttonKickOut);
            _buttonKickOut = null;
         }
         if(_buttonInvite && contains(_buttonInvite))
         {
            removeChild(_buttonInvite);
            _buttonInvite = null;
         }
         if(_buttonInvitationAccepted && contains(_buttonInvitationAccepted))
         {
            removeChild(_buttonInvitationAccepted);
            _buttonInvitationAccepted = null;
         }
         if(_buttonInvitationRejected && contains(_buttonInvitationRejected))
         {
            removeChild(_buttonInvitationRejected);
            _buttonInvitationRejected = null;
         }
         if(_textFieldInvitationAccepted && contains(_textFieldInvitationAccepted))
         {
            removeChild(_textFieldInvitationAccepted);
            _textFieldInvitationAccepted = null;
         }
         if(_textFieldInvitationRejected && contains(_textFieldInvitationRejected))
         {
            removeChild(_textFieldInvitationRejected);
            _textFieldInvitationRejected = null;
         }
         if(_buttonCancelInvitation && contains(_buttonCancelInvitation))
         {
            removeChild(_buttonCancelInvitation);
            _buttonCancelInvitation = null;
         }
         _battlePointsTextField.text = "";
         _textFieldLevel.text = "";
      }
      
      public function drawLayout() : void
      {
         var _loc2_:int = 3;
         _avatar.x = (_headerWidths["level"] - 68 >> 1) + _loc2_;
         _avatar.y = 13;
         _loc2_ += _headerWidths["level"] + 1;
         MobileAlignmentUtil.alignAccordingToPositionOf(_starIcon,_avatar,-10,-11);
         MobileAlignmentUtil.alignAccordingToPositionOf(_textFieldLevel,_starIcon,(_starIcon.width - _textFieldLevel.width >> 1) - 3,(_starIcon.height - _textFieldLevel.height >> 1) + 5);
         _textFieldName.x = 12 + _loc2_;
         _textFieldName.y = 94 - _textFieldName.height >> 1;
         _loc2_ += _headerWidths["name"] + 1;
         if("contribution_points" in _headerWidths)
         {
            _textFieldContributionPoints.x = (_headerWidths["contribution_points"] - _textFieldContributionPoints.width >> 1) + _loc2_;
            _textFieldContributionPoints.y = 94 - _textFieldContributionPoints.height >> 1;
            _loc2_ += _headerWidths["contribution_points"] + 1;
         }
         if(_battlePointsIcon.visible)
         {
            _battlePointsIcon.x = 12 + _loc2_;
            _battlePointsIcon.y = 94 - _battlePointsIcon.height >> 1;
            MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_battlePointsTextField,_battlePointsIcon,_battlePointsIcon.width + 2);
         }
         else
         {
            _battlePointsTextField.x = _loc2_ + (_headerWidths["battle_points"] - _battlePointsTextField.width >> 1);
            _battlePointsTextField.y = 94 - _battlePointsTextField.height >> 1;
         }
         _loc2_ += _headerWidths["battle_points"] - 10;
         var _loc1_:int = 12;
         switch(_rowType - 1)
         {
            case 0:
               _buttonView.x = (_headerWidths["actions"] - _buttonView.width >> 1) + _loc2_;
               _buttonView.y = 94 - _buttonView.height >> 1;
               break;
            case 1:
               _buttonView.x = (_headerWidths["actions"] - (_buttonView.width + _buttonAccept.width + _buttonReject.width + 2) >> 1) + _loc2_;
               _buttonView.y = 94 - _buttonView.height >> 1;
               MobileAlignmentUtil.alignRightOf(_buttonAccept,_buttonView,_loc1_);
               MobileAlignmentUtil.alignRightOf(_buttonReject,_buttonAccept,_loc1_);
               break;
            case 2:
               _buttonReinforce.validate();
               _buttonReinforce.x = (_headerWidths["actions"] - (_buttonView.width + _buttonReinforce.width + _buttonKickOut.width + 2) >> 1) + _loc2_;
               _buttonReinforce.y = 94 - _buttonView.height >> 1;
               MobileAlignmentUtil.alignRightOf(_buttonView,_buttonReinforce,_loc1_);
               MobileAlignmentUtil.alignRightOf(_buttonKickOut,_buttonView,_loc1_);
               break;
            case 3:
               _buttonInvite.x = (_headerWidths["actions"] - _buttonInvite.width >> 1) + _loc2_;
               _buttonInvite.y = 94 - _buttonInvite.height >> 1;
               break;
            case 4:
               _buttonCancelInvitation.x = _loc2_ + (_headerWidths["actions"] - 25 - _buttonCancelInvitation.width);
               _buttonCancelInvitation.y = 94 - _buttonCancelInvitation.height >> 1;
               break;
            case 5:
               _buttonInvitationRejected.x = _loc2_ + (_headerWidths["actions"] - 25 - _buttonInvitationRejected.width);
               _buttonInvitationRejected.y = 94 - _buttonInvitationRejected.height >> 1;
               _textFieldInvitationRejected.x = _buttonInvitationRejected.x - 40 - _textFieldInvitationRejected.width;
               _textFieldInvitationRejected.y = 94 - _textFieldInvitationRejected.height >> 1;
               break;
            case 6:
               _buttonInvitationAccepted.x = _loc2_ + (_headerWidths["actions"] - 25 - _buttonInvitationAccepted.width);
               _buttonInvitationAccepted.y = 94 - _buttonInvitationAccepted.height >> 1;
               _textFieldInvitationAccepted.x = _buttonInvitationAccepted.x - 40 - _textFieldInvitationAccepted.width;
               _textFieldInvitationAccepted.y = 94 - _textFieldInvitationAccepted.height >> 1;
               break;
            case 7:
               _buttonReinforce.validate();
               _buttonReinforce.x = (_headerWidths["actions"] - (_buttonView.width + _buttonReinforce.width + 1) >> 1) + _loc2_;
               _buttonReinforce.y = 94 - _buttonReinforce.height >> 1;
               MobileAlignmentUtil.alignRightOf(_buttonView,_buttonReinforce,_loc1_);
               break;
            case 8:
               _buttonView.x = (_headerWidths["actions"] - (_buttonView.width + _buttonKickOut.width + 1) >> 1) + _loc2_;
               _buttonView.y = 94 - _buttonView.height >> 1;
               MobileAlignmentUtil.alignRightOf(_buttonKickOut,_buttonView,_loc1_);
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
               _buttonView.isEnabled = false;
            }
            if(_buttonKickOut)
            {
               _buttonKickOut.isEnabled = false;
            }
            if(_buttonReinforce)
            {
               _buttonReinforce.isEnabled = false;
            }
         }
         else if(_buttonReinforce)
         {
            _buttonReinforce.isEnabled = true;
            if(_allianceBarracksCapacity == 0)
            {
               _buttonReinforce.maximum = 1;
               _buttonReinforce.value = 0;
               _buttonReinforce.isEnabled = false;
            }
            else
            {
               _buttonReinforce.maximum = _allianceBarracksCapacity;
               _buttonReinforce.value = _allianceBarracksCapacity - _member.availableAllianceBarracksCapacity;
               if(_member.availableAllianceBarracksCapacity == 0)
               {
                  _buttonReinforce.isEnabled = false;
               }
            }
         }
      }
      
      public function get buttonView() : MobileWomButton
      {
         return _buttonView;
      }
      
      public function get buttonAccept() : MobileWomButton
      {
         return _buttonAccept;
      }
      
      public function get buttonReject() : MobileWomButton
      {
         return _buttonReject;
      }
      
      public function get buttonKickOut() : MobileWomButton
      {
         return _buttonKickOut;
      }
      
      public function get buttonInvite() : MobileWomButton
      {
         return _buttonInvite;
      }
      
      public function get buttonCancelInvitation() : MobileWomButton
      {
         return _buttonCancelInvitation;
      }
      
      public function get buttonInvitationRejected() : MPRigidButton
      {
         return _buttonInvitationRejected;
      }
      
      public function get buttonInvitationAccepted() : MPRigidButton
      {
         return _buttonInvitationAccepted;
      }
      
      public function get buttonReinforce() : MobileWomButton
      {
         return _buttonReinforce;
      }
      
      public function get rowType() : int
      {
         return _rowType;
      }
      
      public function get member() : AllianceMemberInfo
      {
         return _member;
      }
      
      public function get allianceBarracksCapacity() : int
      {
         return _allianceBarracksCapacity;
      }
      
      public function set allianceBarracksCapacity(param1:int) : void
      {
         _allianceBarracksCapacity = param1;
      }
   }
}

