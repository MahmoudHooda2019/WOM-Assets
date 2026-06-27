package wom.view.screen.popups.passafriend
{
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.game.Profile;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.ui.common.MobileLightAnimationView;
   import wom.view.ui.common.MobileSpeechBubbleView;
   import wom.view.util.MobileGenericWindow;
   
   public class MobilePassAFriendPopUp extends MobileGenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 559;
      
      private static const WINDOW_HEIGHT:int = 355;
      
      private var _lightView:MobileLightAnimationView;
      
      private var clementineHappyAsset:DisplayObject;
      
      private var _speechBubble:MobileSpeechBubbleView;
      
      private var _bragToYourFriendsButton:MobileWomButton;
      
      private var _myAvatar:MobileAvatarWithArrowView;
      
      private var _friendAvatar:MobileAvatarWithArrowView;
      
      private var myProfile:Profile;
      
      private var myName:String;
      
      private var _friendProfile:Profile;
      
      private var _friendName:String;
      
      private var myExperiencePoints:Number;
      
      private var friendExperiencePoints:Number;
      
      public function MobilePassAFriendPopUp(param1:Profile, param2:String, param3:Number, param4:Profile, param5:String, param6:Number)
      {
         super(559,355);
         this.myName = param2;
         this.myProfile = param1;
         this.myExperiencePoints = param3;
         this._friendProfile = param4;
         this._friendName = param5;
         this.friendExperiencePoints = param6;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.popups.passedafriend.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         clementineHappyAsset = assetRepository.getDisplayObject("MPose4");
         addChild(clementineHappyAsset);
         _speechBubble = new MobileSpeechBubbleView(350,"",null,null,170,68);
         addChild(_speechBubble);
         _myAvatar = new MobileAvatarWithArrowView(1,myName,myProfile,myExperiencePoints);
         addChild(_myAvatar);
         _friendAvatar = new MobileAvatarWithArrowView(0,_friendName,_friendProfile,friendExperiencePoints);
         addChild(_friendAvatar);
         _bragToYourFriendsButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Large");
         _bragToYourFriendsButton.width = 468;
         var _temp_7:* = _bragToYourFriendsButton;
         var _loc2_:String = "ui.popups.passedafriend.bragtoyourfriends";
         _temp_7.label = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         addChild(_bragToYourFriendsButton);
         drawLayout();
      }
      
      override protected function drawBackground() : void
      {
         super.drawBackground();
         _lightView = new MobileLightAnimationView();
         _lightView.scaleX = _lightView.scaleY = 2;
         addChild(_lightView);
      }
      
      public function drawLayout() : void
      {
         _lightView.x = _background.width >> 1;
         _lightView.y = _background.height >> 1;
         MobileAlignmentUtil.alignAccordingToPositionOf(clementineHappyAsset,_background,-4,85);
         MobileAlignmentUtil.alignAccordingToPositionOf(_speechBubble,_background,160,50);
         MobileAlignmentUtil.alignAccordingToPositionOf(_myAvatar,_speechBubble,80,50);
         MobileAlignmentUtil.alignAccordingToPositionOf(_friendAvatar,_speechBubble,220,10);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_bragToYourFriendsButton,_background,_background.height - (_bragToYourFriendsButton.height >> 1));
      }
      
      public function get bragToYourFriendsButton() : MobileWomButton
      {
         return _bragToYourFriendsButton;
      }
      
      public function get myAvatar() : MobileAvatarWithArrowView
      {
         return _myAvatar;
      }
      
      public function get friendAvatar() : MobileAvatarWithArrowView
      {
         return _friendAvatar;
      }
      
      public function get speechBubble() : MobileSpeechBubbleView
      {
         return _speechBubble;
      }
      
      public function get friendProfile() : Profile
      {
         return _friendProfile;
      }
      
      public function get lightView() : MobileLightAnimationView
      {
         return _lightView;
      }
   }
}

