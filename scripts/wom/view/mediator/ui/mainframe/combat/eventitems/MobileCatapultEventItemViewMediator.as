package wom.view.mediator.ui.mainframe.combat.eventitems
{
   import wom.controller.event.combat.CombatEventItemsEvent;
   import wom.model.component.CoreManager;
   import wom.model.domain.domaininfoobject.EventItemDIO;
   import wom.view.ui.mainframe.combat.eventitems.MobileCatapultEventItemView;
   
   public class MobileCatapultEventItemViewMediator extends MobileCombatEventItemViewMediator
   {
      
      [Inject]
      public var view:MobileCatapultEventItemView;
      
      [Inject]
      public var coreManager:CoreManager;
      
      public function MobileCatapultEventItemViewMediator()
      {
         super();
      }
      
      override protected function selectView() : void
      {
         var _loc1_:EventItemDIO = null;
         if(view.enabled)
         {
            super.selectView();
            _loc1_ = domainInfo.getEventItem(view.eventItemDIO.id);
            dispatch(new CombatEventItemsEvent("catapultSelected",_loc1_.relatedId));
            coreManager.handleCatapultAction(_loc1_.relatedId,0);
         }
      }
      
      override protected function cancelSelection(param1:Boolean = false) : void
      {
         if(view.selected || param1)
         {
            super.cancelSelection(param1);
            coreManager.setDeployDiameter(0,0);
         }
      }
   }
}

