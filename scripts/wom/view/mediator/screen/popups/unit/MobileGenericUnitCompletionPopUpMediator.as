package wom.view.mediator.screen.popups.unit
{
   import starling.events.Event;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.unit.MobileGenericUnitCompletionPopUp;
   
   public class MobileGenericUnitCompletionPopUpMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileGenericUnitCompletionPopUp;
      
      public function MobileGenericUnitCompletionPopUpMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.imageAsset,"change",onAssetChanged,Event);
         eventMap.mapStarlingListener(view.actionButton,"triggered",onWarnYourFriendsButtonClicked,Event);
      }
      
      private function onAssetChanged(param1:Event) : void
      {
         view.drawLayout();
      }
      
      protected function onWarnYourFriendsButtonClicked(param1:Event) : void
      {
         closeWindow();
      }
   }
}

