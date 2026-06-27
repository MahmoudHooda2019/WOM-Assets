package wom.model.resource.asset
{
   import peak.resource.asset.core.CompositeBitmapAsset;
   
   public class MainframeScoutWarButtonSkin extends CompositeBitmapAsset
   {
      
      public function MainframeScoutWarButtonSkin()
      {
         super();
         addDynamicNode("ButtonWarNormal");
         addDynamicNode("WarIcon",42,11);
      }
   }
}

