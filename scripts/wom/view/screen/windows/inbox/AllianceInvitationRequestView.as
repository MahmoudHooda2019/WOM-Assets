package wom.view.screen.windows.inbox
{
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.game.alliance.AllianceInvitationInfo;
   import wom.model.game.friend.request.AllianceInvitationRequestInfo;
   import wom.model.game.friend.request.RequestInfo;
   import wom.view.screen.windows.alliance.coa.CoatOfArmsView;
   
   public class AllianceInvitationRequestView extends BaseRequestView
   {
      
      private var _coatOfArmsView:CoatOfArmsView;
      
      private var _invitation:AllianceInvitationInfo;
      
      public function AllianceInvitationRequestView(param1:RequestInfo)
      {
         var _loc2_:Vector.<RequestInfo> = new Vector.<RequestInfo>();
         _loc2_.push(param1);
         super(_loc2_);
         _invitation = (param1 as AllianceInvitationRequestInfo).invitation;
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         _coatOfArmsView = new CoatOfArmsView(assetRepository);
         addChild(_coatOfArmsView);
         _coatOfArmsView.updateWithCoatOfArmsInfo(_invitation.coatOfArmsInfo);
         var _temp_3:* = _titleTextField;
         var _temp_2:* = "ui.windows.inbox.requesttype.10.title";
         var _loc1_:String = _invitation.allianceName;
         var _loc2_:String = _temp_2;
         _temp_3.text = peak.i18n.PText.INSTANCE.getText1(_loc2_,_loc1_);
         drawLayout();
      }
      
      override public function drawLayout() : void
      {
         hideAllAvatars();
         _otherFriendNamesTextField.visible = false;
         friendNameTextField.text = _invitation.allianceName;
         AlignmentUtil.alignAccordingToPositionOf(_coatOfArmsView,background,0,6);
         AlignmentUtil.alignAccordingToPositionOf(friendNameTextField,background,63,7);
         AlignmentUtil.alignBelowOf(_titleTextField,friendNameTextField,0);
         super.drawLayout();
      }
      
      public function get invitation() : AllianceInvitationInfo
      {
         return _invitation;
      }
   }
}

