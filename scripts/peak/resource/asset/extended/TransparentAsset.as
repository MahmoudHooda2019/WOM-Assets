package peak.resource.asset.extended
{
   import flash.display.BitmapData;
   import peak.resource.asset.core.BitmapAsset;
   import peak.resource.asset.display.Scale9AssetPainter;
   
   public class TransparentAsset extends BitmapAsset
   {
      
      public function TransparentAsset()
      {
         super(new BitmapData(3,3,true,16777215),new Scale9AssetPainter(1,1,1,1));
      }
   }
}

