package wom.model.resource.asset
{
   import peak.resource.asset.core.CompositeBitmapAsset;
   
   public class ResourceAddButtonHoverSkin extends CompositeBitmapAsset
   {
      
      public function ResourceAddButtonHoverSkin()
      {
         super();
         addDynamicNode("GreenSquareButtonBigHover");
         addDynamicNode("GreenPlusIconBig",2,2);
      }
   }
}

