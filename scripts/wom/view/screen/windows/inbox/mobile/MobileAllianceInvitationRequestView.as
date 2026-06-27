package wom.view.screen.windows.inbox.mobile
{
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import wom.model.game.alliance.AllianceInvitationInfo;
   import wom.model.game.friend.request.AllianceInvitationRequestInfo;
   import wom.model.game.friend.request.RequestInfo;
   import wom.view.screen.windows.alliance.coa.mobile.MobileCoatOfArmsView;
   
   public class MobileAllianceInvitationRequestView extends MobileBaseRequestView
   {
      
      private var _coatOfArmsView:MobileCoatOfArmsView;
      
      private var _invitation:AllianceInvitationInfo;
      
      public function MobileAllianceInvitationRequestView(param1:RequestInfo)
      {
         var _loc2_:Vector.<RequestInfo> = new Vector.<RequestInfo>();
         _loc2_.push(param1);
         super(_loc2_);
         _invitation = (param1 as AllianceInvitationRequestInfo).invitation;
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         _coatOfArmsView = new MobileCoatOfArmsView(assetRepository);
         addChild(_coatOfArmsView);
         _coatOfArmsView.updateWithCoatOfArmsInfo(_invitation.coatOfArmsInfo);
         _coatOfArmsView.scaleX = _coatOfArmsView.scaleY = 0.5;
         var _temp_3:* = _titleTextField;
         var _temp_2:* = "ui.windows.inbox.requesttype.10.title";
         var _loc2_:String = _invitation.allianceName;
         var _loc3_:String = _temp_2;
         _temp_3.text = peak.i18n.PText.INSTANCE.getText1(_loc3_,_loc2_);
         drawLayout();
      }
      
      override public function drawLayout() : void
      {
         hideAllAvatars();
         _otherFriendNamesTextField.visible = false;
         friendNameTextField.text = _invitation.allianceName;
         MobileAlignmentUtil.alignAccordingToPositionOf(_coatOfArmsView,background,30,30);
         MobileAlignmentUtil.alignAccordingToPositionOf(friendNameTextField,background,127,30);
         MobileAlignmentUtil.alignBelowOf(_titleTextField,friendNameTextField,0);
         super.drawLayout();
      }
      
      public function get invitation() : AllianceInvitationInfo
      {
         return _invitation;
      }
   }
}

