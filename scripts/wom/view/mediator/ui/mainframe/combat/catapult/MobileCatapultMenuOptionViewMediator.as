package wom.view.mediator.ui.mainframe.combat.catapult
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import starling.events.Event;
   import wom.controller.event.GameModeChangedEvent;
   import wom.controller.event.beast.BeastDeploymentEvent;
   import wom.controller.event.unit.ResetAttackingSoldierEvent;
   import wom.model.component.CoreManager;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.CatapultTypeDIO;
   import wom.model.game.AttackInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.attack.GameModeType;
   import wom.model.game.resource.ResourceType;
   import wom.model.game.unit.UnitStatusType;
   import wom.view.ui.mainframe.combat.catapult.MobileCatapultMenuOptionView;
   
   public class MobileCatapultMenuOptionViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileCatapultMenuOptionView;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var coreManager:CoreManager;
      
      [Inject]
      public var attackInfo:AttackInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      public function MobileCatapultMenuOptionViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         injector.injectInto(view);
         view.updateCost((domainInfo.getCatapults()[view.type] as CatapultTypeDIO).resourceCosts[view.size][0].resourceAmount);
         eventMap.mapStarlingListener(view.button,"triggered",onOptionClicked,Event);
         determineViewState(null);
         addContextListener("gameModeChange",determineViewState,GameModeChangedEvent);
      }
      
      private function determineViewState(param1:GameModeChangedEvent) : void
      {
         if(userInfo.gameMode == GameModeType.ATTACK && attackInfo.attackingUserResources && (view.type == 1 && attackInfo.attackingUserResources[ResourceType.LUMBER.id] < view.cost || view.type == 2 && attackInfo.attackingUserResources[ResourceType.STONE.id] < view.cost || view.type == 3 && attackInfo.attackingUserResources[ResourceType.MIGHT.id] < view.cost))
         {
            view.disable();
         }
      }
      
      private function onOptionClicked(param1:Event) : void
      {
         if(view.available)
         {
            view.optionsWindow.visible = false;
            view.optionsWindow.catapultMenuView.switchButtonState(0);
            view.optionsWindow.catapultMenuView.button.isSelected = false;
            dispatch(new ResetAttackingSoldierEvent("resetSoldiers"));
            if(attackInfo.beast && attackInfo.beast.status == UnitStatusType.DEPLOYING)
            {
               dispatch(new BeastDeploymentEvent("beastDeploymentChoose",attackInfo.beast.typeId,"beastDeploymentHold"));
            }
            coreManager.handleCatapultAction(view.type,view.size);
         }
      }
   }
}

