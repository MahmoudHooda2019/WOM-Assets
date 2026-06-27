package wom.controller.command.beast
{
   import wom.controller.PCommand;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.beast.BeastDeploymentEvent;
   import wom.model.component.CoreManager;
   import wom.model.domain.DomainInfo;
   import wom.model.game.AttackInfo;
   import wom.model.game.beast.BeastInfo;
   import wom.model.game.unit.UnitInfo;
   import wom.model.game.unit.UnitStatusType;
   
   public class HandleBeastDeploymentEventCommand extends PCommand
   {
      
      [Inject]
      public var event:BeastDeploymentEvent;
      
      [Inject]
      public var attackInfo:AttackInfo;
      
      [Inject]
      public var coreManager:CoreManager;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      public function HandleBeastDeploymentEventCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:BeastInfo = null;
         var _loc3_:int = 0;
         if(event.eventName == "beastDeploymentRetreat")
         {
            coreManager.retreatBeast();
         }
         else
         {
            _loc1_ = attackInfo.beast;
            _loc3_ = 24;
            for each(var _loc2_ in attackInfo.units)
            {
               if(_loc2_.status == UnitStatusType.DEPLOYING)
               {
                  _loc2_.status = UnitStatusType.WAITING_TO_DEPLOY;
               }
            }
            if(_loc1_)
            {
               if(event.eventName == "beastDeploymentDeploy" && _loc1_.status == UnitStatusType.WAITING_TO_DEPLOY)
               {
                  _loc1_.status = UnitStatusType.DEPLOYING;
                  coreManager.setDeployDiameter(_loc3_,1);
               }
               else if(event.eventName == "beastDeploymentHold" && _loc1_.status == UnitStatusType.DEPLOYING)
               {
                  _loc1_.status = UnitStatusType.WAITING_TO_DEPLOY;
                  coreManager.setDeployDiameter(0,1);
               }
            }
         }
         dispatch(new ModelUpdateEvent("attackingUnitUpdated"));
      }
   }
}

