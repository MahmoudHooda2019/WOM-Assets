package wom.view.mediator.ui.mainframe.combat.eventitems
{
   import wom.controller.event.combat.CombatEventItemsEvent;
   import wom.controller.event.unit.ChooseAttackingSoldierEvent;
   import wom.model.domain.DomainInfo;
   import wom.view.ui.mainframe.combat.eventitems.MobileMercenaryEventItemView;
   
   public class MobileMercenaryEventItemViewMediator extends MobileCombatEventItemViewMediator
   {
      
      [Inject]
      public var view:MobileMercenaryEventItemView;
      
      [Inject]
      public var domain:DomainInfo;
      
      public function MobileMercenaryEventItemViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         view.unitTypeDIO = domain.getUnit(view.relatedId);
         view.unitTypeInfo = city.unitTypes[view.unitTypeDIO.id];
         super.onRegister();
      }
      
      override protected function selectView() : void
      {
         if(view.enabled)
         {
            super.selectView();
            dispatch(new ChooseAttackingSoldierEvent("chooseAttackingSoldierEvent",combatEventItemView.eventItemDIO.relatedId,true));
            dispatch(new CombatEventItemsEvent("mercenarySelected",view.eventItemDIO.relatedId));
         }
      }
      
      override protected function cancelSelection(param1:Boolean = false) : void
      {
         if(view.selected || param1)
         {
            super.cancelSelection(param1);
            if(param1)
            {
               dispatch(new ChooseAttackingSoldierEvent("chooseAttackingSoldierEvent",combatEventItemView.eventItemDIO.relatedId,false));
            }
         }
      }
   }
}

