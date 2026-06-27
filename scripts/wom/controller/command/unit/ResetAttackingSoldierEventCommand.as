package wom.controller.command.unit
{
   import wom.controller.PCommand;
   import wom.controller.event.unit.ResetAttackingSoldierEvent;
   import wom.model.component.CoreManager;
   import wom.model.domain.DomainInfo;
   import wom.model.game.AttackInfo;
   
   public class ResetAttackingSoldierEventCommand extends PCommand
   {
      
      [Inject]
      public var event:ResetAttackingSoldierEvent;
      
      [Inject]
      public var attackInfo:AttackInfo;
      
      [Inject]
      public var coreManager:CoreManager;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      public function ResetAttackingSoldierEventCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         coreManager.setDeployDiameter(0,0);
      }
   }
}

