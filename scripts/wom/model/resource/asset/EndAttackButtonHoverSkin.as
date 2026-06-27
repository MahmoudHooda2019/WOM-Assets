package wom.model.resource.asset
{
   import peak.resource.asset.core.CompositeBitmapAsset;
   
   public class EndAttackButtonHoverSkin extends CompositeBitmapAsset
   {
      
      public function EndAttackButtonHoverSkin()
      {
         super();
         addDynamicNode("ButtonEndAttack");
         addDynamicNode("WarIconHover",38,7);
      }
   }
}

