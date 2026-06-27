package wom.view.mediator.screen.windows.alliance.mobile
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import starling.events.Event;
   import wom.view.screen.windows.alliance.coa.mobile.MobileCoaPatternSelectionViewRenderer;
   import wom.view.screen.windows.alliance.coa.mobile.MobileEditCoatOfArmsPanel;
   
   public class MobileEditCoatOfArmsPanelMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileEditCoatOfArmsPanel;
      
      [Inject]
      public var injector:IInjector;
      
      public function MobileEditCoatOfArmsPanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         injector.injectInto(view);
         eventMap.mapStarlingListener(view.firstColorSelector,"change",onSelectedColorsChanged,Event);
         eventMap.mapStarlingListener(view.secondColorSelector,"change",onSelectedColorsChanged,Event);
         eventMap.mapStarlingListener(view.patternSelectorList,"rendererAdd",onRendererAdded,Event);
         eventMap.mapStarlingListener(view.patternSelectorList,"rendererRemove",onRendererRemoved,Event);
      }
      
      private function onRendererAdded(param1:Event, param2:MobileCoaPatternSelectionViewRenderer) : void
      {
         eventMap.mapStarlingListener(param2,"triggered",onPatternClicked,Event);
      }
      
      private function onRendererRemoved(param1:Event, param2:MobileCoaPatternSelectionViewRenderer) : void
      {
         eventMap.unmapStarlingListener(param2,"triggered",onPatternClicked,Event);
      }
      
      private function onSelectedColorsChanged(param1:Event) : void
      {
         view.updateCOAAccordingToSelections();
      }
      
      private function onPatternClicked(param1:Event) : void
      {
         view.updatePatternSelection(param1.currentTarget as MobileCoaPatternSelectionViewRenderer);
      }
   }
}

