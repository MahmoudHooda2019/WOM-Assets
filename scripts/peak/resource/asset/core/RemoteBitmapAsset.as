package peak.resource.asset.core
{
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import peak.logging.LoggerContexts;
   import peak.logging.log;
   
   public class RemoteBitmapAsset extends BitmapAsset
   {
      
      private static const MAX_RETRIES:int = 3;
      
      private static const LOADER_CONTEXT_CHECKPOLICY:LoaderContext = new LoaderContext(true);
      
      protected var loader:Loader;
      
      protected var url:String;
      
      protected var checkPolicy:Boolean;
      
      protected var maxRetries:int;
      
      protected var numRetries:int = 0;
      
      protected var remoteWidth:int = 0;
      
      protected var remoteHeight:int = 0;
      
      protected var redirects:Array = [];
      
      public function RemoteBitmapAsset(param1:String, param2:Boolean = false, param3:int = 3, param4:int = 0, param5:int = 0)
      {
         super();
         this.url = param1;
         this.checkPolicy = param2;
         this.maxRetries = param3;
         this.remoteWidth = param4;
         this.remoteHeight = param5;
         loader = new Loader();
         loader.contentLoaderInfo.addEventListener("complete",onSourceLoaded);
         loader.contentLoaderInfo.addEventListener("ioError",onSourceLoadError);
         loader.contentLoaderInfo.addEventListener("securityError",onSecurityError);
         redirects.push(param1);
      }
      
      private function onSourceLoadError(param1:IOErrorEvent) : void
      {
         log(LoggerContexts.INFRASTRUCTURE,"RemoteBitmapAsset error",{
            "retry":numRetries,
            "url":url,
            "redirects":redirects,
            "error":param1.toString()
         });
         if(numRetries++ < maxRetries)
         {
            if(redirects.length > 1)
            {
               redirects.pop();
               url = redirects[redirects.length - 1];
            }
            loader.load(new URLRequest(url),checkPolicy ? LOADER_CONTEXT_CHECKPOLICY : null);
         }
         else
         {
            log(LoggerContexts.INFRASTRUCTURE,"RemoteBitmapAsset giving up",{
               "retry":numRetries,
               "url":url,
               "redirects":redirects,
               "error":param1.toString()
            });
            giveUp();
         }
      }
      
      protected function giveUp() : void
      {
      }
      
      private function onSecurityError(param1:Event) : void
      {
         log(LoggerContexts.INFRASTRUCTURE,"RemoteBitmapAsset asset security error",url);
      }
      
      private function onSourceLoaded(param1:Event) : void
      {
         if(!checkPolicy || (param1.target as LoaderInfo).url == url)
         {
            if(numRetries)
            {
               log(LoggerContexts.INFRASTRUCTURE,"RemoteBitmapAsset rescued",{
                  "retry":numRetries,
                  "url":url,
                  "redirects":redirects
               });
            }
            process();
         }
         else
         {
            url = (param1.target as LoaderInfo).url;
            redirects.push(url);
            loader.unload();
            loader.load(new URLRequest(url),checkPolicy ? LOADER_CONTEXT_CHECKPOLICY : null);
         }
      }
      
      protected function process() : void
      {
         try
         {
            _bitmapData = (loader.contentLoaderInfo.content as Bitmap).bitmapData;
            dispatchEvent(new Event("change"));
         }
         catch(e:Error)
         {
            log(LoggerContexts.INFRASTRUCTURE,"RemoteBitmapAsset exception",e.getStackTrace());
            log(LoggerContexts.INFRASTRUCTURE,"RemoteBitmapAsset processing error",url);
         }
      }
      
      override public function get complete() : Boolean
      {
         return _bitmapData != null && _bitmapData.width != 0 && _bitmapData.height != 0;
      }
      
      override public function get width() : int
      {
         return bitmapData == null ? remoteWidth : bitmapData.width;
      }
      
      override public function get height() : int
      {
         return bitmapData == null ? remoteHeight : bitmapData.height;
      }
   }
}

