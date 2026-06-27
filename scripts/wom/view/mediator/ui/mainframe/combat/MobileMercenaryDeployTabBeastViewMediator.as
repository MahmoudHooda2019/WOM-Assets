package wom.view.mediator.ui.mainframe.combat
{
   import starling.events.Event;
   import wom.controller.event.GameModeChangedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.beast.BeastDeploymentEvent;
   import wom.controller.event.combat.CombatEventItemsEvent;
   import wom.controller.event.unit.ChooseAttackingSoldierEvent;
   import wom.model.component.CoreManager;
   import wom.model.domain.DomainInfo;
   import wom.model.game.AttackInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.attack.GameModeType;
   import wom.model.game.unit.UnitStatusType;
   import wom.view.mediator.ui.common.MobileMercenaryButtonViewMediator;
   import wom.view.ui.mainframe.combat.tooltip.MobileMercenaryDeployTabBeastView;
   
   public class MobileMercenaryDeployTabBeastViewMediator extends MobileMercenaryButtonViewMediator
   {
      
      [Inject]
      public var view:MobileMercenaryDeployTabBeastView;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var coreManager:CoreManager;
      
      [Inject]
      public var attackInfo:AttackInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function MobileMercenaryDeployTabBeastViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         onGameModeChange(null);
         eventMap.mapStarlingListener(view.mercButton,"change",onDeployButtonClicked,Event);
         addContextListener("attackInfoUpdated",onAttackInfoUpdated,ModelUpdateEvent);
         addContextListener("attackingUnitUpdated",onAttackInfoUpdated,ModelUpdateEvent);
         addContextListener("beastHealthUpdated",onBeastHealthUpdated,ModelUpdateEvent);
         addContextListener("itemsTabOpened",onItemsTabOpened,CombatEventItemsEvent);
         addContextListener("chooseAttackingSoldierEvent",onChooseAttackingSoldier);
         addContextListener("gameModeChange",onGameModeChange);
         updateDeployButton();
      }
      
      private function onChooseAttackingSoldier(param1:ChooseAttackingSoldierEvent) : void
      {
         if(param1.select && MobileMercenaryDeployTabBeastView.buttonState == 1)
         {
            view.switchButtonState(1);
         }
      }
      
      private function onGameModeChange(param1:GameModeChangedEvent) : void
      {
         var _loc2_:Boolean = userInfo.gameMode == GameModeType.VISIT;
         view.mercenaryPortrait.alpha = _loc2_ ? 0.5 : 1;
         view.mercButton.isEnabled = !_loc2_;
      }
      
      private function onAttackInfoUpdated(param1:ModelUpdateEvent) : void
      {
         updateDeployButton();
      }
      
      private function onBeastHealthUpdated(param1:ModelUpdateEvent) : void
      {
         updateDeployButton();
      }
      
      public function updateDeployButton() : void
      {
         if(attackInfo.beast)
         {
            if(attackInfo.beast.status == UnitStatusType.ATTACKING)
            {
               view.switchButtonState(3);
            }
            else if(attackInfo.beast.status == UnitStatusType.DEPLOYING)
            {
               view.switchButtonState(2);
            }
            else if(attackInfo.beast.status == UnitStatusType.WAITING_TO_DEPLOY)
            {
               view.switchButtonState(1);
            }
            else if(attackInfo.beast.healthPoints <= 1)
            {
               view.switchButtonState(5);
            }
            else if(attackInfo.beast.status == UnitStatusType.RETREATED)
            {
               view.switchButtonState(4);
            }
         }
      }
      
      private function onDeployButtonClicked(param1:Event) : void
      {
         if(view.selectByTouch)
         {
            if(attackInfo.beast)
            {
               if(attackInfo.beast.status == UnitStatusType.ATTACKING)
               {
                  dispatch(new BeastDeploymentEvent("beastDeploymentChoose",view.beastInfo.typeId,"beastDeploymentRetreat"));
                  view.mercButton.isEnabled = false;
               }
               else if(attackInfo.beast.status == UnitStatusType.DEPLOYING)
               {
                  dispatch(new BeastDeploymentEvent("beastDeploymentChoose",view.beastInfo.typeId,"beastDeploymentHold"));
               }
               else if(attackInfo.beast.status == UnitStatusType.WAITING_TO_DEPLOY)
               {
                  dispatch(new BeastDeploymentEvent("beastDeploymentChoose",view.beastInfo.typeId,"beastDeploymentDeploy"));
               }
            }
            view.updateFilters();
         }
      }
      
      private function onItemsTabOpened(param1:CombatEventItemsEvent) : void
      {
         if(attackInfo.beast)
         {
            if(attackInfo.beast.status == UnitStatusType.DEPLOYING)
            {
               dispatch(new BeastDeploymentEvent("beastDeploymentChoose",view.beastInfo.typeId,"beastDeploymentHold"));
            }
         }
      }
   }
}

