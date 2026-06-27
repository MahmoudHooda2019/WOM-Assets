package wom.view.mediator.screen.popups
{
   import flash.external.ExternalInterface;
   import starling.events.Event;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.MobileDontKillMePopUp;
   
   public class MobileDontKillMePopUpMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileDontKillMePopUp;
      
      public function MobileDontKillMePopUpMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.imageAsset,"change",onAssetChanged,Event);
         eventMap.mapStarlingListener(view.actionButton,"triggered",onRetryButtonClicked,Event);
      }
      
      private function onAssetChanged(param1:Event) : void
      {
         view.drawLayout();
      }
      
      private function onRetryButtonClicked(param1:Event) : void
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

