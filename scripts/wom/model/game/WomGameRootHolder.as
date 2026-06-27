package wom.model.game
{
   import org.robotlegs.core.IInjector;
   import wom.model.component.WomGameRoot;
   
   public class WomGameRootHolder
   {
      
      public var gameRoot:WomGameRoot;
      
      [Inject]
      public var injector:IInjector;
      
      public function WomGameRootHolder()
      {
         super();
      }
      
      public function init() : void
      {
         if(gameRoot)
         {
            gameRoot.reset();
            gameRoot.init();
         }
         else
         {
            gameRoot = new WomGameRoot();
            injector.injectInto(gameRoot);
            gameRoot.init();
         }
      }
   }
}

