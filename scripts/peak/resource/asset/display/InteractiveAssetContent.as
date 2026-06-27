package peak.resource.asset.display
{
   import flash.display.Shape;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import peak.resource.asset.core.BitmapAsset;
   
   public class InteractiveAssetContent extends Shape implements AssetContent
   {
      
      private var _bitmapAsset:BitmapAsset;
      
      private var targetWidth:Number;
      
      private var targetHeight:Number;
      
      public function InteractiveAssetContent(param1:BitmapAsset)
      {
         super();
         _bitmapAsset = param1;
         _bitmapAsset.addEventListener("change",onChange,false,0,true);
         update();
      }
      
      private function onChange(param1:Event) : void
      {
         update();
      }
      
      public function update() : void
      {
         draw();
      }
      
      private function draw() : void
      {
         var _loc1_:Rectangle = null;
         if(_bitmapAsset.complete)
         {
            if(_bitmapAsset.interactive)
            {
               _loc1_ = _bitmapAsset.scalePainter.paint(graphics,_bitmapAsset.bitmapData,targetWidth,targetHeight);
               try
               {
                  this.scale9Grid = _loc1_;
               }
               catch(e:Error)
               {
               }
            }
         }
      }
      
      override public function set width(param1:Number) : void
      {
         if(targetWidth != param1)
         {
            targetWidth = param1;
            draw();
            super.width = param1;
         }
      }
      
      override public function set height(param1:Number) : void
      {
         if(targetHeight != param1)
         {
            targetHeight = param1;
            draw();
            super.height = param1;
         }
      }
   }
}

