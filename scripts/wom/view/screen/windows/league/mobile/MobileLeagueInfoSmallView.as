package wom.view.screen.windows.league.mobile
{
   import peak.component.mobile.MPTextField;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import peak.util.NumberUtil;
   import starling.display.DisplayObject;
   import starling.display.Shape;
   import starling.display.Sprite;
   import wom.model.domain.domaininfoobject.LeagueLevelDIO;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileWomTextField;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   
   public class MobileLeagueInfoSmallView extends Sprite implements View
   {
      
      private static const WIDTH:int = 100;
      
      private static const HEIGHT:int = 98;
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _leagueLevelDIO:LeagueLevelDIO;
      
      private var _leagueAssetOnly:Boolean;
      
      private var _displayDivision:Boolean;
      
      private var _explainDivisions:Boolean;
      
      private var _leagueAsset:DisplayObject;
      
      private var _divisionTextField:MPTextField;
      
      private var _explainDivisionsBackground:Shape;
      
      private var _explainDivisionsTextFields:Vector.<MPTextField>;
      
      private var _leagueNameTextField:MPTextField;
      
      private var _minBPToJoinContainer:Sprite;
      
      private var _minBPToJoinIcon:DisplayObject;
      
      private var _minBPToJoinTextField:MPTextField;
      
      public function MobileLeagueInfoSmallView(param1:LeagueLevelDIO, param2:Object = null, param3:Object = null, param4:Object = null)
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
         var _loc1_:MPTextField = null;
         var _loc2_:int = 0;
         _leagueAsset = assetRepository.getDisplayObject(_leagueLevelDIO.assetIdMobileBig);
         addChild(_leagueAsset);
         if(_explainDivisions)
         {
            _explainDivisionsBackground = new Shape();
            _explainDivisionsBackground.graphics.lineStyle(1,0,1);
            _explainDivisionsBackground.graphics.moveTo(0,4);
            _explainDivisionsBackground.graphics.lineTo(61,4);
            _explainDivisionsBackground.graphics.moveTo(1,0);
            _explainDivisionsBackground.graphics.lineTo(1,4);
            _explainDivisionsBackground.graphics.moveTo(21,0);
            _explainDivisionsBackground.graphics.lineTo(21,4);
            _explainDivisionsBackground.graphics.moveTo(41,0);
            _explainDivisionsBackground.graphics.lineTo(41,4);
            _explainDivisionsBackground.graphics.moveTo(61,0);
            _explainDivisionsBackground.graphics.lineTo(61,4);
            _explainDivisionsBackground.graphics.moveTo(30,4);
            _explainDivisionsBackground.graphics.lineTo(30,16);
            addChild(_explainDivisionsBackground);
            _explainDivisionsTextFields = new Vector.<MPTextField>();
            _loc2_ = 1;
            while(_loc2_ <= 3)
            {
               _loc1_ = new MobileWomTextField();
               _loc1_.textRendererProperties.textFormat = getWomTextFormat(21,"center");
               _loc1_.width = 20;
               _loc1_.text = NumberUtil.toRoman(_loc2_);
               addChild(_loc1_);
               _explainDivisionsTextFields.push(_loc1_);
               _loc2_++;
            }
         }
         if(_displayDivision)
         {
            _divisionTextField = new MobileWomTextField();
            _divisionTextField.textRendererProperties.textFormat = getCaptionTextFormat(21,"center");
            _divisionTextField.text = NumberUtil.toRoman(_leagueLevelDIO.division);
            addChild(_divisionTextField);
         }
         if(!_leagueAssetOnly)
         {
            _leagueNameTextField = new MobileWomTextField();
            _leagueNameTextField.textRendererProperties.textFormat = getCaptionTextFormat(33);
            addChild(_leagueNameTextField);
            var _temp_6:* = _leagueNameTextField;
            var _loc3_:String = "domain.league.leagues." + _leagueLevelDIO.league + ".name";
            _temp_6.text = peak.i18n.PText.INSTANCE.getText0(_loc3_);
            _minBPToJoinContainer = new Sprite();
            addChild(_minBPToJoinContainer);
            _minBPToJoinIcon = assetRepository.getDisplayObject("IconBPS");
            _minBPToJoinContainer.addChild(_minBPToJoinIcon);
            _minBPToJoinTextField = new MobileWomTextField();
            _minBPToJoinTextField.textRendererProperties.textFormat = getCaptionTextFormat(21);
            _minBPToJoinTextField.text = _leagueLevelDIO.minBPToJoin + "+";
            _minBPToJoinContainer.addChild(_minBPToJoinTextField);
         }
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         _leagueAsset.x = 100 - _leagueAsset.width >> 1;
         _leagueAsset.y = 98 - _leagueAsset.height >> 1;
         if(_displayDivision)
         {
            _divisionTextField.validate();
            MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_divisionTextField,_leagueAsset,9);
            _divisionTextField.x -= 1;
         }
         if(_explainDivisions)
         {
            _explainDivisionsBackground.x = (100 - _explainDivisionsBackground.width >> 1) + 1;
            _explainDivisionsBackground.y = -15;
            _explainDivisionsTextFields[1].validate();
            MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_explainDivisionsTextFields[1],_explainDivisionsBackground,4 - _explainDivisionsTextFields[1].height);
            MobileAlignmentUtil.alignLeftOf(_explainDivisionsTextFields[0],_explainDivisionsTextFields[1],0);
            MobileAlignmentUtil.alignRightOf(_explainDivisionsTextFields[2],_explainDivisionsTextFields[1],0);
         }
         if(!_leagueAssetOnly)
         {
            _leagueNameTextField.validate();
            _minBPToJoinTextField.validate();
            _leagueNameTextField.x = 100 - _leagueNameTextField.width >> 1;
            _leagueNameTextField.y = 98;
            MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_minBPToJoinTextField,_minBPToJoinIcon,_minBPToJoinIcon.width);
            MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_minBPToJoinTextField,_minBPToJoinIcon,27);
            _minBPToJoinTextField.y += 3;
            MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_minBPToJoinContainer,_leagueNameTextField,_leagueNameTextField.height - 5);
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

