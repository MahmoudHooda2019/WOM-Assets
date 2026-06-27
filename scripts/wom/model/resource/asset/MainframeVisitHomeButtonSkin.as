package wom.model.resource.asset
{
   import peak.resource.asset.core.CompositeBitmapAsset;
   
   public class MainframeVisitHomeButtonSkin extends CompositeBitmapAsset
   {
      
      public function MainframeVisitHomeButtonSkin()
      {
         super();
         addDynamicNode("ButtonEndAttack");
         addDynamicNode("HelpScreenHomeIcon",46,11);
      }
   }
}

