package wom.view.screen
{
   import peak.cuckoo.game.behavior.render.gpu.GpuRender;
   import wom.model.game.WomGameRootHolder;
   
   public class MobileCityScreen extends MobileBaseScreen
   {
      
      public static const MARGIN:int = 0;
      
      [Inject]
      public var gameRootHolder:WomGameRootHolder;
      
      public function MobileCityScreen()
      {
         super();
      }
      
      [PostConstruct]
      public function postConstruct() : void
      {
         addChild((gameRootHolder.gameRoot.componentManager["BaseRender"] as GpuRender).starlingOverlay);
      }
      
      override public function destroy() : void
      {
         removeChild((gameRootHolder.gameRoot.componentManager["BaseRender"] as GpuRender).starlingOverlay);
      }
   }
}

