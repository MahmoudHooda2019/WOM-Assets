package wom.view.screen.windows.league
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import peak.util.NumberUtil;
   import wom.model.domain.domaininfoobject.LeagueLevelDIO;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   
   public class LeagueInfoSmallView extends Sprite implements View
   {
      
      private static const WIDTH:int = 68;
      
      private static const HEIGHT:int = 67;
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      private var _leagueLevelDIO:LeagueLevelDIO;
      
      private var _leagueAssetOnly:Boolean;
      
      private var _displayDivision:Boolean;
      
      private var _explainDivisions:Boolean;
      
      private var _leagueAsset:DisplayObject;
      
      private var _divisionTextField:TextField;
      
      private var _explainDivisionsBackground:Sprite;
      
      private var _explainDivisionsTextFields:Vector.<TextField>;
      
      private var _leagueNameTextField:TextField;
      
      private var _minBPToJoinContainer:Sprite;
      
      private var _minBPToJoinIcon:DisplayObject;
      
      private var _minBPToJoinTextField:TextField;
      
      public function LeagueInfoSmallView(param1:LeagueLevelDIO, param2:Object = null, param3:Object = null, param4:Object = null)
      {
         super();
         _leagueLevelDIO = param1;
         _leagueAssetOnly = param2 != null ? Boolean(param2) : false;
         _displayDivision = param3 != null ? Boolean(param3) : false;
         _explainDivisions = param4 != null ? Boolean(param4) : false;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         var _loc1_:TextField = null;
         var _loc2_:int = 0;
         _leagueAsset = assetRepository.getDisplayObject(_leagueLevelDIO.assetIdSmall);
         addChild(_leagueAsset);
         if(_explainDivisions)
         {
            _explainDivisionsBackground = new Sprite();
            addChild(_explainDivisionsBackground);
            _explainDivisionsBackground.graphics.lineStyle(1,0,1);
            _explainDivisionsBackground.graphics.moveTo(0,3);
            _explainDivisionsBackground.graphics.lineTo(54,3);
            _explainDivisionsBackground.graphics.moveTo(1,0);
            _explainDivisionsBackground.graphics.lineTo(1,3);
            _explainDivisionsBackground.graphics.moveTo(18,0);
            _explainDivisionsBackground.graphics.lineTo(18,3);
            _explainDivisionsBackground.graphics.moveTo(36,0);
            _explainDivisionsBackground.graphics.lineTo(36,3);
            _explainDivisionsBackground.graphics.moveTo(53,0);
            _explainDivisionsBackground.graphics.lineTo(53,3);
            _explainDivisionsBackground.graphics.moveTo(27,4);
            _explainDivisionsBackground.graphics.lineTo(27,17);
            _explainDivisionsTextFields = new Vector.<TextField>();
            _loc2_ = 1;
            while(_loc2_ <= 3)
            {
               _loc1_ = new WomTextField();
               _loc1_.defaultTextFormat = WomTextFormats.FONT_SIZE_14;
               _loc1_.autoSize = "left";
               _loc1_.text = NumberUtil.toRoman(_loc2_);
               addChild(_loc1_);
               _explainDivisionsTextFields.push(_loc1_);
               _loc2_++;
            }
         }
         if(_displayDivision)
         {
            _divisionTextField = new CaptionTextField(WomTextFormats.BLACK_FILTER_SOFT);
            _divisionTextField.defaultTextFormat = WomTextFormats.CENTER_14;
            _divisionTextField.autoSize = "center";
            _divisionTextField.text = NumberUtil.toRoman(_leagueLevelDIO.division);
            addChild(_divisionTextField);
         }
         if(!_leagueAssetOnly)
         {
            _leagueNameTextField = new CaptionTextField(WomTextFormats.GREEN_BUTTON_FILTER);
            _leagueNameTextField.defaultTextFormat = WomTextFormats.CENTER_18;
            _leagueNameTextField.multiline = true;
            _leagueNameTextField.wordWrap = true;
            _leagueNameTextField.autoSize = "center";
            _leagueNameTextField.width = 120;
            addChild(_leagueNameTextField);
            var _temp_6:* = _leagueNameTextField;
            var _loc3_:String = "domain.league.leagues." + _leagueLevelDIO.league + ".name";
            _temp_6.text = peak.i18n.PText.INSTANCE.getText0(_loc3_);
            _minBPToJoinContainer = new Sprite();
            addChild(_minBPToJoinContainer);
            _minBPToJoinIcon = assetRepository.getDisplayObject("CrownIcon");
            _minBPToJoinContainer.addChild(_minBPToJoinIcon);
            _minBPToJoinTextField = new CaptionTextField(WomTextFormats.RED_BUTTON_FILTER);
            _minBPToJoinTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
            _minBPToJoinTextField.autoSize = "left";
            _minBPToJoinTextField.text = _leagueLevelDIO.minBPToJoin + "+";
            _minBPToJoinContainer.addChild(_minBPToJoinTextField);
         }
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         _leagueAsset.x = 68 - _leagueAsset.width >> 1;
         _leagueAsset.y = 67 - _leagueAsset.height >> 1;
         if(_displayDivision)
         {
            _divisionTextField.x = 68 - _divisionTextField.width >> 1;
            _divisionTextField.y = _leagueLevelDIO.league == 4 || _leagueLevelDIO.league == 5 ? 0 : 2;
         }
         if(_explainDivisions)
         {
            _explainDivisionsBackground.x = 68 - _explainDivisionsBackground.width >> 1;
            _explainDivisionsBackground.y = -10;
            _explainDivisionsTextFields[1].x = 68 - _explainDivisionsTextFields[1].width >> 1;
            _explainDivisionsTextFields[1].y = -5 - _explainDivisionsTextFields[1].height;
            AlignmentUtil.alignLeftOf(_explainDivisionsTextFields[0],_explainDivisionsTextFields[1],7);
            AlignmentUtil.alignRightOf(_explainDivisionsTextFields[2],_explainDivisionsTextFields[1],7);
         }
         if(!_leagueAssetOnly)
         {
            _leagueNameTextField.x = 68 - _leagueNameTextField.width >> 1;
            _leagueNameTextField.y = 67;
            AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_minBPToJoinContainer,_leagueNameTextField,_leagueNameTextField.height);
            AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_minBPToJoinTextField,_minBPToJoinIcon,_minBPToJoinIcon.width);
         }
      }
      
      public function get leagueAssetOnly() : Boolean
      {
         return _leagueAssetOnly;
      }
      
      public function get leagueAsset() : DisplayObject
      {
         return _leagueAsset;
      }
      
      public function get minBPToJoinIcon() : DisplayObject
      {
         return _minBPToJoinIcon;
      }
   }
}

