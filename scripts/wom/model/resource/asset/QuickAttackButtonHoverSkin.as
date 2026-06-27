package wom.model.resource.asset
{
   import peak.resource.asset.core.CompositeBitmapAsset;
   
   public class QuickAttackButtonHoverSkin extends CompositeBitmapAsset
   {
      
      public function QuickAttackButtonHoverSkin()
      {
         super();
         addDynamicNode("ButtonWarNormal",0,10);
         addDynamicNode("IconQuickAttackHover",43,0);
      }
   }
}

