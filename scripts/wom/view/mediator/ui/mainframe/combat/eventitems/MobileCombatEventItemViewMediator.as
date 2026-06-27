package wom.view.mediator.ui.mainframe.combat.eventitems
{
   import flash.events.MouseEvent;
   import peak.logging.LoggerContext;
   import peak.logging.LoggerContexts;
   import peak.logging.log;
   import starling.events.Event;
   import wom.controller.event.GameModeChangedEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.combat.CombatEventItemsEvent;
   import wom.controller.event.combat.EndAttackEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.game.AttackInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.WomGameRootHolder;
   import wom.model.game.attack.GameModeType;
   import wom.model.message.request.UseEventItemRequest;
   import wom.service.logging.WomLoggerContexts;
   import wom.view.mediator.ui.common.MobileMercenaryButtonViewMediator;
   import wom.view.ui.mainframe.combat.eventitems.MobileCombatEventItemView;
   
   public class MobileCombatEventItemViewMediator extends MobileMercenaryButtonViewMediator
   {
      
      [Inject]
      public var combatEventItemView:MobileCombatEventItemView;
      
      [Inject]
      public var gameRootHolder:WomGameRootHolder;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var attackInfo:AttackInfo;
      
      public function MobileCombatEventItemViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         onGameModeChange(null);
         mapEvents();
      }
      
      protected function mapEvents() : void
      {
         addContextListener("gameModeChange",onGameModeChange,GameModeChangedEvent);
         addContextListener("itemDeployed",onItemDeployed,CombatEventItemsEvent);
         addContextListener("armyTabOpened",onSelectionCancellingEventOccured,CombatEventItemsEvent);
         eventMap.mapStarlingListener(combatEventItemView.mercButton,"change",onViewChanged,Event);
         addContextListener("catapultSelected",onSelectionCancellingEventOccured,CombatEventItemsEvent);
         addContextListener("combatBuildingSelected",onSelectionCancellingEventOccured,CombatEventItemsEvent);
         addContextListener("mercenarySelected",onSelectionCancellingEventOccured,CombatEventItemsEvent);
         addContextListener("itemDeployIsCancelled",onSelectionCancellingEventOccured,CombatEventItemsEvent);
         addContextListener("endAttack",onAttackEnded,EndAttackEvent);
      }
      
      private function onGameModeChange(param1:GameModeChangedEvent) : void
      {
         var _loc2_:Boolean = userInfo.gameMode == GameModeType.VISIT;
         combatEventItemView.alpha = _loc2_ ? 0.5 : 1;
      }
      
      protected function onViewChanged(param1:Event) : void
      {
         if(combatEventItemView.enabled)
         {
            if(combatEventItemView.selected)
            {
               selectView();
            }
            else
            {
               cancelSelection(true);
            }
         }
         else
         {
            removeViewListener("change",onViewChanged,Event);
         }
         combatEventItemView.updateFilters();
      }
      
      protected function selectView() : void
      {
         combatEventItemView.updateFilters();
      }
      
      protected function cancelSelection(param1:Boolean = false) : void
      {
         if(combatEventItemView.selected)
         {
            combatEventItemView.updateSelection(false);
         }
         combatEventItemView.updateFilters();
      }
      
      protected function onItemDeployed(param1:CombatEventItemsEvent) : void
      {
         if(combatEventItemView.eventItemDIO.relatedId == param1.relatedId && combatEventItemView.selected)
         {
            if(attackInfo.eventItemCounts[combatEventItemView.eventItemDIO.id] > 0)
            {
               combatEventItemView.updateItemCount(attackInfo.eventItemCounts[combatEventItemView.eventItemDIO.id] - 1);
               combatEventItemView.updateSelection(false);
               updateItemUsed(true);
               dispatch(new OutgoingMessageEvent("outgoingMessage",new UseEventItemRequest(combatEventItemView.eventItemDIO.id)));
            }
            else
            {
               log(LoggerContext.combine(WomLoggerContexts.GAME,LoggerContexts.UNEXPECTED),"Combat item used when count is: " + attackInfo.eventItemCounts[combatEventItemView.eventItemDIO.id]);
            }
         }
      }
      
      private function updateItemUsed(param1:Boolean) : void
      {
         combatEventItemView.updateItemUsed(param1);
         if(param1)
         {
            removeViewListener("click",onViewChanged,MouseEvent);
         }
      }
      
      protected function onSelectionCancellingEventOccured(param1:CombatEventItemsEvent) : void
      {
         if(param1.relatedId != combatEventItemView.eventItemDIO.relatedId)
         {
            cancelSelection();
         }
      }
      
      private function onAttackEnded(param1:EndAttackEvent) : void
      {
         cancelSelection();
      }
   }
}

