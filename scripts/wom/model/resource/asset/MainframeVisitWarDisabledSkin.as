package wom.model.resource.asset
{
   import peak.resource.asset.core.CompositeBitmapAsset;
   
   public class MainframeVisitWarDisabledSkin extends CompositeBitmapAsset
   {
      
      public function MainframeVisitWarDisabledSkin()
      {
         super();
         addDynamicNode("ButtonWarDisable");
         addDynamicNode("WarIconDisabled",45,14);
      }
   }
}

