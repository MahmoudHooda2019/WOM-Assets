package wom.view.mediator.screen.popups.facebook
{
   import starling.events.Event;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.facebook.MobileFBConfirmationPopUp;
   import wom.view.screen.popups.facebook.MobileFBProgressPopUp;
   
   public class MobileFBProgressPopUpMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileFBProgressPopUp;
      
      public function MobileFBProgressPopUpMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.imageAsset,"change",onAssetChanged,Event);
         eventMap.mapStarlingListener(view.actionButton,"triggered",onOkButtonClicked,Event);
         eventMap.mapStarlingListener(view.switchProgressChoiceButton,"triggered",onSwapButtonClicked,Event);
      }
      
      private function onAssetChanged(param1:Event) : void
      {
         view.drawLayout();
      }
      
      private function onOkButtonClicked(param1:Event) : void
      {
         closeWindow();
         dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileFBConfirmationPopUp(view.webLevel,view.mobileLevel,view.isWebSelected)));
      }
      
      private function onSwapButtonClicked(param1:Event) : void
      {
         view.swap();
      }
      
      override protected function closeWindow() : void
      {
         dispatch(new MobilePopUpWindowEvent("closePopUpWindow",view));
      }
   }
}

