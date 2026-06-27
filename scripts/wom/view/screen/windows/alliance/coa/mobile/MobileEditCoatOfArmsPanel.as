package wom.view.screen.windows.alliance.coa.mobile
{
   import feathers.data.ListCollection;
   import feathers.layout.TiledColumnsLayout;
   import peak.component.mobile.MPList;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.game.alliance.coa.CoatOfArmsInfo;
   import wom.model.game.alliance.coa.VanityColorType;
   import wom.model.resource.MobileWomAssetRepository;
   
   public class MobileEditCoatOfArmsPanel extends Sprite
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var coaBackground:DisplayObject;
      
      private var patternListBackground:DisplayObject;
      
      private var allianceCOA:MobileCoatOfArmsView;
      
      private var _firstColorSelector:MobileVanityColorSelectorView;
      
      private var _secondColorSelector:MobileVanityColorSelectorView;
      
      private var _patternSelectorList:MPList;
      
      private var patternListData:Vector.<Object>;
      
      private var _selectedPatternId:int;
      
      private const DEFAULT_SELECTED_PATTERN_ID:int = 1;
      
      private const PATTERN_COUNT:int = 12;
      
      public function MobileEditCoatOfArmsPanel()
      {
         super();
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      private function initLayout() : void
      {
         coaBackground = createAndAddDisplayObject("MobileBeigeBackground",230,223);
         patternListBackground = createAndAddDisplayObject("MobileBeigeBackground",711,107);
         patternListData = new Vector.<Object>();
         createPatternViews();
         allianceCOA = new MobileCoatOfArmsView(assetRepository);
         addChild(allianceCOA);
         _secondColorSelector = new MobileVanityColorSelectorView(2);
         addChild(_secondColorSelector);
         _firstColorSelector = new MobileVanityColorSelectorView(1);
         addChild(_firstColorSelector);
         _firstColorSelector.selectColor(VanityColorType.DEFAULT);
         _secondColorSelector.selectColor(VanityColorType.DEFAULT_2);
         drawLayout();
         updateCOAAccordingToSelections();
      }
      
      private function createPatternViews() : void
      {
         var _loc2_:int = 0;
         var _loc1_:TiledColumnsLayout = new TiledColumnsLayout();
         _loc1_.horizontalGap = 0;
         _loc1_.verticalGap = 0;
         _loc1_.useSquareTiles = false;
         _loc1_.paddingBottom = 0;
         _loc1_.tileHorizontalAlign = "left";
         _patternSelectorList = new MPList();
         _patternSelectorList.itemRendererFactory = patternSelectionRendererFactory;
         _patternSelectorList.x = 265;
         _patternSelectorList.y = 203;
         _patternSelectorList.horizontalScrollPolicy = "on";
         _patternSelectorList.verticalScrollPolicy = "off";
         _patternSelectorList.layout = _loc1_;
         _patternSelectorList.height = 92;
         _patternSelectorList.width = 681;
         _patternSelectorList.allowMultipleSelection = false;
         addChild(_patternSelectorList);
         _loc2_ = 0;
         while(_loc2_ < 12)
         {
            patternListData.push({
               "patternId":_loc2_ + 1,
               "selected":false
            });
            _loc2_++;
         }
         _patternSelectorList.dataProvider = new ListCollection(patternListData);
         updatePatternListSelection();
      }
      
      private function updatePatternListSelection(param1:int = 0, param2:int = 1) : void
      {
         if(param1 != param2)
         {
            if(param1 != 0)
            {
               _patternSelectorList.dataProvider.getItemAt(param1 - 1).selected = false;
               _patternSelectorList.dataProvider.updateItemAt(param1 - 1);
            }
            _patternSelectorList.dataProvider.getItemAt(param2 - 1).selected = true;
            _patternSelectorList.dataProvider.updateItemAt(param2 - 1);
            _selectedPatternId = param2;
         }
      }
      
      private function patternSelectionRendererFactory() : MobileCoaPatternSelectionViewRenderer
      {
         var _loc1_:MobileCoaPatternSelectionViewRenderer = new MobileCoaPatternSelectionViewRenderer(assetRepository);
         _loc1_.width = 95;
         _loc1_.height = 91;
         return _loc1_;
      }
      
      private function createAndAddDisplayObject(param1:String, param2:int, param3:int) : DisplayObject
      {
         var _loc4_:DisplayObject = assetRepository.getDisplayObject(param1);
         _loc4_.width = param2;
         _loc4_.height = param3;
         addChild(_loc4_);
         return _loc4_;
      }
      
      private function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(allianceCOA,coaBackground,40,27);
         MobileAlignmentUtil.alignBelowOf(_firstColorSelector,coaBackground,17);
         MobileAlignmentUtil.alignAccordingToPositionOf(_secondColorSelector,_firstColorSelector,121,0);
         MobileAlignmentUtil.alignAccordingToPositionOf(patternListBackground,coaBackground,coaBackground.width + 15,194);
      }
      
      public function updatePatternSelection(param1:MobileCoaPatternSelectionViewRenderer) : void
      {
         updatePatternListSelection(_selectedPatternId,param1.patternId);
         updateCOAAccordingToSelections();
      }
      
      public function updateCOAAccordingToSelections() : void
      {
         var _loc1_:CoatOfArmsInfo = new CoatOfArmsInfo(_selectedPatternId,_firstColorSelector.selectedColorType,_secondColorSelector.selectedColorType);
         allianceCOA.updateWithCoatOfArmsInfo(_loc1_);
      }
      
      public function updateWithCOAInfo(param1:CoatOfArmsInfo) : void
      {
         updatePatternListSelection(_selectedPatternId,param1.patternId);
         _firstColorSelector.selectColor(param1.patternColorA);
         _secondColorSelector.selectColor(param1.patternColorB);
      }
      
      public function getCOAInfo() : CoatOfArmsInfo
      {
         return new CoatOfArmsInfo(_selectedPatternId,_firstColorSelector.selectedColorType,_secondColorSelector.selectedColorType);
      }
      
      public function get firstColorSelector() : MobileVanityColorSelectorView
      {
         return _firstColorSelector;
      }
      
      public function get secondColorSelector() : MobileVanityColorSelectorView
      {
         return _secondColorSelector;
      }
      
      public function get patternSelectorList() : MPList
      {
         return _patternSelectorList;
      }
   }
}

