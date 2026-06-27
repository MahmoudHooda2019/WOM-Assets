package wom.view.mediator.ui.mainframe.combat.eventitems
{
   import wom.controller.event.combat.CombatEventItemsEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.EventItemDIO;
   import wom.view.ui.mainframe.combat.eventitems.MobileCombatBuildingEventItemView;
   
   public class MobileCombatBuildingEventItemViewMediator extends MobileCombatEventItemViewMediator
   {
      
      [Inject]
      public var view:MobileCombatBuildingEventItemView;
      
      [Inject]
      public var domain:DomainInfo;
      
      public function MobileCombatBuildingEventItemViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         view.unitTypeDIO = domain.getUnit(view.relatedId);
         super.onRegister();
      }
      
      override protected function selectView() : void
      {
         var _loc1_:EventItemDIO = null;
         if(view.enabled)
         {
            super.selectView();
            _loc1_ = domainInfo.getEventItem(view.eventItemDIO.id);
            dispatch(new CombatEventItemsEvent("combatBuildingSelected",_loc1_.relatedId));
            if(_loc1_.warBuilding)
            {
               gameRootHolder.gameRoot.eventItemsManager.deployWarBuilding(_loc1_.relatedId == 34);
            }
         }
      }
      
      override protected function cancelSelection(param1:Boolean = false) : void
      {
         var _loc2_:EventItemDIO = null;
         if(view.selected || param1)
         {
            super.cancelSelection(param1);
            _loc2_ = domainInfo.getEventItem(view.eventItemDIO.id);
            if(_loc2_.warBuilding)
            {
               gameRootHolder.gameRoot.eventItemsManager.cancelDeployWarBuilding();
            }
         }
      }
   }
}

