package wom.view.ui.mainframe.city
{
   import com.greensock.TweenLite;
   import feathers.controls.Label;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.i18n.lang.Languages;
   import peak.starling.FlatteningSprite;
   import peak.starling.InflatedBoundsImage;
   import peak.starling.InflatedBoundsSprite;
   import peak.util.MobileAlignmentUtil;
   import peak.util.NumberUtil;
   import starling.display.DisplayObject;
   import starling.display.Quad;
   import starling.display.Sprite;
   import wom.model.domain.domaininfoobject.LeagueLevelDIO;
   import wom.model.game.Profile;
   import wom.model.game.alliance.AllianceSummaryInfo;
   import wom.model.game.experience.ExperienceUtil;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.component.progressbar.MobileWomProgressBar;
   import wom.view.getCaptionTextFormat;
   
   public class MobileLandlordPanel extends Sprite implements View
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      protected var background:DisplayObject;
      
      protected var _playerContainer:InflatedBoundsSprite;
      
      protected var _levelIcon:DisplayObject;
      
      protected var _levelTextField:Label;
      
      protected var _userNameTextField:Label;
      
      protected var _experienceProgressBar:MobileWomProgressBar;
      
      protected var guidLabel:Label;
      
      protected var guidTextField:Label;
      
      private var _leagueSeparator1:Quad;
      
      private var _leagueSeparator2:Quad;
      
      private var _leagueIcon:InflatedBoundsImage;
      
      private var _divisionTextField:MobileCaptionTextField;
      
      protected var _scoreContainer:Sprite;
      
      protected var _scoreIcon:InflatedBoundsImage;
      
      protected var _scoreTextField:Label;
      
      protected var lastExperience:Number;
      
      protected var lastLevel:int;
      
      protected var targetExperience:Number;
      
      protected var _self:Boolean;
      
      protected var isNpc:Boolean;
      
      private var scoreBackground:DisplayObject;
      
      public function MobileLandlordPanel()
      {
         super();
         lastExperience = lastLevel = 0;
         isNpc = false;
      }
      
      public static function get visibleWidth() : int
      {
         return 89;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         _playerContainer = new InflatedBoundsSprite();
         _playerContainer.setPaddings(10,20,10,2);
         addChild(_playerContainer);
         background = assetRepository.getDisplayObject("BackgroundYellowPanel");
         background.width = 142;
         background.height = 45;
         _playerContainer.addChild(background);
         scoreBackground = assetRepository.getDisplayObject("BackgroundYellowPanel");
         scoreBackground.width = 137;
         scoreBackground.height = 45;
         addChild(scoreBackground);
         _scoreContainer = new Sprite();
         addChild(_scoreContainer);
         _leagueSeparator1 = new Quad(1,28,14469664);
         addChild(_leagueSeparator1);
         _leagueSeparator2 = new Quad(1,28,11830531);
         addChild(_leagueSeparator2);
         _experienceProgressBar = MobileWomUIComponentFactory.createProgressBar("Experience");
         _experienceProgressBar.width = 126;
         _experienceProgressBar.minimum = 0;
         _experienceProgressBar.maximum = 0;
         _experienceProgressBar.value = 0;
         _playerContainer.addChild(_experienceProgressBar);
         _levelIcon = assetRepository.getDisplayObject("IconLevelM");
         _playerContainer.addChild(_levelIcon);
         _levelTextField = new MobileCaptionTextField();
         _levelTextField.textRendererProperties.textFormat = getCaptionTextFormat(33);
         _playerContainer.addChild(_levelTextField);
         _userNameTextField = new MobileCaptionTextField();
         _userNameTextField.textRendererProperties.textFormat = getCaptionTextFormat(21);
         _userNameTextField.text = "User Name";
         _playerContainer.addChild(_userNameTextField);
         guidLabel = new MobileCaptionTextField();
         guidLabel.textRendererProperties.textFormat = getCaptionTextFormat(21);
         addChild(guidLabel);
         var _temp_12:* = guidLabel;
         var _loc1_:String = "ui.mainframe.visit.id";
         _temp_12.text = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         guidTextField = new MobileCaptionTextField();
         guidTextField.textRendererProperties.textFormat = getCaptionTextFormat(21);
         addChild(guidTextField);
         _scoreIcon = assetRepository.getDisplayObject("IconBPM") as InflatedBoundsImage;
         _scoreIcon.setPaddings(0,68,2,10);
         _scoreContainer.addChild(_scoreIcon);
         _scoreTextField = new MobileCaptionTextField();
         _scoreTextField.textRendererProperties.textFormat = getCaptionTextFormat(21);
         _scoreTextField.text = "0";
         _scoreTextField.touchable = false;
         _scoreContainer.addChild(_scoreTextField);
         _leagueIcon = assetRepository.getDisplayObject("League0Icon") as InflatedBoundsImage;
         _leagueIcon.scaleX = _leagueIcon.scaleY = 1.5;
         _leagueIcon.visible = false;
         _leagueIcon.setPaddings(10,20,10,20);
         addChild(_leagueIcon);
         _divisionTextField = new MobileCaptionTextField();
         _divisionTextField.textRendererProperties.textFormat = getCaptionTextFormat(21,"center");
         addChild(_divisionTextField);
         _divisionTextField.text = NumberUtil.toRoman(0);
      }
      
      public function drawLayout() : void
      {
         _userNameTextField.validate();
         MobileAlignmentUtil.alignAccordingToPositionOf(_levelIcon,background,-22,-4);
         MobileAlignmentUtil.alignAccordingToPositionOf(_levelTextField,_levelIcon,(_levelIcon.width - _levelTextField.width >> 1) - 3,(_levelIcon.height - _levelTextField.height >> 1) + 5);
         MobileAlignmentUtil.alignAccordingToPositionOf(_leagueSeparator1,scoreBackground,94,7);
         MobileAlignmentUtil.alignRightOf(_leagueSeparator2,_leagueSeparator1,0);
         if(_leagueIcon.visible)
         {
            MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_leagueIcon,scoreBackground,115 - (_leagueIcon.width >> 1));
            MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_divisionTextField,_leagueIcon,0);
         }
         MobileAlignmentUtil.alignRightWithYMarginOf(_userNameTextField,_levelIcon,17,3);
         if(!_levelIcon.visible)
         {
            MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_userNameTextField,background,13);
         }
         MobileAlignmentUtil.alignAccordingToPositionOf(_experienceProgressBar,background,8,8);
         if(Languages.activeLanguageId == "ar")
         {
            MobileAlignmentUtil.alignAccordingToPositionOf(guidLabel,background,35,isNpc ? 60 : 105);
            MobileAlignmentUtil.alignBelowOf(guidTextField,guidLabel,0);
         }
         else
         {
            MobileAlignmentUtil.alignAccordingToPositionOf(guidLabel,background,-18,isNpc ? 60 : 105);
            MobileAlignmentUtil.alignRightOf(guidTextField,guidLabel,0);
         }
         MobileAlignmentUtil.alignAccordingToPositionOf(scoreBackground,background,0,50);
         MobileAlignmentUtil.alignAccordingToPositionOf(_scoreContainer,scoreBackground,-22,0);
         _scoreIcon.y = 1;
         MobileAlignmentUtil.alignAccordingToPositionOf(_scoreTextField,_scoreIcon,1 + _scoreIcon.width,12);
      }
      
      public function updateUser(param1:Profile, param2:String, param3:Number = NaN, param4:Boolean = false) : void
      {
         unflattenParent();
         isNpc = param1.isNpc;
         _self = param4;
         _experienceProgressBar.visible = param4;
         if(param2)
         {
            if(param1.platformId != null || param1.npcClan)
            {
               _userNameTextField.textRendererProperties.textFormat = getCaptionTextFormat(21);
               _userNameTextField.text = param2;
            }
            else if(param1.mobileName)
            {
               _userNameTextField.textRendererProperties.textFormat = getCaptionTextFormat(21);
               _userNameTextField.text = param1.mobileName;
            }
            else
            {
               _userNameTextField.textRendererProperties.textFormat = getCaptionTextFormat(19);
               _userNameTextField.text = "Guest" + param1.gameId.substr(param1.gameId.length - 7);
            }
         }
         if(!isNaN(param3))
         {
            guidTextField.text = param3.toString();
            guidLabel.visible = true;
            guidTextField.visible = true;
         }
         else
         {
            guidLabel.visible = false;
            guidTextField.visible = false;
         }
         _levelIcon.visible = _levelTextField.visible = _scoreIcon.visible = _scoreTextField.visible = !param1.isNpc;
         _leagueIcon.visible = _divisionTextField.visible = _scoreContainer.visible = scoreBackground.visible = _leagueSeparator1.visible = _leagueSeparator2.visible = !isNpc;
         drawLayout();
         flattenParent();
      }
      
      private function unflattenParent() : void
      {
         if(parent is FlatteningSprite && parent.stage)
         {
            (parent as FlatteningSprite).unflatten();
         }
      }
      
      private function flattenParent() : void
      {
         if(parent is FlatteningSprite && parent.stage)
         {
            (parent as FlatteningSprite).flatten();
         }
      }
      
      public function updateWithLevel(param1:int) : void
      {
         unflattenParent();
         _levelTextField.text = param1 + "";
         drawLayout();
         flattenParent();
      }
      
      public function updateWithExperience(param1:Number) : void
      {
         unflattenParent();
         if(!_experienceProgressBar.visible)
         {
            return;
         }
         if(lastExperience == 0)
         {
            lastExperience = param1;
            lastLevel = ExperienceUtil.calculateLevelOfExperience(param1);
            _experienceProgressBar.minimum = ExperienceUtil.calculateExperienceOfLevel(lastLevel);
            _experienceProgressBar.maximum = ExperienceUtil.calculateExperienceOfLevel(lastLevel + 1);
            _experienceProgressBar.value = lastExperience;
            _levelTextField.text = lastLevel + "";
            drawLayout();
            flattenParent();
         }
         else
         {
            TweenLite.killTweensOf(_experienceProgressBar);
            targetExperience = param1;
            startTween();
         }
      }
      
      public function updateWithBattlePoints(param1:int) : void
      {
         unflattenParent();
         _scoreTextField.text = param1 + "";
         flattenParent();
      }
      
      public function updateWithAlliance(param1:AllianceSummaryInfo) : void
      {
         drawLayout();
      }
      
      public function updateWithLeague(param1:LeagueLevelDIO) : void
      {
         unflattenParent();
         if(contains(_leagueIcon))
         {
            removeChild(_leagueIcon);
         }
         _leagueIcon = assetRepository.getDisplayObject(param1.assetIdMobileSmall) as InflatedBoundsImage;
         _leagueIcon.visible = !isNpc;
         _leagueIcon.setPaddings(4,20,10,20);
         addChildAt(_leagueIcon,getChildIndex(_divisionTextField) - 1);
         _divisionTextField.text = NumberUtil.toRoman(param1.division);
         drawLayout();
         flattenParent();
      }
      
      public function get scoreIcon() : DisplayObject
      {
         return _scoreIcon;
      }
      
      public function get self() : Boolean
      {
         return _self;
      }
      
      public function get levelIcon() : DisplayObject
      {
         return _levelIcon;
      }
      
      public function get levelTextField() : Label
      {
         return _levelTextField;
      }
      
      public function get playerContainer() : Sprite
      {
         return _playerContainer;
      }
      
      private function startTween() : void
      {
         var _loc1_:int = 0;
         lastExperience = _experienceProgressBar.value;
         if(lastExperience < targetExperience)
         {
            _loc1_ = ExperienceUtil.calculateLevelOfExperience(targetExperience);
            if(_loc1_ == lastLevel)
            {
               TweenLite.to(_experienceProgressBar,0.1,{
                  "value":targetExperience,
                  "onComplete":startTween
               });
            }
            else if(_experienceProgressBar.value == _experienceProgressBar.maximum)
            {
               lastLevel += 1;
               _experienceProgressBar.minimum = ExperienceUtil.calculateExperienceOfLevel(lastLevel);
               _experienceProgressBar.maximum = ExperienceUtil.calculateExperienceOfLevel(lastLevel + 1);
               _levelTextField.text = lastLevel + "";
               drawLayout();
               startTween();
            }
            else
            {
               TweenLite.to(_experienceProgressBar,0.1,{
                  "value":_experienceProgressBar.maximum,
                  "onComplete":startTween
               });
            }
         }
         else
         {
            flattenParent();
         }
      }
      
      public function get leagueIcon() : DisplayObject
      {
         return _leagueIcon;
      }
      
      public function get divisionTextField() : MobileCaptionTextField
      {
         return _divisionTextField;
      }
   }
}

