package peak.resource.asset.display
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   import peak.resource.asset.core.BitmapAsset;
   
   public class BitmapAssetContent extends Bitmap implements AssetContent
   {
      
      private var _bitmapAsset:BitmapAsset;
      
      public function BitmapAssetContent(param1:BitmapAsset)
      {
         super(null,"always",true);
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
         this.bitmapData = _bitmapAsset.bitmapData;
         if(this._bitmapAsset.hasAnimation)
         {
            this.addEventListener("enterFrame",onEnterFrame,false,0,true);
         }
         else
         {
            this.removeEventListener("enterFrame",onEnterFrame);
         }
         dispatchEvent(new Event("change"));
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         _bitmapAsset.updateFrame(this);
         this.bitmapData = _bitmapAsset.bitmapData;
      }
      
      override public function set bitmapData(param1:BitmapData) : void
      {
         super.bitmapData = param1;
         this.smoothing = true;
      }
   }
}

