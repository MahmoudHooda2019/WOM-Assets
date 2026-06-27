package wom.view.mediator.ui.mainframe.combat
{
   import flash.events.TimerEvent;
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import starling.events.Event;
   import wom.controller.event.ActivateScreenEvent;
   import wom.controller.event.GameModeChangedEvent;
   import wom.controller.event.GameTickEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.combat.CombatEventItemsEvent;
   import wom.controller.event.combat.CombatHelpTextEvent;
   import wom.controller.event.combat.StartAttackEvent;
   import wom.controller.event.visit.EndVisitEvent;
   import wom.model.component.CoreManager;
   import wom.model.component.CuckooNotifier;
   import wom.model.domain.DomainInfo;
   import wom.model.game.AttackInfo;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.VisitInfo;
   import wom.model.game.WomScreenType;
   import wom.model.game.attack.GameModeType;
   import wom.model.message.request.ExtendBattleDurationRequest;
   import wom.model.message.request.StartQuickAttackRequest;
   import wom.service.kontagent.WomKontagentApi;
   import wom.view.ui.mainframe.combat.MobileCombatMenuPanel;
   import wom.view.ui.mainframe.combat.tooltip.MobileMercenaryDeployTabBeastView;
   
   public class MobileCombatMenuPanelMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileCombatMenuPanel;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var attackInfo:AttackInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var coreManager:CoreManager;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var visitInfo:VisitInfo;
      
      [Inject]
      public var kontagentApi:WomKontagentApi;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      public function MobileCombatMenuPanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         injector.injectInto(view);
         view.updateQuickAttackInfo(attackInfo.isQuickAttack);
         gameModeChanged();
         addListeners();
         determineButtonsStatus();
      }
      
      public function addListeners() : void
      {
         eventMap.mapStarlingListener(view.endAttackButton,"triggered",onEndAttackButtonClicked,Event);
         eventMap.mapStarlingListener(view.nextTargetButton,"triggered",onNextQuickAttackButtonClicked,Event);
         eventMap.mapStarlingListener(view.spyButton,"triggered",onSpyButtonClicked,Event);
         eventMap.mapStarlingListener(view.extendButton,"triggered",onExtendButtonClicked,Event);
         eventMap.mapStarlingListener(view.warMenuButton,"triggered",onWarButtonClicked,Event);
         eventMap.mapStarlingListener(view.homeMenuButton,"triggered",onHomeButtonClicked,Event);
         eventMap.mapStarlingListener(view.eventItemsButton,"triggered",onEventItemsButtonClilcked,Event);
         eventMap.mapStarlingListener(view.backToArmyButton,"triggered",onBackToArmyButtonClilcked,Event);
         eventMap.mapListener(view.endAttackEnablingTimer,"timer",onTimerComplete,TimerEvent);
         addContextListener("attackInfoUpdated",onAttackInfoUpdated);
         addContextListener("spyStatusChange",onSpyStatusChange,ModelUpdateEvent);
         addContextListener("gameModeChange",onGameModeChange,GameModeChangedEvent);
      }
      
      private function onTimerComplete(param1:TimerEvent) : void
      {
         view.onEndAttackEnablingTimerComplete(userInfo.mandatoryTutorialCompleted);
      }
      
      override public function onRemove() : void
      {
         super.onRemove();
         if(view.warMenuButton.isEnabled)
         {
            dispatch(new CombatHelpTextEvent("tapWarButtonText",false));
         }
         else
         {
            dispatch(new CombatHelpTextEvent("cityOutOfReachText",false));
         }
      }
      
      private function onSpyButtonClicked(param1:Event) : void
      {
         if(!userInfo.mandatoryTutorialCompleted)
         {
            return;
         }
         if(userInfo.gameMode == GameModeType.VISIT)
         {
            dispatch(new StartAttackEvent("startSpying",visitInfo.landlord,visitInfo.landlord.isNpc));
         }
         else
         {
            dispatch(new StartAttackEvent("startSpying",attackInfo.defender,attackInfo.defender.isNpc));
         }
      }
      
      private function onSpyStatusChange(param1:ModelUpdateEvent) : void
      {
         determineButtonsStatus();
      }
      
      private function determineButtonsStatus() : void
      {
         if(userInfo.mandatoryTutorialCompleted)
         {
            view.updateSpyButtonEnabling(!city.spyEnabled,userInfo.gameMode == GameModeType.TUSK_HORN);
         }
         view.extendButton.isEnabled = userInfo.numberOfGolds >= 10;
         view.updateEventItemsButtonEnabling(domainInfo.getEventItems(),userInfo.gameMode == GameModeType.TUSK_HORN,userInfo.mandatoryTutorialCompleted);
      }
      
      private function onAttackInfoUpdated(param1:ModelUpdateEvent) : void
      {
         view.updatePanelState(attackInfo);
         determineButtonsStatus();
         if(!attackInfo.attackEndTimeExtended && attackInfo.deployPassed)
         {
            addContextListener("tick",onTick,GameTickEvent);
         }
      }
      
      private function onTick(param1:GameTickEvent) : void
      {
         view.updatePanelState(attackInfo);
      }
      
      private function onEndAttackButtonClicked(param1:Event) : void
      {
         if(!userInfo.mandatoryTutorialCompleted)
         {
            return;
         }
         MobileMercenaryDeployTabBeastView.buttonState = 1;
         CuckooNotifier.getInstance().onTimerCompleteAndEndAttack(null);
      }
      
      private function onNextQuickAttackButtonClicked(param1:Event) : void
      {
         if(!userInfo.mandatoryTutorialCompleted)
         {
            return;
         }
         kontagentApi.trackUIEvent("war","smart_attack");
         dispatch(new OutgoingMessageEvent("outgoingMessage",new StartQuickAttackRequest()));
         dispatch(new ActivateScreenEvent("activate",WomScreenType.LOADING));
      }
      
      private function onExtendButtonClicked(param1:Event) : void
      {
         if(!userInfo.mandatoryTutorialCompleted)
         {
            return;
         }
         dispatch(new OutgoingMessageEvent("outgoingMessage",new ExtendBattleDurationRequest()));
         view.extendButton.isEnabled = false;
      }
      
      private function onHomeButtonClicked(param1:Event) : void
      {
         if(!userInfo.mandatoryTutorialCompleted)
         {
            return;
         }
         kontagentApi.trackUIEvent("war","return");
         dispatch(new EndVisitEvent("endVisit"));
      }
      
      private function onWarButtonClicked(param1:Event) : void
      {
         if(!userInfo.mandatoryTutorialCompleted)
         {
            return;
         }
         if(view.warMenuButton.isEnabled)
         {
            if(userInfo.mandatoryTutorialCompleted)
            {
               dispatch(new CombatHelpTextEvent("tapWarButtonText",false));
            }
            dispatch(new StartAttackEvent("startAttack",visitInfo.landlord,visitInfo.landlord.isNpc,false,true,false,false,userInfo.mapInCampaignMode));
         }
      }
      
      private function onGameModeChange(param1:GameModeChangedEvent) : void
      {
         gameModeChanged();
      }
      
      private function gameModeChanged() : void
      {
         if(userInfo.gameMode == GameModeType.VISIT)
         {
            view.scoutMode();
            view.updateWarButtonEnabling(visitInfo.isOutOfReachForAttack);
         }
         else if(userInfo.gameMode != GameModeType.NORMAL)
         {
            if(userInfo.mandatoryTutorialCompleted)
            {
               dispatch(new CombatHelpTextEvent("firstUnitDeployText",true));
            }
            view.attackMode();
         }
         view.updatePanelState(attackInfo);
         if(!userInfo.mandatoryTutorialCompleted)
         {
            view.endAttackButton.isEnabled = view.nextTargetButton.isEnabled = view.spyButton.isEnabled = view.warMenuButton.isEnabled = view.homeMenuButton.isEnabled = false;
         }
      }
      
      private function onEventItemsButtonClilcked(param1:Event) : void
      {
         view.updateEventItemsPanelVisibility(true,userInfo.mandatoryTutorialCompleted);
         dispatch(new CombatEventItemsEvent("itemsTabOpened",-1));
      }
      
      private function onBackToArmyButtonClilcked(param1:Event) : void
      {
         view.updateEventItemsPanelVisibility(false,userInfo.mandatoryTutorialCompleted);
         dispatch(new CombatEventItemsEvent("armyTabOpened",-1));
      }
   }
}

