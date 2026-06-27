package wom.view.mediator.screen.popups
{
   import starling.events.Event;
   import wom.controller.event.WindowCreationEvent;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.MobileAnyoneHomePopUp;
   
   public class MobileAnyoneHomePopUpMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileAnyoneHomePopUp;
      
      public function MobileAnyoneHomePopUpMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.imageAsset,"change",onAssetChanged,Event);
         eventMap.mapStarlingListener(view.actionButton,"triggered",onSendFreeGiftsButtonClicked,Event);
      }
      
      private function onAssetChanged(param1:Event) : void
      {
         view.drawLayout();
      }
      
      private function onSendFreeGiftsButtonClicked(param1:Event) : void
      {
         closeWindow();
         dispatch(new WindowCreationEvent("createWindow",new WindowEnumeration(14,{})));
      }
   }
}

