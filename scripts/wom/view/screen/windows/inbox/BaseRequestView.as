package wom.view.screen.windows.inbox
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.controller.event.inbox.InboxEvent;
   import wom.model.game.Profile;
   import wom.model.game.friend.request.RequestInfo;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.WomButton;
   import wom.view.component.button.colored.WomGreenSmallButton;
   import wom.view.util.LineUtil;
   
   public class BaseRequestView extends Sprite implements View
   {
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      protected var _requests:Vector.<RequestInfo>;
      
      private var _firstRequestProfile:Profile;
      
      protected var background:DisplayObject;
      
      protected var _avatars:Vector.<DisplayObject>;
      
      private var _friendNameTextField:TextField;
      
      protected var _titleTextField:TextField;
      
      protected var _otherFriendNamesTextField:TextField;
      
      private var _otherFriendProfiles:Dictionary;
      
      protected var _actionButton:WomButton;
      
      private var _closeButtonAsset:DisplayObject;
      
      public function BaseRequestView(param1:Vector.<RequestInfo>)
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
         background.width = 1;
         background.height = 1;
         addChild(background);
         _friendNameTextField = new CaptionTextField(WomTextFormats.GREEN_BUTTON_FILTER);
         _friendNameTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         _friendNameTextField.autoSize = "left";
         addChild(_friendNameTextField);
         _friendNameTextField.text = _firstRequestProfile.gameId != null ? _firstRequestProfile.gameId : (_firstRequestProfile.platformId != null ? _firstRequestProfile.platformId : _firstRequestProfile.avatar);
         _otherFriendNamesTextField = new WomTextField();
         _otherFriendNamesTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         _otherFriendNamesTextField.multiline = true;
         _otherFriendNamesTextField.wordWrap = true;
         _otherFriendNamesTextField.width = 450;
         _otherFriendNamesTextField.autoSize = "left";
         addChild(_otherFriendNamesTextField);
         _otherFriendNamesTextField.text = "";
         _otherFriendProfiles = new Dictionary();
         _avatars = new Vector.<DisplayObject>();
         loadImage(_firstRequestProfile);
         _actionButton = new WomGreenSmallButton();
         var _temp_7:* = _actionButton;
         var _loc1_:String = "ui.windows.inbox.request.accept";
         _temp_7.label = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         _actionButton.width = 124;
         addChild(_actionButton);
         _closeButtonAsset = assetRepository.getDisplayObject("InboxFullClose");
         addChild(_closeButtonAsset);
         _closeButtonAsset.visible = false;
         _titleTextField = new WomTextField();
         _titleTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         _titleTextField.multiline = true;
         _titleTextField.wordWrap = true;
         _titleTextField.width = 290;
         _titleTextField.autoSize = "left";
         addChild(_titleTextField);
      }
      
      public function loadImage(param1:Profile) : void
      {
         var _loc2_:DisplayObject = assetRepository.getAvatarByProfile(param1);
         addChild(_loc2_);
         _avatars.push(_loc2_);
         _loc2_.addEventListener("change",onAvatarChanged);
      }
      
      public function drawLayout() : void
      {
         var _loc4_:DisplayObject = null;
         var _loc3_:DisplayObject = null;
         var _loc5_:DisplayObject = null;
         var _loc1_:int = 0;
         var _loc2_:int = this.height;
         _otherFriendNamesTextField.visible = _requests.length > 1;
         if(_avatars.length > 0)
         {
            _avatars[0].width = _avatars[0].height = 50;
            AlignmentUtil.alignAccordingToPositionOf(_avatars[0],background,1,11);
            if(_avatars.length > 1)
            {
               _loc4_ = _avatars[1];
               _loc4_.width = _loc4_.height = 35;
               AlignmentUtil.alignBelowWithXMarginOf(_loc4_,_otherFriendNamesTextField,1,1);
               if(_avatars.length > 2)
               {
                  _loc3_ = null;
                  _loc5_ = _loc4_;
                  _loc1_ = 2;
                  while(_loc1_ < _avatars.length)
                  {
                     _loc3_ = _avatars[_loc1_];
                     _loc3_.width = _loc3_.height = 35;
                     if(_loc5_.x > 501)
                     {
                        AlignmentUtil.alignBelowOf(_loc3_,_loc4_,2);
                        _loc4_ = _loc3_;
                     }
                     else
                     {
                        AlignmentUtil.alignAccordingToPositionOf(_loc3_,_loc5_,37,0);
                     }
                     _loc5_ = _loc3_;
                     _loc1_++;
                  }
               }
            }
            AlignmentUtil.alignAccordingToPositionOf(_actionButton,_avatars[0],410,0);
            AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_closeButtonAsset,_actionButton,_actionButton.width + 5);
         }
         if(!_otherFriendNamesTextField.visible)
         {
            AlignmentUtil.alignAccordingToPositionOf(_otherFriendNamesTextField,_titleTextField,0,0);
         }
         background.width = this.width;
         background.height = this.height;
         if(this.height != _loc2_)
         {
            dispatchEvent(new InboxEvent("requestsLayoutUpdated"));
         }
      }
      
      protected function hideAllAvatars() : void
      {
         for each(var _loc1_ in _avatars)
         {
            _loc1_.visible = false;
         }
      }
      
      private function onAvatarChanged(param1:Event) : void
      {
         drawLayout();
      }
      
      public function get requests() : Vector.<RequestInfo>
      {
         return _requests;
      }
      
      public function get actionButton() : WomButton
      {
         return _actionButton;
      }
      
      public function drawLine() : void
      {
         LineUtil.drawHorizontalSeparatorLine(this,0,553,16310409);
      }
      
      public function get closeButtonAsset() : DisplayObject
      {
         return _closeButtonAsset;
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
      
      public function get friendNameTextField() : TextField
      {
         return _friendNameTextField;
      }
   }
}

