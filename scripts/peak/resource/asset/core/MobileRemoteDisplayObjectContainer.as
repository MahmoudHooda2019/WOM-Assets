package peak.resource.asset.core
{
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import peak.logging.LoggerContexts;
   import peak.logging.log;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   import starling.display.Image;
   import starling.events.Event;
   import starling.textures.Texture;
   
   public class MobileRemoteDisplayObjectContainer extends DisplayObjectContainer
   {
      
      private static const LOADER_CONTEXT_CHECKPOLICY:LoaderContext = new LoaderContext(true);
      
      private var _assetId:String;
      
      private var _url:String;
      
      private var _displayObject:DisplayObject;
      
      private var _bitmap:Bitmap;
      
      protected var loader:Loader;
      
      protected var checkPolicy:Boolean;
      
      protected var maxRetries:int;
      
      protected var numRetries:int = 0;
      
      protected var remoteWidth:Number;
      
      protected var remoteHeight:Number;
      
      protected var redirects:Array = [];
      
      public function MobileRemoteDisplayObjectContainer(param1:String, param2:String, param3:DisplayObject, param4:Number, param5:Number, param6:Bitmap = null)
      {
         super();
         _assetId = param1;
         _url = param2;
         this._bitmap = param6;
         this.checkPolicy = true;
         this.maxRetries = 10;
         this.remoteWidth = param4;
         this.remoteHeight = param5;
         if(param6 == null)
         {
            _displayObject = param3;
            _displayObject.width = param4;
            _displayObject.height = param5;
            addChild(_displayObject);
            loader = new Loader();
            loader.contentLoaderInfo.addEventListener("complete",onSourceLoaded);
            loader.contentLoaderInfo.addEventListener("ioError",onSourceLoadError);
            loader.contentLoaderInfo.addEventListener("securityError",onSecurityError);
            loader.load(new URLRequest(_url),checkPolicy ? LOADER_CONTEXT_CHECKPOLICY : null);
            redirects.push(_url);
         }
         else
         {
            process();
         }
      }
      
      private function onSourceLoadError(param1:IOErrorEvent) : void
      {
         log(LoggerContexts.INFRASTRUCTURE,"MobileRemoteBitmapAsset error",{
            "retry":numRetries,
            "url":_url,
            "redirects":redirects,
            "error":param1.toString()
         });
         if(numRetries++ < maxRetries)
         {
            if(redirects.length > 1)
            {
               redirects.pop();
               _url = redirects[redirects.length - 1];
            }
            loader.load(new URLRequest(_url),checkPolicy ? LOADER_CONTEXT_CHECKPOLICY : null);
         }
         else
         {
            log(LoggerContexts.INFRASTRUCTURE,"MobileRemoteBitmapAsset giving up",{
               "retry":numRetries,
               "url":_url,
               "redirects":redirects,
               "error":param1.toString()
            });
            giveUp();
         }
      }
      
      protected function giveUp() : void
      {
      }
      
      private function onSecurityError(param1:SecurityErrorEvent) : void
      {
         log(LoggerContexts.INFRASTRUCTURE,"MobileRemoteBitmapAsset asset security error",_url);
      }
      
      private function onSourceLoaded(param1:flash.events.Event) : void
      {
         if(!checkPolicy || (param1.target as LoaderInfo).url == _url)
         {
            if(numRetries)
            {
               log(LoggerContexts.INFRASTRUCTURE,"MobileRemoteBitmapAsset rescued",{
                  "retry":numRetries,
                  "url":_url,
                  "redirects":redirects
               });
            }
            process();
         }
         else
         {
            _url = (param1.target as LoaderInfo).url;
            redirects.push(_url);
            loader.unload();
            loader.load(new URLRequest(_url),checkPolicy ? LOADER_CONTEXT_CHECKPOLICY : null);
         }
      }
      
      protected function populateImageFromBitmap() : Image
      {
         return new Image(Texture.fromBitmap(_bitmap));
      }
      
      protected function process() : void
      {
         try
         {
            if(contains(_displayObject))
            {
               removeChild(_displayObject);
            }
            if(!_bitmap)
            {
               _bitmap = loader.contentLoaderInfo.content as Bitmap;
            }
            _displayObject = populateImageFromBitmap();
            _displayObject.visible = true;
            _displayObject.width = remoteWidth;
            _displayObject.height = remoteHeight;
            addChild(_displayObject);
            dispatchEvent(new starling.events.Event("change"));
         }
         catch(e:Error)
         {
            log(LoggerContexts.INFRASTRUCTURE,"MobileRemoteBitmapAsset exception",e.getStackTrace());
            log(LoggerContexts.INFRASTRUCTURE,"MobileRemoteBitmapAsset processing error",_url);
         }
      }
      
      public function get complete() : Boolean
      {
         return _displayObject != null && _displayObject.width > 0 && _displayObject.height > 0;
      }
      
      public function get assetId() : String
      {
         return _assetId;
      }
      
      public function get url() : String
      {
         return _url;
      }
      
      public function get displayObject() : DisplayObject
      {
         return _displayObject;
      }
      
      public function get bitmap() : Bitmap
      {
         return _bitmap;
      }
   }
}

