package wom.view.mediator.screen.windows.beast.keeper
{
   import starling.events.Event;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.windows.beast.keeper.MobileBeastKeeperWindow;
   
   public class MobileBeastKeeperWindowMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileBeastKeeperWindow;
      
      public function MobileBeastKeeperWindowMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.hintButton,"triggered",onHintClicked,Event);
      }
      
      private function onHintClicked(param1:Event) : void
      {
         view.onHint();
      }
   }
}

