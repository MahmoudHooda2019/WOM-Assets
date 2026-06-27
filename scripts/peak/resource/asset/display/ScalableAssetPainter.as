package peak.resource.asset.display
{
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.geom.Rectangle;
   
   public interface ScalableAssetPainter
   {
      
      function get innerRectangle() : Rectangle;
      
      function paint(param1:Graphics, param2:BitmapData, param3:int, param4:int) : Rectangle;
      
      function clone() : ScalableAssetPainter;
   }
}

