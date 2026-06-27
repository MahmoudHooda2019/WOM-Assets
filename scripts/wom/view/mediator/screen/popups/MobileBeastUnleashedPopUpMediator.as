package wom.view.mediator.screen.popups
{
   import starling.events.Event;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.MobileBeastUnleashedPopUp;
   
   public class MobileBeastUnleashedPopUpMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileBeastUnleashedPopUp;
      
      public function MobileBeastUnleashedPopUpMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.imageAsset,"change",onAssetChanged,Event);
         eventMap.mapStarlingListener(view.chainAsset,"change",onAssetChanged,Event);
         eventMap.mapStarlingListener(view.actionButton,"triggered",onDoneButtonClicked,Event);
      }
      
      private function onAssetChanged(param1:Event) : void
      {
         view.drawLayout();
      }
      
      private function onDoneButtonClicked(param1:Event) : void
      {
         closeWindow();
      }
   }
}

