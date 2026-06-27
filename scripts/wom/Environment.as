package wom
{
   import flash.display.LoaderInfo;
   import flash.display.Stage;
   import flash.system.Capabilities;
   import flash.utils.getTimer;
   import org.robotlegs.mvcs.StarlingContext;
   import peak.starling.StarlingAssetManager;
   import starling.core.Starling;
   
   public class Environment
   {
      
      public static var stage:Stage;
      
      public static var loaderInfo:LoaderInfo;
      
      public static var screenWidth:Number;
      
      public static var screenHeight:Number;
      
      public static var hiRes:Boolean;
      
      public static var gpu:GpuContext;
      
      public static var starling:Starling;
      
      public static var starlingContext:StarlingContext;
      
      public static var starlingAssetManager:StarlingAssetManager;
      
      public static var startTime:int;
      
      public static const APP_ID_IOS:String = "778530732";
      
      public static const APP_ID_ANDROID:String = "air.wom.Client";
      
      public static const APP_URL_IOS:String = "http://itunes.apple.com/us/app/war-of-mercenaries/id778530732?ls=1&mt=8";
      
      public static const APP_URL_ANDROID:String = "market://details?id=air.wom.Client";
      
      public function Environment()
      {
         super();
      }
      
      public static function init() : void
      {
         startTime = getTimer();
         var _loc1_:Number = Math.min(Capabilities.screenResolutionX,Capabilities.screenResolutionY);
         hiRes = _loc1_ > 1200;
         gpu = new GpuContext();
         Starling.handleLostContext = false;
      }
      
      public static function initWithStage(param1:Stage) : void
      {
         stage = param1;
         loaderInfo = stage.root.loaderInfo;
         screenWidth = stage.fullScreenWidth;
         screenHeight = stage.fullScreenHeight;
         var _loc2_:Number = Math.min(screenWidth,screenHeight);
         hiRes = _loc2_ > 1200;
         gpu.init();
      }
   }
}

