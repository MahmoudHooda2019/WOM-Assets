package wom.view.mediator.screen.popups.topoff
{
   import flash.utils.setTimeout;
   import starling.events.Event;
   import wom.controller.event.ui.ActionSelectEvent;
   import wom.model.component.CoreManager;
   import wom.model.component.enum.ActionType;
   import wom.model.game.gold.MonetizationType;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.screen.popups.topoff.MobileConstructTopOffResourcesPopUp;
   
   public class MobileConstructTopOffResourcesPopUpMediator extends MobileBaseTopOffResourcesPopUpMediator
   {
      
      [Inject]
      public var view:MobileConstructTopOffResourcesPopUp;
      
      [Inject]
      public var coreManager:CoreManager;
      
      public function MobileConstructTopOffResourcesPopUpMediator()
      {
         super();
      }
      
      override protected function onConfirmButtonClicked(param1:Event) : void
      {
         if(view.requiredGold > userInfo.numberOfGolds)
         {
            view.addWindowEnumeration(new WindowEnumeration(0,{"womview":view}));
            view.addWindowEnumeration(new WindowEnumeration(42,{"type":MonetizationType.NOT_ENOUGH_GOLD}));
            closeWindow();
            return;
         }
         if(view.windowEnumerations)
         {
            view.windowEnumerations.length = 0;
         }
         closeWindow();
         dispatch(new ActionSelectEvent("actionSelect",ActionType.BUILD));
         setTimeout(startBuildWithDelay,1);
      }
      
      private function startBuildWithDelay() : void
      {
         coreManager.startBuild(view.buildingTypeId,false,true);
      }
   }
}

