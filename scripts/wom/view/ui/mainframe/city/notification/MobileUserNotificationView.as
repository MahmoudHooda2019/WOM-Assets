package wom.view.ui.mainframe.city.notification
{
   import com.greensock.TweenMax;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Quad;
   import starling.display.Sprite;
   import wom.controller.event.ui.MobileUserNotificationViewEvent;
   import wom.model.game.viral.MobileUserNotification;
   import wom.model.game.viral.UserNotification;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getWomTextFormat;
   import wom.view.screen.windows.build.MobileBuildingSilhouette;
   
   public class MobileUserNotificationView extends Sprite
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var background:DisplayObject;
      
      private var _requestAvatar:DisplayObject;
      
      private var _notificationTextField:MobileWomTextField;
      
      private var _ongoingAnimation:Boolean;
      
      private var _shareButton:MobileWomButton;
      
      private var _userNotification:UserNotification;
      
      private const MAX_AVATAR_SIZE:Number = 80;
      
      private var seperator:Quad;
      
      public function MobileUserNotificationView()
      {
         super();
      }
      
      [PostConstruct]
      public function init() : void
      {
         _ongoingAnimation = false;
         initLayout();
      }
      
      private function initLayout() : void
      {
         this.alpha = 0;
         this.visible = false;
         background = assetRepository.getDisplayObject("BackgroundTransparentPanel");
         background.width = 280;
         background.height = 82;
         addChild(background);
         _requestAvatar = assetRepository.getDisplayObject("TransparentAsset");
         addChild(_requestAvatar);
         seperator = new Quad(1,48,7093760);
         addChild(seperator);
         _notificationTextField = new MobileWomTextField();
         _notificationTextField.width = 165;
         _notificationTextField.textRendererProperties.textFormat = getWomTextFormat(19);
         _notificationTextField.textRendererProperties.wordWrap = true;
         addChild(_notificationTextField);
         _shareButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Small");
         _shareButton.width = 100;
         var _temp_6:* = _shareButton;
         var _loc1_:String = "ui.popups.helpback.share";
         _temp_6.label = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         addChild(_shareButton);
         _shareButton.visible = false;
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         var _loc1_:Number = NaN;
         if(_requestAvatar.width > 80 || _requestAvatar.height > 80)
         {
            _loc1_ = 80 / Math.max(_requestAvatar.width,_requestAvatar.height);
            if(_requestAvatar is MobileBuildingSilhouette)
            {
               (_requestAvatar as MobileBuildingSilhouette).scaleFactor = _loc1_;
            }
            _requestAvatar.scaleX = _requestAvatar.scaleY = _loc1_;
         }
         MobileAlignmentUtil.alignAccordingToPositionOf(_requestAvatar,background,4 + ((90 - _requestAvatar.width >> 1) + (_requestAvatar is MobileBuildingSilhouette ? (_requestAvatar as MobileBuildingSilhouette).mobileUIOffsetX * _loc1_ : 0)),(background.height - _requestAvatar.height >> 1) + (_requestAvatar is MobileBuildingSilhouette ? (_requestAvatar as MobileBuildingSilhouette).mobileUIOffsetY * _loc1_ : 0));
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(seperator,background,91);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_notificationTextField,background,105);
         MobileAlignmentUtil.alignAccordingToPositionOf(_shareButton,background,180 - (_shareButton.width >> 1),65);
      }
      
      public function updateWithNotificationInfo(param1:UserNotification) : void
      {
         _userNotification = param1;
         if(_requestAvatar && contains(_requestAvatar))
         {
            removeChild(_requestAvatar);
         }
         if(_userNotification is MobileUserNotification)
         {
            _requestAvatar = (_userNotification as MobileUserNotification).displayObject;
         }
         else
         {
            _requestAvatar = assetRepository.getDisplayObject(_userNotification.assetId);
         }
         addChild(_requestAvatar);
         _notificationTextField.text = _userNotification.text;
         _shareButton.visible = _userNotification.type == 3;
         drawLayout();
         show();
      }
      
      private function show() : void
      {
         this.alpha = 0;
         this.visible = true;
         _ongoingAnimation = true;
         TweenMax.to(this,0.75,{
            "onComplete":hide,
            "alpha":1,
            "repeat":1,
            "repeatDelay":4,
            "yoyo":true
         });
      }
      
      public function hide(param1:Boolean = false) : void
      {
         TweenMax.killTweensOf(this);
         _ongoingAnimation = false;
         TweenMax.to(this,param1 ? 0.01 : 0.75,{"autoAlpha":0});
         dispatchEvent(new MobileUserNotificationViewEvent("mobileUserNotificationViewEventCompleted"));
      }
      
      public function get userNotification() : UserNotification
      {
         return _userNotification;
      }
      
      public function get ongoingAnimation() : Boolean
      {
         return _ongoingAnimation;
      }
      
      public function get shareButton() : MobileWomButton
      {
         return _shareButton;
      }
   }
}

