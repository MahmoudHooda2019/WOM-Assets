package peak.resource.asset.core
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class CompositeBitmapAssetNode extends BitmapAssetNode
   {
      
      private var _position:Point;
      
      public function CompositeBitmapAssetNode(param1:BitmapAssetReference, param2:Number = 0, param3:Number = 0)
      {
         super(param1);
         this._position = new Point(param2,param3);
      }
      
      public function get position() : Point
      {
         return _position;
      }
      
      public function get bounds() : Rectangle
      {
         return new Rectangle(_position.x,_position.y,assetReference.bitmapAsset.width,assetReference.bitmapAsset.height);
      }
   }
}

