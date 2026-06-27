package wom.model.component.behavior.battle
{
   import peak.cuckoo.core.Behavior;
   import peak.cuckoo.game.behavior.FpsSync;
   import wom.model.component.WomGameRoot;
   
   public class AutoDeployer extends Behavior
   {
      
      public static const TYPE_ID:String = "AutoDeployer";
      
      public static const DEPLOY_PERIOD:int = 6;
      
      public static const INITIAL_DEPLOY_PERIOD:int = 25;
      
      private var battleManager:BattleManager;
      
      private var wait:Number;
      
      private var fpsSync:FpsSync;
      
      public var deployDone:Boolean = false;
      
      public var deployCount:int;
      
      public var deployStarted:Boolean;
      
      public function AutoDeployer()
      {
         super();
         priority = 3;
         startEnabled = false;
      }
      
      override public function get typeId() : String
      {
         return "AutoDeployer";
      }
      
      override public function init() : void
      {
         super.init();
         battleManager = (owner.root as WomGameRoot).battleManager;
         fpsSync = (owner.root as WomGameRoot).sync;
         wait = 25;
         deployDone = false;
         deployCount = 0;
      }
      
      override public function update() : void
      {
         super.update();
         if(wait > 0)
         {
            wait -= fpsSync.precise;
            return;
         }
         deployDone = true;
         deployStarted = true;
         battleManager.deploy();
         deployCount = deployCount + 1;
         wait = 6 - int(deployCount / 5);
      }
      
      override public function enable() : void
      {
         super.enable();
         wait = 25;
         deployDone = false;
         deployCount = 0;
      }
      
      override public function disable() : void
      {
         super.disable();
         deployStarted = false;
      }
   }
}

