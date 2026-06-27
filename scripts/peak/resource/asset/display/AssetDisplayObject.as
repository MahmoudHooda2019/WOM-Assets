package peak.resource.asset.display
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import peak.display.ClonableDisplayObject;
   import peak.resource.asset.core.BitmapAssetReference;
   
   public class AssetDisplayObject extends Sprite implements ClonableDisplayObject
   {
      
      private var _initialized:Boolean = false;
      
      private var _assetReference:BitmapAssetReference;
      
      private var _content:AssetContent;
      
      private var pendingWidth:Number = NaN;
      
      private var pendingHeight:Number = NaN;
      
      public function AssetDisplayObject(param1:BitmapAssetReference)
      {
         super();
         this._assetReference = param1;
         if(!_assetReference.complete)
         {
            _assetReference.addEventListener("change",onChange,false,0,true);
         }
         update();
      }
      
      private function onChange(param1:Event) : void
      {
         update();
         dispatchEvent(param1);
      }
      
      private function update() : void
      {
         if(!_initialized && _assetReference.complete)
         {
            init();
         }
      }
      
      private function init() : void
      {
         var _loc2_:InteractiveAssetContent = null;
         var _loc1_:BitmapAssetContent = null;
         if(_assetReference.bitmapAsset.interactive)
         {
            _loc2_ = new InteractiveAssetContent(_assetReference.bitmapAsset);
            _loc2_.addEventListener("change",onContentChange,false,0,true);
            _content = _loc2_;
            addChild(_loc2_);
         }
         else
         {
            _loc1_ = new BitmapAssetContent(_assetReference.bitmapAsset);
            _loc1_.addEventListener("change",onContentChange,false,0,true);
            _content = _loc1_;
            addChild(_loc1_);
         }
         _initialized = true;
         if(!isNaN(pendingWidth))
         {
            _content.width = pendingWidth;
         }
         if(!isNaN(pendingHeight))
         {
            _content.height = pendingHeight;
         }
      }
      
      public function clone() : DisplayObject
      {
         var _loc1_:AssetDisplayObject = new AssetDisplayObject(_assetReference);
         _loc1_.width = !isNaN(pendingWidth) ? pendingWidth : _content.width;
         _loc1_.height = !isNaN(pendingHeight) ? pendingHeight : _content.height;
         return _loc1_;
      }
      
      override public function set width(param1:Number) : void
      {
         if(_initialized)
         {
            if(_content.width != param1)
            {
               _content.width = param1;
            }
         }
         else
         {
            pendingWidth = param1;
         }
      }
      
      override public function set height(param1:Number) : void
      {
         if(_initialized)
         {
            if(_content.height != param1)
            {
               _content.height = param1;
            }
         }
         else
         {
            pendingHeight = param1;
         }
      }
      
      private function onContentChange(param1:Event) : void
      {
         dispatchEvent(param1);
      }
      
      public function get assetReference() : BitmapAssetReference
      {
         return _assetReference;
      }
   }
}

