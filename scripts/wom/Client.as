package wom
{
   import flash.desktop.NativeApplication;
   import flash.display.MovieClip;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.geom.Rectangle;
   import flash.system.System;
   import flash.utils.getTimer;
   import org.robotlegs.mvcs.Context;
   import peak.starling.StarlingAssetManager;
   import starling.core.Starling;
   
   public class Client extends MovieClip
   {
      
      public var context:Context;
      
      public function Client()
      {
         super();
         Environment.init();
         addEventListener("addedToStage",onAddedToStage);
      }
      
      public static function onKeyDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 16777238)
         {
            param1.preventDefault();
            param1.stopImmediatePropagation();
         }
      }
      
      public static function startStarling() : void
      {
         if(Environment.starlingContext)
         {
            Environment.starlingContext.shutdown();
            Environment.starlingAssetManager.dispose();
            Environment.starling.shareContext = true;
            Environment.starling.dispose();
            System.pauseForGCIfCollectionImminent(0.1);
         }
         Environment.stage.addEventListener("enterFrame",startStarling0,false,0,true);
      }
      
      protected static function startStarling0(param1:Event) : void
      {
         Environment.stage.removeEventListener("enterFrame",startStarling0);
         var _loc2_:Number = Environment.stage.fullScreenWidth;
         var _loc3_:Number = Environment.stage.fullScreenHeight;
         Environment.starling = new Starling(MobileClient,Environment.stage,new Rectangle(0,0,_loc2_,_loc3_),Environment.gpu.stage3D);
         Environment.starlingAssetManager = new StarlingAssetManager();
         if(Environment.stage.fullScreenHeight > 1200)
         {
            Environment.starling.stage.stageWidth = _loc2_ / 2;
            Environment.starling.stage.stageHeight = _loc3_ / 2;
         }
         else
         {
            Environment.starling.stage.stageHeight *= 768 / _loc3_;
            Environment.starling.stage.stageWidth *= 768 / _loc3_;
         }
         Environment.starling.shareContext = false;
         Environment.starling.start();
         trace("STARLING STARTED",getTimer() - Environment.startTime);
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         removeEventListener("addedToStage",onAddedToStage);
         if(Stage.supportsOrientationChange)
         {
            stage.setAspectRatio("landscape");
         }
         Environment.gpu.addEventListener("complete",onComplete);
         Environment.initWithStage(stage);
         NativeApplication.nativeApplication.addEventListener("keyDown",onKeyDown,false,0,true);
      }
      
      private function onComplete(param1:Event) : void
      {
         trace("GPU READY",getTimer() - Environment.startTime);
         startStarling();
      }
   }
}

