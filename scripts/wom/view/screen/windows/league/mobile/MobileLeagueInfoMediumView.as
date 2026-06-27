package wom.view.screen.windows.league.mobile
{
   import peak.component.mobile.MPTextField;
   import peak.display.View;
   import peak.util.NumberUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.domain.domaininfoobject.LeagueLevelDIO;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.getCaptionTextFormat;
   
   public class MobileLeagueInfoMediumView extends Sprite implements View
   {
      
      public static const WIDTH:int = 200;
      
      public static const HEIGHT:int = 200;
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _leagueLevelDIO:LeagueLevelDIO;
      
      private var _displayDivision:Boolean;
      
      private var _leagueAsset:DisplayObject;
      
      private var _divisionTextField:MPTextField;
      
      public function MobileLeagueInfoMediumView(param1:LeagueLevelDIO, param2:Object = null)
      {
         super();
         _leagueLevelDIO = param1;
         _displayDivision = param2 != null ? Boolean(param2) : true;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         _leagueAsset = assetRepository.getDisplayObject(_leagueLevelDIO.assetIdMobileBig);
         addChild(_leagueAsset);
         if(_displayDivision)
         {
            _divisionTextField = new MobileCaptionTextField();
            _divisionTextField.textRendererProperties.textFormat = getCaptionTextFormat(27,"center");
            addChild(_divisionTextField);
            _divisionTextField.text = NumberUtil.toRoman(_leagueLevelDIO.division);
         }
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         if(_displayDivision)
         {
            _leagueAsset.x = 200 - _leagueAsset.width >> 1;
            _leagueAsset.y = 200 - _leagueAsset.height >> 1;
            _divisionTextField.x = 200 - _divisionTextField.width >> 1;
            _divisionTextField.y = _leagueLevelDIO.league == 2 || _leagueLevelDIO.league == 3 || _leagueLevelDIO.league == 4 ? 7 : (_leagueLevelDIO.league == 5 ? 6 : 9);
         }
      }
      
      public function get leagueAsset() : DisplayObject
      {
         return _leagueAsset;
      }
   }
}

