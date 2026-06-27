package wom.model.resource.asset
{
   import peak.resource.asset.core.CompositeBitmapAsset;
   
   public class ResourceAddButtonSkin extends CompositeBitmapAsset
   {
      
      public function ResourceAddButtonSkin()
      {
         super();
         addDynamicNode("GreenSquareButton");
         addDynamicNode("GreenPlusIcon",2,2);
      }
   }
}

