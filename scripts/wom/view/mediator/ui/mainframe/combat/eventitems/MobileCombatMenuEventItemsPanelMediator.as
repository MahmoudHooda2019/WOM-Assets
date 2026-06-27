package wom.view.mediator.ui.mainframe.combat.eventitems
{
   import peak.i18n.PText;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.combat.CombatEventItemsEvent;
   import wom.controller.event.ui.MobileUINotificationEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.game.AttackInfo;
   import wom.model.game.UserInfo;
   import wom.view.component.button.MobileWomButton;
   import wom.view.mediator.ui.mainframe.combat.MobileBaseBottomMainframePanelMediator;
   import wom.view.ui.mainframe.combat.eventitems.MobileCombatEventItemView;
   import wom.view.ui.mainframe.combat.eventitems.MobileCombatMenuEventItemsPanel;
   
   public class MobileCombatMenuEventItemsPanelMediator extends MobileBaseBottomMainframePanelMediator
   {
      
      [Inject]
      public var view:MobileCombatMenuEventItemsPanel;
      
      [Inject]
      public var attackInfo:AttackInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      public function MobileCombatMenuEventItemsPanelMediator()
      {
         super();
      }
      
      override protected function mapPanelSpecificListeners() : void
      {
         addContextListener("itemDeployed",onItemUsed,CombatEventItemsEvent);
         addContextListener("attackInfoUpdated",onAttackInfoUpdated);
      }
      
      private function onItemUsed(param1:CombatEventItemsEvent) : void
      {
         view.itemUsed(param1.relatedId);
      }
      
      private function checkForWarning(param1:TouchEvent) : void
      {
         var _loc2_:Touch = param1.getTouch(param1.target as MobileWomButton,"ended");
         if(_loc2_)
         {
            if(view.maxNumberOfEventItemDeployReached)
            {
               var _temp_3:* = §§findproperty(MobileUINotificationEvent);
               var _temp_2:* = "mobileUINotificationEventShow";
               var _temp_1:* = "m.ui.warning.itemdeploylimit";
               var _loc3_:int = 3;
               var _loc4_:String = _temp_1;
               dispatch(new MobileUINotificationEvent(_temp_2,peak.i18n.PText.INSTANCE.getText1(_loc4_,_loc3_)));
            }
         }
      }
      
      override protected function updateViews() : void
      {
         if(attackInfo.deployPassed)
         {
            view.clearViews();
            view.visible = false;
         }
         else
         {
            view.updateWithEventItems(domainInfo.getEventItems(),attackInfo.eventItemCounts);
            for each(var _loc1_ in view.eventItemViews)
            {
               eventMap.mapStarlingListener(_loc1_.mercButton,"touch",checkForWarning,TouchEvent);
            }
         }
      }
      
      private function onAttackInfoUpdated(param1:ModelUpdateEvent) : void
      {
         if(attackInfo.deployPassed)
         {
            view.visible = false;
         }
      }
   }
}

