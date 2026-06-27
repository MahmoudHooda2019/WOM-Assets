package wom.view.ui.mainframe.city.friends.mobile
{
   import com.greensock.TweenMax;
   import feathers.controls.renderers.IListItemRenderer;
   import peak.component.mobile.MPButton;
   import peak.component.mobile.MPItemRenderer;
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.events.Event;
   import wom.model.dto.FriendWatchPostInfo;
   import wom.model.game.experience.ExperienceUtil;
   import wom.model.game.friend.FriendInfo;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.button.MobileReinforceButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   import wom.view.screen.windows.alliance.coa.mobile.MobileCoatOfArmsView;
   
   public class FriendsPanelFriendViewRenderer extends MPItemRenderer implements IListItemRenderer
   {
      
      public static const WIDTH:int = 798;
      
      public static const HEIGHT:int = 96;
      
      public static const EVENT_GIFT:String = "giftButtonClicked";
      
      public static const EVENT_VISIT:String = "visitButtonClicked";
      
      private var _friendInfo:FriendInfo;
      
      private var _friendWatchPostInfo:FriendWatchPostInfo;
      
      private var _friendWatchPostCapacitiesPerLevel:Vector.<int>;
      
      private var _assetRepository:MobileWomAssetRepository;
      
      private var _background:DisplayObject;
      
      private var _avatar:DisplayObject;
      
      private var _starIcon:DisplayObject;
      
      private var _levelTextField:MPTextField;
      
      private var _allianceCoatOfArmsView:MobileCoatOfArmsView;
      
      private var _nameTextField:MPTextField;
      
      private var _visitButton:MPButton;
      
      private var _supportButton:MobileReinforceButton;
      
      private var _rendererData:Object;
      
      private var _highlightArrow:DisplayObject;
      
      public function FriendsPanelFriendViewRenderer(param1:MobileWomAssetRepository)
      {
         super();
         _assetRepository = param1;
         _background = param1.getDisplayObject("MobileBeigeBackground");
         _background.width = 798;
         _background.height = 96;
         addChild(_background);
         _starIcon = param1.getDisplayObject("IconLevelM");
         _starIcon.scaleX = _starIcon.scaleY = 35 / _starIcon.height;
         addChild(_starIcon);
         _levelTextField = new MPTextField();
         _levelTextField.textRendererProperties.textFormat = getCaptionTextFormat(27,"center");
         _levelTextField.width = _starIcon.width;
         addChild(_levelTextField);
         _allianceCoatOfArmsView = new MobileCoatOfArmsView(_assetRepository);
         _allianceCoatOfArmsView.scaleX = _allianceCoatOfArmsView.scaleY = 0.42;
         addChild(_allianceCoatOfArmsView);
         _nameTextField = new MobileCaptionTextField();
         _nameTextField.textRendererProperties.textFormat = getCaptionTextFormat(23);
         _nameTextField.width = 330;
         addChild(_nameTextField);
         _supportButton = new MobileReinforceButton(MobileReinforceButton.TYPE_SUPPORT,"Blue");
         addChild(_supportButton);
         _visitButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Medium");
         var _temp_10:* = _visitButton;
         var _loc3_:String = "ui.mainframe.city.friend.visit";
         _temp_10.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         _visitButton.width = 115;
         _visitButton.addEventListener("triggered",onVisitButtonClicked);
         addChild(_visitButton);
         drawLayout();
      }
      
      override public function get data() : Object
      {
         return _rendererData;
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc2_:Boolean = false;
         if(param1)
         {
            _rendererData = param1;
            _friendInfo = param1.friendInfo;
            _loc2_ = _friendInfo.profile.isNpc;
            if(_avatar && contains(_avatar))
            {
               removeChild(_avatar);
               _avatar = null;
            }
            _avatar = _loc2_ ? _assetRepository.getDisplayObject("ThorzainPortrait") : _assetRepository.getAvatarByProfile(_friendInfo.profile);
            addChildAt(_avatar,1);
            if(_friendInfo.coaInfo != null)
            {
               _allianceCoatOfArmsView.updateWithCoatOfArmsInfo(_friendInfo.coaInfo);
            }
            _levelTextField.text = _loc2_ ? "35" : String(ExperienceUtil.calculateLevelOfExperience(_friendInfo.experiencePoints));
            _nameTextField.text = _loc2_ ? "Thorzain" : _friendInfo.name;
            if(_loc2_)
            {
               _supportButton.visible = false;
            }
            _friendWatchPostInfo = param1.friendWatchPostInfo as FriendWatchPostInfo;
            _friendWatchPostCapacitiesPerLevel = param1.friendWatchPostCapacitiesPerLevel as Vector.<int>;
            updateFriendWatchPostData();
            if(_highlightArrow && contains(_highlightArrow))
            {
               TweenMax.killTweensOf(_highlightArrow);
               removeChild(_highlightArrow);
               _highlightArrow = null;
            }
            if(param1.highlightThorzain)
            {
               _highlightArrow = _assetRepository.getDisplayObject("TutorialArrowLeftRightM");
               _highlightArrow.scaleX = -1;
               addChild(_highlightArrow);
               TweenMax.to(_highlightArrow,0.55,{
                  "x":"-25",
                  "repeat":-1,
                  "yoyo":true,
                  "overwrite":1
               });
            }
         }
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         if(_avatar)
         {
            MobileAlignmentUtil.alignAccordingToPositionOf(_avatar,_background,11,13);
         }
         MobileAlignmentUtil.alignAccordingToPositionOf(_starIcon,_background,3,0);
         MobileAlignmentUtil.alignMiddleOf(_levelTextField,_starIcon);
         _levelTextField.x -= 3;
         _levelTextField.y += 5;
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_allianceCoatOfArmsView,_background,93);
         MobileAlignmentUtil.alignAccordingToPositionOf(_nameTextField,_background,175,25);
         _supportButton.validate();
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_supportButton,_background,521);
         MobileAlignmentUtil.alignRightOf(_visitButton,_supportButton,9);
         if(_highlightArrow)
         {
            MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_highlightArrow,_visitButton,0);
         }
      }
      
      public function updateFriendWatchPostData() : void
      {
         if(!_supportButton)
         {
            return;
         }
         if(_friendWatchPostInfo)
         {
            _supportButton.isEnabled = _friendWatchPostInfo.availableCapacity > 0;
            _supportButton.maximum = _friendWatchPostInfo.level == 0 ? 1 : _friendWatchPostCapacitiesPerLevel[_friendWatchPostInfo.level - 1];
            _supportButton.value = _friendWatchPostInfo.level == 0 ? 0 : _friendWatchPostCapacitiesPerLevel[_friendWatchPostInfo.level - 1] - _friendWatchPostInfo.availableCapacity;
         }
         else
         {
            _supportButton.isEnabled = false;
         }
      }
      
      public function get friendInfo() : FriendInfo
      {
         return _friendInfo;
      }
      
      public function updateUserNameTextField(param1:String) : void
      {
         if(param1 != _nameTextField.text)
         {
            _nameTextField.text = param1;
         }
      }
      
      private function onVisitButtonClicked(param1:Event) : void
      {
         if(_friendInfo)
         {
            dispatchEventWith("visitButtonClicked",true,_friendInfo.profile);
         }
      }
      
      public function get supportButton() : MobileReinforceButton
      {
         return _supportButton;
      }
   }
}

