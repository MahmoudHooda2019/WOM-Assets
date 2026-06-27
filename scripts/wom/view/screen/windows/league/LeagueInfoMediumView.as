package wom.view.screen.windows.league
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import peak.display.View;
   import peak.util.NumberUtil;
   import wom.model.domain.domaininfoobject.LeagueLevelDIO;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextFormats;
   
   public class LeagueInfoMediumView extends Sprite implements View
   {
      
      public static const WIDTH:int = 149;
      
      public static const HEIGHT:int = 147;
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      private var _leagueLevelDIO:LeagueLevelDIO;
      
      private var _displayDivision:Boolean;
      
      private var _leagueAsset:DisplayObject;
      
      private var _divisionTextField:TextField;
      
      public function LeagueInfoMediumView(param1:LeagueLevelDIO, param2:Object = null)
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
         _leagueAsset = assetRepository.getDisplayObject(_leagueLevelDIO.assetIdMedium);
         addChild(_leagueAsset);
         if(_displayDivision)
         {
            _divisionTextField = new CaptionTextField(WomTextFormats.BLACK_FILTER_SOFT);
            _divisionTextField.defaultTextFormat = WomTextFormats.CENTER_28;
            _divisionTextField.autoSize = "center";
            _divisionTextField.text = NumberUtil.toRoman(_leagueLevelDIO.division);
            addChild(_divisionTextField);
         }
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         _leagueAsset.x = 149 - _leagueAsset.width >> 1;
         _leagueAsset.y = 147 - _leagueAsset.height >> 1;
         if(_displayDivision)
         {
            _divisionTextField.x = 149 - _divisionTextField.width >> 1;
            _divisionTextField.y = _leagueLevelDIO.league == 2 || _leagueLevelDIO.league == 3 || _leagueLevelDIO.league == 4 ? 7 : (_leagueLevelDIO.league == 5 ? 6 : 9);
         }
      }
      
      public function get leagueAsset() : DisplayObject
      {
         return _leagueAsset;
      }
   }
}

