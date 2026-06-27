package wom.view.screen.popups.passafriend
{
   import peak.component.mobile.MPTextField;
   import peak.display.View;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.game.Profile;
   import wom.model.game.experience.ExperienceUtil;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.getCaptionTextFormat;
   
   public class MobileAvatarWithArrowView extends Sprite implements View
   {
      
      public static const DOWN:int = 0;
      
      public static const UP:int = 1;
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _starIcon:DisplayObject;
      
      private var _levelTextField:MPTextField;
      
      private var arrow:DisplayObject;
      
      private var userNameTextField:MPTextField;
      
      private var _picture:DisplayObject;
      
      private var arrowDirection:int;
      
      private var username:String;
      
      private var profile:Profile;
      
      private var experiencePoints:Number;
      
      public function MobileAvatarWithArrowView(param1:int, param2:String, param3:Profile, param4:Number)
      {
         super();
         this.username = param2;
         this.profile = param3;
         this.arrowDirection = param1;
         this.experiencePoints = param4;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
         drawLayout();
      }
      
      public function initLayout() : void
      {
         _picture = assetRepository.getAvatarByProfile(profile);
         addChild(_picture);
         arrow = assetRepository.getDisplayObject(arrowDirection == 0 ? "IconPassFriendDown" : "IconPassFriendUp");
         addChild(arrow);
         userNameTextField = new MobileCaptionTextField();
         userNameTextField.width = _picture.width + 12;
         userNameTextField.textRendererProperties.textFormat = getCaptionTextFormat(21);
         userNameTextField.textRendererProperties.wordWrap = true;
         addChild(userNameTextField);
         _starIcon = assetRepository.getDisplayObject("IconLevelM");
         _starIcon.scaleX = _starIcon.scaleY = 35 / _starIcon.height;
         addChild(_starIcon);
         _levelTextField = new MPTextField();
         _levelTextField.textRendererProperties.textFormat = getCaptionTextFormat(27,"center");
         _levelTextField.width = _starIcon.width;
         addChild(_levelTextField);
      }
      
      public function drawLayout() : void
      {
         userNameTextField.width = _picture.width + 12;
         _levelTextField.width = _starIcon.width;
         _levelTextField.text = String(ExperienceUtil.calculateLevelOfExperience(experiencePoints));
         userNameTextField.text = username;
         MobileAlignmentUtil.alignBelowWithXMarginOf(_picture,arrow,arrow.width - _picture.width >> 1,5);
         MobileAlignmentUtil.alignBelowWithXMarginOf(userNameTextField,_picture,_picture.width - userNameTextField.width >> 1,2);
         MobileAlignmentUtil.alignAccordingToPositionOf(_starIcon,_picture,-11,-11);
         MobileAlignmentUtil.alignMiddleOf(_levelTextField,_starIcon);
         _levelTextField.x -= 3;
         _levelTextField.y += 5;
      }
      
      public function get picture() : DisplayObject
      {
         return _picture;
      }
      
      override public function get height() : Number
      {
         return arrow.height + 67 + userNameTextField.height + 5 + 2;
      }
   }
}

