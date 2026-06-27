package wom.model.resource.asset
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.events.Event;
   import peak.logging.LoggerContexts;
   import peak.logging.log;
   import peak.resource.asset.core.BitmapAssetReference;
   import peak.resource.asset.core.RemoteBitmapAsset;
   
   public class RoundedFacebookPicture extends RemoteBitmapAsset
   {
      
      private var _placeholder:BitmapAssetReference;
      
      public function RoundedFacebookPicture(param1:String, param2:BitmapAssetReference)
      {
         super(param1,true,10);
         _placeholder = param2;
         drawPlaceholder();
      }
      
      override protected function process() : void
      {
         try
         {
            drawRounded(loader.contentLoaderInfo.content as Bitmap);
            loader.unload();
            dispatchEvent(new Event("change"));
         }
         catch(e:Error)
         {
            log(LoggerContexts.INFRASTRUCTURE,"RemoteBitmapAsset: can\'t process",url);
         }
      }
      
      protected function drawRounded(param1:Bitmap, param2:Number = 14) : void
      {
         if(_bitmapData && _bitmapData.width == param1.width && _bitmapData.height == param1.height && _bitmapData.transparent == param1.bitmapData.transparent)
         {
            _bitmapData.fillRect(_bitmapData.rect,0);
         }
         else
         {
            if(_bitmapData)
            {
               _bitmapData.dispose();
            }
            _bitmapData = new BitmapData(param1.width,param1.height,true,0);
         }
         var _loc3_:Shape = new Shape();
         _loc3_.graphics.beginFill(0,0);
         _loc3_.graphics.drawRoundRect(0,0,param1.width,param1.height,param2,param2);
         param1.mask = _loc3_;
         _bitmapData.draw(param1);
         _loc3_ = null;
      }
      
      private function drawPlaceholder() : void
      {
         if(_placeholder.complete)
         {
            drawRounded(new Bitmap(_placeholder.bitmapAsset.bitmapData));
         }
         else
         {
            _placeholder.addEventListener("change",onFallbackChange);
         }
      }
      
      private function onFallbackChange(param1:Event) : void
      {
         drawPlaceholder();
      }
   }
}

