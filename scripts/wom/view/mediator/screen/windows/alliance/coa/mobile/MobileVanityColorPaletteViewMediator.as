package wom.view.mediator.screen.windows.alliance.coa.mobile
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import starling.events.Event;
   import wom.controller.event.alliance.coa.VanityColorSelectionEvent;
   import wom.view.screen.windows.alliance.coa.mobile.MobileVanityColorPaletteView;
   import wom.view.screen.windows.alliance.coa.mobile.MobileVanityColorRadioButton;
   
   public class MobileVanityColorPaletteViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileVanityColorPaletteView;
      
      [Inject]
      public var injector:IInjector;
      
      public function MobileVanityColorPaletteViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         injector.injectInto(view);
         mapButtonListeners();
      }
      
      private function mapButtonListeners() : void
      {
         eventMap.mapStarlingListener(view.radioButtonGroup,"change",onColorSelected,Event);
         eventMap.mapStarlingListener(view.closeButton,"triggered",onClose,Event);
      }
      
      private function onColorSelected(param1:Event) : void
      {
         var _loc2_:MobileVanityColorRadioButton = view.radioButtonGroup.selectedItem as MobileVanityColorRadioButton;
         dispatch(new VanityColorSelectionEvent("colorSelected",_loc2_.colorType,view.selectorId));
         dispatch(new VanityColorSelectionEvent("closePalette",_loc2_.colorType,view.selectorId));
      }
      
      private function onClose(param1:Event) : void
      {
         dispatch(new VanityColorSelectionEvent("closePalette",(view.radioButtonGroup.selectedItem as MobileVanityColorRadioButton).colorType,view.selectorId));
      }
   }
}

