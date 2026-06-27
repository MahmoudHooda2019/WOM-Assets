package wom.view.mediator.screen.popups
{
   import starling.events.Event;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.MobileFeatureAvailablePopUp;
   
   public class MobileFeatureAvailablePopUpMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileFeatureAvailablePopUp;
      
      public function MobileFeatureAvailablePopUpMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.imageAsset,"change",onAssetChanged,Event);
         eventMap.mapStarlingListener(view.actionButton,"triggered",onActionButtonClicked,Event);
      }
      
      private function onAssetChanged(param1:Event) : void
      {
         view.drawLayout();
      }
      
      private function onActionButtonClicked(param1:Event) : void
      {
         closeWindow();
      }
      
      override protected function closeWindow() : void
      {
         super.closeWindow();
      }
   }
}

