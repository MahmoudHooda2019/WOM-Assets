package wom.view.screen.windows.alliance.coa
{
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   import peak.resource.asset.display.AssetDisplayObject;
   import wom.model.game.alliance.coa.CoatOfArmsInfo;
   import wom.model.game.alliance.coa.VanityUtil;
   import wom.model.resource.WomAssetRepository;
   
   public class CoatOfArmsView extends Sprite
   {
      
      protected var assetRepository:WomAssetRepository;
      
      protected var _patternB:AssetDisplayObject;
      
      protected var _patternA:AssetDisplayObject;
      
      protected var border:AssetDisplayObject;
      
      private var patternAColorCode:uint = 0;
      
      private var patternBColorCode:uint = 0;
      
      public function CoatOfArmsView(param1:WomAssetRepository)
      {
         super();
         this.useHandCursor = true;
         this.mouseChildren = true;
         this.assetRepository = param1;
         init();
      }
      
      public function init() : void
      {
         initLayout();
      }
      
      private function initLayout() : void
      {
      }
      
      public function updateWithCoatOfArmsInfo(param1:CoatOfArmsInfo) : void
      {
         if(border != null && contains(border))
         {
            removeChild(border);
         }
         patternB = param1.patternId;
         patternA = param1.patternId;
         patternBColor = param1.patternColorB.color;
         patternAColor = param1.patternColorA.color;
         border = assetRepository.getDisplayObject(getBorderAsset());
         addChild(border);
      }
      
      protected function getBorderAsset() : String
      {
         return "DefaultArm";
      }
      
      public function set patternAColor(param1:uint) : void
      {
         patternAColorCode = param1;
         _patternA.transform.colorTransform = new ColorTransform(VanityUtil.extractRed(param1) / 255,VanityUtil.extractGreen(param1) / 255,VanityUtil.extractBlue(param1) / 255);
      }
      
      public function set patternBColor(param1:uint) : void
      {
         patternBColorCode = param1;
         _patternB.transform.colorTransform = new ColorTransform(VanityUtil.extractRed(param1) / 255,VanityUtil.extractGreen(param1) / 255,VanityUtil.extractBlue(param1) / 255);
      }
      
      public function set patternA(param1:int) : void
      {
         if(_patternA != null && contains(_patternA))
         {
            removeChild(_patternA);
         }
         _patternA = assetRepository.getDisplayObject(getPatternAssetA(param1));
         patternAColor = patternAColorCode;
         addChildAt(_patternA,1);
         drawPatternALayout();
      }
      
      protected function drawPatternALayout() : void
      {
         _patternA.x = 6;
         _patternA.y = 6;
      }
      
      protected function getPatternAssetA(param1:int) : String
      {
         return "ArmPattern" + param1 + "A";
      }
      
      public function set patternB(param1:int) : void
      {
         if(_patternB != null && contains(_patternB))
         {
            removeChild(_patternB);
         }
         _patternB = assetRepository.getDisplayObject(getPatternAssetB(param1));
         patternBColor = patternBColorCode;
         addChildAt(_patternB,0);
         drawPatternBLayout();
      }
      
      protected function drawPatternBLayout() : void
      {
         _patternB.x = 6;
         _patternB.y = 6;
      }
      
      protected function getPatternAssetB(param1:int) : String
      {
         return "ArmPatternBase";
      }
   }
}

