package wom.view.mediator.screen.windows.cityplanner
{
   import starling.events.Event;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.windows.cityplanner.MobileCityPlannerExitPopUp;
   
   public class MobileCityPlannerExitPopUpMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileCityPlannerExitPopUp;
      
      public function MobileCityPlannerExitPopUpMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.imageAsset,"change",onAssetChanged,Event);
         eventMap.mapStarlingListener(view.discardButton,"triggered",onDiscardButtonClicked,Event);
         eventMap.mapStarlingListener(view.saveButton,"triggered",onSaveButtonClicked,Event);
      }
      
      private function onAssetChanged(param1:Event) : void
      {
         view.drawLayout();
      }
      
      private function onDiscardButtonClicked(param1:Event) : void
      {
         this.closeWindow();
      }
      
      private function onSaveButtonClicked(param1:Event) : void
      {
         this.closeWindow();
      }
      
      override protected function closeWindow() : void
      {
         super.closeWindow();
      }
   }
}

