package wom.view.mediator.screen.popups
{
   import starling.events.Event;
   import wom.controller.event.beast.BeastActionEvent;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.MobileBeastConfirmationPopUp;
   
   public class MobileBeastConfirmationPopUpMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileBeastConfirmationPopUp;
      
      public function MobileBeastConfirmationPopUpMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.actionButton,"triggered",onBuyButtonClicked,Event);
      }
      
      private function onBuyButtonClicked(param1:Event) : void
      {
         if(view.confirmType == 0)
         {
            dispatch(new BeastActionEvent("beastAction","heal"));
         }
         else if(view.confirmType == 1 || view.confirmType == 2)
         {
            dispatch(new BeastActionEvent("beastAction","evolve"));
         }
         closeWindow();
      }
   }
}

