package wom.view.mediator.screen.windows.alliance.coa.mobile
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import starling.events.Event;
   import wom.controller.event.alliance.coa.VanityColorSelectionEvent;
   import wom.view.screen.windows.alliance.coa.mobile.MobileVanityColorSelectorView;
   
   public class MobileVanityColorSelectorViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileVanityColorSelectorView;
      
      [Inject]
      public var injector:IInjector;
      
      public function MobileVanityColorSelectorViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         injector.injectInto(view);
         eventMap.mapStarlingListener(view.paletteButton,"change",onPaletteButtonClicked,Event);
         addContextListener("colorSelected",onColorSelected,VanityColorSelectionEvent);
         addContextListener("selectorPaletteOpened",onPaletteShown,VanityColorSelectionEvent);
         addContextListener("closePalette",onClosePalette,VanityColorSelectionEvent);
      }
      
      private function onPaletteButtonClicked(param1:Event) : void
      {
         view.onPaletteButtonToggle();
         if(view.paletteButton.isSelected)
         {
            dispatch(new VanityColorSelectionEvent("selectorPaletteOpened",null,view.selectorId));
         }
         else
         {
            dispatch(new VanityColorSelectionEvent("closePalette",view.selectedColorType,view.selectorId));
         }
      }
      
      private function onColorSelected(param1:VanityColorSelectionEvent) : void
      {
         if(view.selectorId == param1.selectorId)
         {
            view.selectColor(param1.selectedColor,true);
         }
      }
      
      private function onPaletteShown(param1:VanityColorSelectionEvent) : void
      {
         if(param1.selectorId != view.selectorId)
         {
            view.closePalette();
         }
      }
      
      private function onClosePalette(param1:VanityColorSelectionEvent) : void
      {
         if(param1.selectorId == view.selectorId)
         {
            view.closePalette();
         }
      }
   }
}

