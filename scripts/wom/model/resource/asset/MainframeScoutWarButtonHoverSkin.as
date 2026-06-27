package wom.model.resource.asset
{
   import peak.resource.asset.core.CompositeBitmapAsset;
   
   public class MainframeScoutWarButtonHoverSkin extends CompositeBitmapAsset
   {
      
      public function MainframeScoutWarButtonHoverSkin()
      {
         super();
         addDynamicNode("ButtonWarNormal");
         addDynamicNode("WarIconHover",38,7);
      }
   }
}

