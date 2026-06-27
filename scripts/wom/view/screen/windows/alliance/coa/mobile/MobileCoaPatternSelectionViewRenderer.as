package wom.view.screen.windows.alliance.coa.mobile
{
   import feathers.controls.renderers.IListItemRenderer;
   import peak.component.mobile.MPItemRenderer;
   import starling.display.DisplayObject;
   import wom.model.resource.MobileWomAssetRepository;
   
   public class MobileCoaPatternSelectionViewRenderer extends MPItemRenderer implements IListItemRenderer
   {
      
      private var assetRepository:MobileWomAssetRepository;
      
      private var background:DisplayObject;
      
      private var patternAsset:DisplayObject;
      
      private var _patternId:int;
      
      private var _selected:Boolean;
      
      public function MobileCoaPatternSelectionViewRenderer(param1:MobileWomAssetRepository)
      {
         super();
         this.assetRepository = param1;
         init();
      }
      
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         background = assetRepository.getDisplayObject("MobileGrayBackground");
         background.width = 83;
         background.height = 91;
         addChild(background);
         _selected = false;
      }
      
      override public function set data(param1:Object) : void
      {
         if(param1)
         {
            _patternId = int(param1.patternId);
            if(patternAsset && contains(patternAsset))
            {
               removeChild(patternAsset);
            }
            patternAsset = assetRepository.getDisplayObject(patternAssetId);
            patternAsset.scaleY = patternAsset.scaleX = 86 / patternAsset.height;
            patternAsset.x = 1;
            addChild(patternAsset);
            updateSelection(param1.selected);
         }
         super.data = param1;
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
            background = assetRepository.getDisplayObject(param1 ? "MobileInnerBeigeBackground" : "MobileGrayBackground");
            background.width = 83;
            background.height = 91;
            addChildAt(background,0);
         }
      }
      
      private function get patternAssetId() : String
      {
         return "ArmPattern" + _patternId;
      }
      
      public function get patternId() : int
      {
         return _patternId;
      }
   }
}

