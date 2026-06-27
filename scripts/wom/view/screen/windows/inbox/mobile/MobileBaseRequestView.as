package wom.view.screen.windows.inbox.mobile
{
   import flash.utils.Dictionary;
   import peak.component.mobile.MPButton;
   import peak.component.mobile.MPTextField;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.game.Profile;
   import wom.model.game.friend.request.RequestInfo;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   
   public class MobileBaseRequestView extends Sprite implements View
   {
      
      public static const WIDTH:int = 971;
      
      public static const MIN_HEIGHT:int = 128;
      
      public static const MARGIN:int = 30;
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      protected var _requests:Vector.<RequestInfo>;
      
      private var _firstRequestProfile:Profile;
      
      protected var background:DisplayObject;
      
      protected var _avatars:Vector.<DisplayObject>;
      
      private var _friendNameTextField:MPTextField;
      
      protected var _titleTextField:MPTextField;
      
      protected var _otherFriendNamesTextField:MPTextField;
      
      private var _otherFriendProfiles:Dictionary;
      
      protected var _actionButton:MPButton;
      
      private var _closeButton:MPButton;
      
      public function MobileBaseRequestView(param1:Vector.<RequestInfo>)
      {
         super();
         _requests = param1;
         _firstRequestProfile = _requests[0].friendProfile;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         background = assetRepository.getDisplayObject("TransparentAsset");
         background.width = 971;
         background.height = 128;
         addChild(background);
         _friendNameTextField = new MobileCaptionTextField();
         _friendNameTextField.textRendererProperties.textFormat = getCaptionTextFormat(27);
         addChild(_friendNameTextField);
         _friendNameTextField.text = _firstRequestProfile.gameId != null ? _firstRequestProfile.gameId : (_firstRequestProfile.platformId != null ? _firstRequestProfile.platformId : _firstRequestProfile.avatar);
         _otherFriendNamesTextField = new MobileWomTextField();
         _otherFriendNamesTextField.textRendererProperties.textFormat = getWomTextFormat(21);
         _otherFriendNamesTextField.textRendererProperties.wordWrap = true;
         _otherFriendNamesTextField.width = 450;
         addChild(_otherFriendNamesTextField);
         _otherFriendNamesTextField.text = "";
         _otherFriendProfiles = new Dictionary();
         _avatars = new Vector.<DisplayObject>();
         loadImage(_firstRequestProfile);
         _actionButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Medium");
         var _temp_7:* = _actionButton;
         var _loc1_:String = "ui.windows.inbox.request.accept";
         _temp_7.label = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         _actionButton.width = 200;
         addChild(_actionButton);
         _closeButton = MobileWomUIComponentFactory.createMobileColoredButton("Red","Medium");
         _closeButton.label = "X";
         _closeButton.width = 67;
         addChild(_closeButton);
         _titleTextField = new MobileWomTextField();
         _titleTextField.textRendererProperties.textFormat = getWomTextFormat(21);
         _titleTextField.textRendererProperties.wordWrap = true;
         _titleTextField.width = 440;
         addChild(_titleTextField);
      }
      
      public function loadImage(param1:Profile) : void
      {
         var _loc2_:DisplayObject = assetRepository.getAvatarByProfile(param1);
         addChild(_loc2_);
         _avatars.push(_loc2_);
      }
      
      public function drawLayout() : void
      {
         var _loc5_:DisplayObject = null;
         var _loc4_:DisplayObject = null;
         var _loc6_:DisplayObject = null;
         var _loc2_:int = 0;
         var _loc7_:DisplayObject = null;
         var _loc1_:int = 0;
         var _loc3_:int = this.height;
         _otherFriendNamesTextField.visible = _avatars.length > 1;
         if(_avatars.length > 0)
         {
            MobileAlignmentUtil.alignAccordingToPositionOf(_avatars[0],background,30,26);
            if(_avatars.length > 1)
            {
               _loc5_ = _avatars[1];
               _loc5_.width = _loc5_.height = 35;
               MobileAlignmentUtil.alignBelowWithXMarginOf(_loc5_,_otherFriendNamesTextField,1,1);
               if(_avatars.length > 2)
               {
                  _loc4_ = null;
                  _loc6_ = _loc5_;
                  _loc2_ = 2;
                  while(_loc2_ < _avatars.length)
                  {
                     _loc4_ = _avatars[_loc2_];
                     _loc4_.width = _loc4_.height = 35;
                     if(_loc6_.x > 501)
                     {
                        MobileAlignmentUtil.alignBelowOf(_loc4_,_loc5_,2);
                        _loc5_ = _loc4_;
                     }
                     else
                     {
                        MobileAlignmentUtil.alignAccordingToPositionOf(_loc4_,_loc6_,37,0);
                     }
                     _loc6_ = _loc4_;
                     _loc2_++;
                  }
               }
            }
            MobileAlignmentUtil.alignAccordingToPositionOf(_actionButton,background,675,29);
            MobileAlignmentUtil.alignRightOf(_closeButton,_actionButton,8);
         }
         if(!_otherFriendNamesTextField.visible)
         {
            MobileAlignmentUtil.alignAccordingToPositionOf(_otherFriendNamesTextField,_titleTextField,0,0);
         }
         if(_avatars.length > 1)
         {
            _loc7_ = _avatars[_avatars.length - 1];
            _loc1_ = _loc7_.x + _loc7_.height + 30;
            background.height = _loc1_ > 128 ? _loc1_ : 128;
         }
         else
         {
            background.height = this.height > 128 ? this.height : 128;
         }
         if(this.height != _loc3_)
         {
            dispatchEventWith("requestsLayoutUpdated");
         }
      }
      
      protected function hideAllAvatars() : void
      {
         for each(var _loc1_ in _avatars)
         {
            _loc1_.visible = false;
         }
      }
      
      public function get requests() : Vector.<RequestInfo>
      {
         return _requests;
      }
      
      public function get actionButton() : MPButton
      {
         return _actionButton;
      }
      
      public function get closeButton() : MPButton
      {
         return _closeButton;
      }
      
      public function get otherFriendProfiles() : Dictionary
      {
         return _otherFriendProfiles;
      }
      
      public function updateFriendNameTextField(param1:String) : void
      {
         _friendNameTextField.text = param1;
         drawLayout();
      }
      
      public function get firstRequestProfile() : Profile
      {
         return _firstRequestProfile;
      }
      
      public function get friendNameTextField() : MPTextField
      {
         return _friendNameTextField;
      }
   }
}

