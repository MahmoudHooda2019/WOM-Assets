package wom.view.screen.windows.alliance.coa
{
   import wom.model.resource.WomAssetRepository;
   
   public class TokenView extends CoatOfArmsView
   {
      
      public function TokenView(param1:WomAssetRepository)
      {
         super(param1);
      }
      
      override protected function getBorderAsset() : String
      {
         return "DefaultToken";
      }
      
      override protected function getPatternAssetA(param1:int) : String
      {
         return "TokenColorA";
      }
      
      override protected function getPatternAssetB(param1:int) : String
      {
         return "TokenColorB";
      }
      
      override protected function drawPatternALayout() : void
      {
         _patternA.x = 1;
         _patternA.y = 1;
      }
      
      override protected function drawPatternBLayout() : void
      {
         _patternB.x = 1;
         _patternB.y = 1;
      }
   }
}

