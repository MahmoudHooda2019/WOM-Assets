package wom.model.resource.asset
{
   import peak.resource.asset.core.CompositeBitmapAsset;
   
   public class EndAttackButtonSkin extends CompositeBitmapAsset
   {
      
      public function EndAttackButtonSkin()
      {
         super();
         addDynamicNode("ButtonEndAttack");
         addDynamicNode("WarIcon",42,11);
      }
   }
}

