package wom.view.mediator.screen.popups
{
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import starling.events.Event;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.MobileDisconnectPopUp;
   
   public class MobileDisconnectPopUpMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileDisconnectPopUp;
      
      public function MobileDisconnectPopUpMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.imageAsset,"change",onAssetChanged,Event);
         eventMap.mapStarlingListener(view.actionButton,"triggered",onReloadButtonClicked,Event);
      }
      
      private function onAssetChanged(param1:Event) : void
      {
         view.drawLayout();
      }
      
      private function onReloadButtonClicked(param1:MouseEvent) : void
      {
         closeWindow();
      }
      
      override protected function closeWindow() : void
      {
         super.closeWindow();
         if(ExternalInterface.available)
         {
            ExternalInterface.call("reloadPage");
         }
      }
   }
}

