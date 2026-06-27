package wom.view.screen.windows.alliance.coa
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import peak.util.AlignmentUtil;
   import wom.model.game.alliance.coa.CoatOfArmsInfo;
   import wom.model.game.alliance.coa.VanityColorType;
   import wom.model.resource.WomAssetRepository;
   
   public class EditCoatOfArmsPanel extends Sprite
   {
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      private var coaBackground:DisplayObject;
      
      private var allianceCOA:CoatOfArmsView;
      
      private var allianceToken:TokenView;
      
      private var firstColorSelectorBg:DisplayObject;
      
      private var _firstColorSelector:VanityColorSelectorView;
      
      private var secondColorSelectorBg:DisplayObject;
      
      private var _secondColorSelector:VanityColorSelectorView;
      
      private var _coaPatterns:Vector.<CoaPatternSelectionView>;
      
      private var _selectedPatternView:CoaPatternSelectionView;
      
      private const PATTERN_COUNT:int = 12;
      
      private const PATTERN_COL_LENGHT:int = 6;
      
      public function EditCoatOfArmsPanel()
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
         coaBackground = createAndAddDisplayObject("TooltipInnerBackground",145,128);
         secondColorSelectorBg = createAndAddDisplayObject("TooltipInnerBackground",105,62);
         firstColorSelectorBg = createAndAddDisplayObject("TooltipInnerBackground",105,62);
         createPatternViews();
         _secondColorSelector = new VanityColorSelectorView(2);
         addChild(_secondColorSelector);
         _firstColorSelector = new VanityColorSelectorView(1);
         addChild(_firstColorSelector);
         allianceCOA = new CoatOfArmsView(assetRepository);
         addChild(allianceCOA);
         allianceToken = new TokenView(assetRepository);
         addChild(allianceToken);
         _selectedPatternView = _coaPatterns[0];
         _coaPatterns[0].updateSelection(true);
         _firstColorSelector.selectColor(VanityColorType.DEFAULT);
         _secondColorSelector.selectColor(VanityColorType.DEFAULT_2);
         drawLayout();
         updateCOAAccordingToSelections();
      }
      
      private function createPatternViews() : void
      {
         var _loc2_:int = 0;
         var _loc1_:CoaPatternSelectionView = null;
         _coaPatterns = new Vector.<CoaPatternSelectionView>();
         _loc2_ = 0;
         while(_loc2_ < 12)
         {
            _loc1_ = new CoaPatternSelectionView(assetRepository,_loc2_ + 1);
            _loc1_.x = 270 + _loc2_ % 6 * 59;
            if(_loc2_ >= 6)
            {
               _loc1_.y = 66;
            }
            addChild(_loc1_);
            _coaPatterns.push(_loc1_);
            _loc2_++;
         }
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
         AlignmentUtil.alignRightOf(secondColorSelectorBg,coaBackground,4);
         AlignmentUtil.alignBelowOf(firstColorSelectorBg,secondColorSelectorBg,4);
         AlignmentUtil.alignAccordingToPositionOf(_firstColorSelector,firstColorSelectorBg,12,12);
         AlignmentUtil.alignAccordingToPositionOf(_secondColorSelector,secondColorSelectorBg,12,12);
         AlignmentUtil.alignAccordingToPositionOf(allianceCOA,coaBackground,49,38);
         AlignmentUtil.alignAccordingToPositionOf(allianceToken,coaBackground,105,95);
      }
      
      public function updatePatternSelection(param1:CoaPatternSelectionView) : void
      {
         _selectedPatternView.updateSelection(false);
         param1.updateSelection(true);
         _selectedPatternView = param1;
         updateCOAAccordingToSelections();
      }
      
      public function updateCOAAccordingToSelections() : void
      {
         var _loc1_:CoatOfArmsInfo = new CoatOfArmsInfo(_selectedPatternView.patternId,_firstColorSelector.selectedColorType,_secondColorSelector.selectedColorType);
         allianceCOA.updateWithCoatOfArmsInfo(_loc1_);
         allianceToken.updateWithCoatOfArmsInfo(_loc1_);
      }
      
      public function updateWithCOAInfo(param1:CoatOfArmsInfo) : void
      {
         var _loc4_:int = 0;
         var _loc3_:CoaPatternSelectionView = null;
         var _loc2_:Boolean = false;
         _loc4_ = 0;
         while(_loc4_ < _coaPatterns.length && !_loc2_)
         {
            _loc3_ = _coaPatterns[_loc4_];
            if(_loc3_.patternId == param1.patternId)
            {
               if(_selectedPatternView)
               {
                  _selectedPatternView.updateSelection(false);
               }
               _selectedPatternView = _loc3_;
               _selectedPatternView.updateSelection(true);
               _loc2_ = true;
            }
            _loc4_++;
         }
         _firstColorSelector.selectColor(param1.patternColorA);
         _secondColorSelector.selectColor(param1.patternColorB);
      }
      
      public function getCOAInfo() : CoatOfArmsInfo
      {
         return new CoatOfArmsInfo(_selectedPatternView.patternId,_firstColorSelector.selectedColorType,_secondColorSelector.selectedColorType);
      }
      
      public function get firstColorSelector() : VanityColorSelectorView
      {
         return _firstColorSelector;
      }
      
      public function get secondColorSelector() : VanityColorSelectorView
      {
         return _secondColorSelector;
      }
      
      public function get coaPatterns() : Vector.<CoaPatternSelectionView>
      {
         return _coaPatterns;
      }
   }
}

