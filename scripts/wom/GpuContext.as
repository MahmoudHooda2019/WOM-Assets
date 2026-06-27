package wom
{
   import flash.display.Stage3D;
   import flash.display3D.Context3D;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import peak.resource.atlas.AtlasManager;
   import peak.resource.atlas.starling.StarlingAtlasManager;
   
   public class GpuContext extends EventDispatcher
   {
      
      public static const PROFILES:Vector.<String> = new <String>["baselineExtended","baseline","baselineConstrained"];
      
      public var profile:String;
      
      public var stage3D:Stage3D;
      
      public var context3D:Context3D;
      
      public var atlasManager:AtlasManager;
      
      public function GpuContext()
      {
         super();
      }
      
      public function init() : void
      {
         stage3D = Environment.stage.stage3Ds[0];
         stage3D.addEventListener("error",onContext3DError);
         stage3D.addEventListener("context3DCreate",onContext3DCreated,false,11);
         profile = PROFILES[Environment.hiRes ? 0 : 1];
         stage3D.requestContext3D("auto",profile);
      }
      
      public function onContext3DCreated(param1:Event) : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         param1.stopImmediatePropagation();
         var _loc3_:Context3D = context3D;
         context3D = stage3D.context3D;
         _loc4_ = 2048;
         _loc2_ = 1300;
         context3D.configureBackBuffer(_loc4_,_loc2_,0,false);
         if(AtlasManager.INSTANCE)
         {
            atlasManager = AtlasManager.INSTANCE;
         }
         else if(profile == PROFILES[0])
         {
            atlasManager = new StarlingAtlasManager(4096,2);
         }
         else
         {
            atlasManager = new StarlingAtlasManager(2048,4);
         }
         if(_loc3_)
         {
            atlasManager.onContextLoss();
         }
         else
         {
            atlasManager.onContextComplete();
         }
         dispatchEvent(new Event("complete"));
      }
      
      private function onContext3DError(param1:ErrorEvent) : void
      {
         trace("!!!CONTEXT3D ERROR!!! id:" + param1.errorID);
      }
   }
}

