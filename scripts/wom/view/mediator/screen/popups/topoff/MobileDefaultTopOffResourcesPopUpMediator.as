package wom.view.mediator.screen.popups.topoff
{
   import starling.events.Event;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.model.game.gold.MonetizationType;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.screen.popups.topoff.MobileDefaultTopOffResourcesPopUp;
   
   public class MobileDefaultTopOffResourcesPopUpMediator extends MobileBaseTopOffResourcesPopUpMediator
   {
      
      [Inject]
      public var view:MobileDefaultTopOffResourcesPopUp;
      
      public function MobileDefaultTopOffResourcesPopUpMediator()
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
         if(view.windowEnumerations && view.type != "blacksmith")
         {
            view.windowEnumerations.length = 0;
         }
         closeWindow();
         eventDispatcher.dispatchEvent(new OutgoingMessageEvent("outgoingMessage",view.outgoingMessage));
      }
   }
}

