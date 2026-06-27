package wom.controller.command.combat
{
   import wom.controller.PCommand;
   import wom.model.game.WomGameRootHolder;
   
   public class EndDeploymentCommand extends PCommand
   {
      
      [Inject]
      public var gameRootHolder:WomGameRootHolder;
      
      public function EndDeploymentCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         gameRootHolder.gameRoot.battleManager.battleFieldControl.checkAllUnitDied();
      }
   }
}

