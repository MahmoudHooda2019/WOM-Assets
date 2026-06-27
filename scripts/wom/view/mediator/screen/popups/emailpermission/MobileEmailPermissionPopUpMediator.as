package wom.view.mediator.screen.popups.emailpermission
{
   import starling.events.Event;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.emailpermission.MobileEmailPermissionPopUp;
   
   public class MobileEmailPermissionPopUpMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileEmailPermissionPopUp;
      
      public function MobileEmailPermissionPopUpMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.imageAsset,"change",onAssetChanged,Event);
         eventMap.mapStarlingListener(view.actionButton,"triggered",onConfirmButtonClicked,Event);
      }
      
      private function onConfirmButtonClicked() : void
      {
      }
      
      private function onAssetChanged() : void
      {
         view.drawLayout();
      }
   }
}

