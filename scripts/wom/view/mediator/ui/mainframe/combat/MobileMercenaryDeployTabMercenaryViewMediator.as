package wom.view.mediator.ui.mainframe.combat
{
   import starling.events.Event;
   import wom.controller.event.GameModeChangedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.beast.BeastDeploymentEvent;
   import wom.controller.event.combat.CombatEventItemsEvent;
   import wom.controller.event.unit.ChooseAttackingSoldierEvent;
   import wom.controller.event.unit.ResetAttackingSoldierEvent;
   import wom.model.component.CoreManager;
   import wom.model.domain.DomainInfo;
   import wom.model.game.AttackInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.attack.GameModeType;
   import wom.model.game.tutorial.TutorialInfo;
   import wom.model.game.unit.UnitInfo;
   import wom.model.game.unit.UnitStatusType;
   import wom.view.mediator.ui.common.MobileMercenaryButtonViewMediator;
   import wom.view.ui.mainframe.combat.MobileMercenaryDeployTabMercenaryView;
   
   public class MobileMercenaryDeployTabMercenaryViewMediator extends MobileMercenaryButtonViewMediator
   {
      
      [Inject]
      public var view:MobileMercenaryDeployTabMercenaryView;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var coreManager:CoreManager;
      
      [Inject]
      public var attackInfo:AttackInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function MobileMercenaryDeployTabMercenaryViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         view.unitLevel = attackInfo.unitTypes[view.unitTypeId].currentLevel;
         super.onRegister();
         injector.injectInto(view);
         calculateCount();
         onGameModeChange(null);
         onAttackInfoUpdated(null);
         addContextListener("resetSoldiers",onResetSelection,ResetAttackingSoldierEvent);
         addContextListener("attackInfoUpdated",onAttackInfoUpdated);
         addContextListener("attackingUnitUpdated",onAttackInfoUpdated);
         addContextListener("gameModeChange",onGameModeChange);
         addContextListener("chooseAttackingSoldierEvent",onChooseAttackingSoldier);
         addContextListener("beastDeploymentChoose",onBeastDeploymentEvent);
         addContextListener("itemsTabOpened",onItemsTabOpened,CombatEventItemsEvent);
         eventMap.mapStarlingListener(view.mercButton,"change",onButtonChange,Event);
      }
      
      private function onBeastDeploymentEvent(param1:BeastDeploymentEvent) : void
      {
         if(param1.eventName == "beastDeploymentDeploy" && view.mercButton.isSelected)
         {
            view.mercButton.isSelected = false;
            view.updateFilters();
         }
      }
      
      private function onChooseAttackingSoldier(param1:ChooseAttackingSoldierEvent) : void
      {
         if(param1.select && param1.unitTypeId != view.unitTypeId)
         {
            view.resetSelectionIfSelected();
         }
      }
      
      private function onGameModeChange(param1:GameModeChangedEvent) : void
      {
         var _loc2_:Boolean = userInfo.gameMode == GameModeType.VISIT;
         view.mercButton.isEnabled = !_loc2_;
         view.mercenaryPortrait.alpha = _loc2_ ? 0.5 : 1;
      }
      
      private function onAttackInfoUpdated(param1:ModelUpdateEvent) : void
      {
         calculateCount();
         if(view.totalCount == 0)
         {
            view.resetSelectionIfSelected();
         }
      }
      
      private function calculateCount() : void
      {
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         for each(var _loc1_ in attackInfo.units)
         {
            if(_loc1_.typeId == view.unitTypeId)
            {
               _loc2_ += _loc1_.status == UnitStatusType.DEPLOYING || _loc1_.status == UnitStatusType.WAITING_TO_DEPLOY ? 1 : 0;
               if(_loc1_.status == UnitStatusType.DEPLOYING)
               {
                  _loc3_ = true;
               }
            }
         }
         view.totalCount = _loc2_;
      }
      
      private function onButtonChange(param1:Event) : void
      {
         var _loc2_:Boolean = false;
         if((userInfo.gameMode == GameModeType.TUSK_HORN || userInfo.gameMode == GameModeType.ATTACK) && view.totalCount != 0)
         {
            if(view.selectByTouch)
            {
               _loc2_ = checkInTutorial();
               dispatch(new ChooseAttackingSoldierEvent("chooseAttackingSoldierEvent",view.unitTypeId,view.mercButton.isSelected || _loc2_,_loc2_));
            }
            else
            {
               view.selectByTouch = true;
            }
         }
         else
         {
            view.mercButton.isSelected = false;
         }
         view.updateFilters();
      }
      
      private function checkInTutorial() : Boolean
      {
         var _loc1_:TutorialInfo = null;
         if(userInfo.tutorialsInfo.enabled)
         {
            _loc1_ = "rev" in userInfo.tutorialsInfo.tutorials ? userInfo.tutorialsInfo.tutorials["rev"] : null;
            if(_loc1_ != null && !_loc1_.isCompleted)
            {
               return true;
            }
         }
         return false;
      }
      
      private function onItemsTabOpened(param1:CombatEventItemsEvent) : void
      {
         if(view.mercButton.isSelected)
         {
            dispatch(new ResetAttackingSoldierEvent("resetSoldiers"));
         }
      }
      
      private function onResetSelection(param1:ResetAttackingSoldierEvent) : void
      {
         view.resetSelectionIfSelected();
      }
   }
}

