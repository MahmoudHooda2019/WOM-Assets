package wom.view.mediator.screen.popups
{
   import starling.events.Event;
   import wom.controller.event.WindowCreationEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.view.component.button.MobileWomButton;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.MobileGenericActionPopUp;
   
   public class MobileGenericActionPopUpMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileGenericActionPopUp;
      
      public function MobileGenericActionPopUpMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.clementineAsset,"change",onAssetChanged,Event);
         mapButtonListeners();
      }
      
      private function mapButtonListeners() : void
      {
         for each(var _loc1_ in view.buttons)
         {
            eventMap.mapStarlingListener(_loc1_,"triggered",onButtonClicked,Event);
         }
      }
      
      private function onAssetChanged(param1:Event) : void
      {
         view.drawLayout();
      }
      
      private function onButtonClicked(param1:Event) : void
      {
         var _loc2_:int = view.buttons.indexOf(param1.target as MobileWomButton);
         if(view.enumerationButtons[_loc2_].enumeration)
         {
            dispatch(new WindowCreationEvent("createWindow",view.enumerationButtons[_loc2_].enumeration));
         }
         closeWindow();
      }
      
      override protected function closeWindow() : void
      {
         super.closeWindow();
         dispatch(new MobilePopUpWindowEvent("closeSecondaryPopUpWindow",view));
      }
   }
}

