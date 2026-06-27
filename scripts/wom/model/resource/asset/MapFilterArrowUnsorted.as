package wom.model.resource.asset
{
   import peak.resource.asset.core.CompositeBitmapAsset;
   
   public class MapFilterArrowUnsorted extends CompositeBitmapAsset
   {
      
      public function MapFilterArrowUnsorted()
      {
         super();
         addDynamicNode("MapFilterArrowUp");
         addDynamicNode("MapFilterArrowDown",0,7);
      }
   }
}

