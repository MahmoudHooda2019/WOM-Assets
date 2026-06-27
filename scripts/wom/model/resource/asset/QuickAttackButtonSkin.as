package wom.model.resource.asset
{
   import peak.resource.asset.core.CompositeBitmapAsset;
   
   public class QuickAttackButtonSkin extends CompositeBitmapAsset
   {
      
      public function QuickAttackButtonSkin()
      {
         super();
         addDynamicNode("ButtonWarNormal",0,10);
         addDynamicNode("IconQuickAttack",46,0);
      }
   }
}

