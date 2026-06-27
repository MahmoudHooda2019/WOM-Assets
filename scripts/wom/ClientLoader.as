package wom
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.TimerEvent;
   import flash.external.ExternalInterface;
   import flash.utils.Timer;
   import flash.utils.getDefinitionByName;
   
   public class ClientLoader extends MovieClip
   {
      
      public static var KT_API_KEY:String = "ed878148eae4442db500de505efa97bd";
      
      public var context:Object;
      
      public var loadingScreen:LoadingScreen;
      
      public var loadingFinished:Boolean = false;
      
      public var timerFinished:Boolean = false;
      
      public var timer:Timer;
      
      public function ClientLoader()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         Environment.init();
         Environment.initWithStage(stage);
         log("Loading " + loaderInfo.bytesTotal + " bytes, " + totalFrames + " frames");
         stop();
         initLayout();
         timer = new Timer(2000,1);
         timer.addEventListener("timerComplete",onTimerComplete);
         timer.start();
         loaderInfo.addEventListener("progress",onLoadingProgress);
         loaderInfo.addEventListener("ioError",onIoError);
         checkLoadedFrames();
      }
      
      private function onTimerComplete(param1:TimerEvent) : void
      {
         timerFinished = true;
         startup();
      }
      
      private function initLayout() : void
      {
         var _loc1_:Object = loaderInfo.parameters;
         var _loc3_:Number = Number("kid" in _loc1_ ? _loc1_.kid : NaN);
         var _loc2_:Boolean = false;
         if("newuser" in _loc1_)
         {
            _loc2_ = _loc1_.newuser == "true";
         }
         stage.scaleMode = "noScale";
         stage.align = "TL";
         loadingScreen = new LoadingScreen(_loc3_,_loc2_);
         stage.addEventListener("resize",onStageResize);
         addChild(loadingScreen);
         loadingScreen.updateWithProgress(0,loaderInfo.bytesTotal);
      }
      
      private function log(param1:*) : void
      {
         trace(param1);
         if(ExternalInterface.available && ExternalInterface.call("function(){return typeof window.console == \'object\'}"))
         {
            ExternalInterface.call("console.log",param1);
         }
      }
      
      private function onIoError(param1:IOErrorEvent) : void
      {
         log(param1.text);
      }
      
      private function onLoadingProgress(param1:ProgressEvent) : void
      {
         if(loadingScreen)
         {
            loadingScreen.updateWithProgress(param1.bytesLoaded,param1.bytesTotal);
         }
         checkLoadedFrames();
      }
      
      private function checkLoadedFrames() : void
      {
         while(framesLoaded != currentFrame)
         {
            nextFrame();
            if(currentFrameLabel == "CodeFrame")
            {
               loadingFinished = true;
               loadingScreen.updateWithProgress(loaderInfo.bytesLoaded,loaderInfo.bytesTotal);
               startup();
            }
         }
         if(framesLoaded == totalFrames)
         {
            onLoadingFinished();
         }
      }
      
      private function onLoadingFinished() : void
      {
         log("Loading finished");
         loaderInfo.removeEventListener("progress",onLoadingProgress);
         loaderInfo.removeEventListener("ioError",onIoError);
      }
      
      private function startup() : void
      {
         if(timerFinished && loadingFinished)
         {
            log("Starting up with " + loaderInfo.bytesLoaded + " bytes loaded");
            loadingScreen.notifyLoadingFinished();
            stage.removeEventListener("resize",onStageResize);
            removeChild(loadingScreen);
            loadingScreen = null;
            context = new (getDefinitionByName("wom.ClientContext") as Class)(this);
         }
      }
      
      private function onStageResize(param1:Event) : void
      {
         if(contains(loadingScreen))
         {
            loadingScreen.drawLayout();
         }
      }
   }
}

