package wom.view.screen.windows.alliance.coa
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import peak.display.View;
   import wom.model.resource.WomAssetRepository;
   
   public class CoaPatternSelectionView extends Sprite implements View
   {
      
      private var assetRepository:WomAssetRepository;
      
      private var background:DisplayObject;
      
      private var patternAsset:DisplayObject;
      
      private var _patternId:int;
      
      private var _selected:Boolean;
      
      public function CoaPatternSelectionView(param1:WomAssetRepository, param2:int)
      {
         super();
         this.assetRepository = param1;
         _patternId = param2;
         init();
      }
      
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         background = assetRepository.getDisplayObject("TooltipInnerBackground");
         background.width = 57;
         background.height = 64;
         addChild(background);
         patternAsset = assetRepository.getDisplayObject(patternAssetId);
         addChild(patternAsset);
         _selected = false;
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         patternAsset.x = 7;
         patternAsset.y = 7;
      }
      
      public function updateSelection(param1:Boolean) : void
      {
         if(_selected != param1)
         {
            _selected = param1;
            if(background && contains(background))
            {
               removeChild(background);
            }
            background = assetRepository.getDisplayObject(param1 ? "BackgroundDark" : "TooltipInnerBackground");
            background.width = 57;
            background.height = 64;
            addChildAt(background,0);
         }
      }
      
      private function get patternAssetId() : String
      {
         return "PatternSymbol" + _patternId;
      }
      
      public function get patternId() : int
      {
         return _patternId;
      }
   }
}

