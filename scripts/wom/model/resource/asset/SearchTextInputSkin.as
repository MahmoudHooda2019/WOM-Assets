package wom.model.resource.asset
{
   import peak.resource.asset.core.CompositeBitmapAsset;
   import peak.resource.asset.display.Scale9AssetPainter;
   
   public class SearchTextInputSkin extends CompositeBitmapAsset
   {
      
      public function SearchTextInputSkin(param1:Boolean = true)
      {
         super(new Scale9AssetPainter(29,9,9,14));
         addDynamicNode("InviteFriendsAPIVisualSearchLeft");
         if(param1)
         {
            addDynamicNode("InviteFriendsAPIVisualSearchIcon",10,10);
         }
         addDynamicNode("InviteFriendsAPIVisualSearchRight",30);
      }
   }
}

