package wom.view.mediator.util
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import starling.events.Event;
   import wom.view.util.MobileFooWindow;
   
   public class MobileFooWindowMediator extends StarlingMediator
   {
      
      [Inject]
      public var genericWindow:MobileFooWindow;
      
      [Inject]
      public var injector:IInjector;
      
      public function MobileFooWindowMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         injector.injectInto(genericWindow);
         eventMap.mapStarlingListener(genericWindow.closeButton,"triggered",onCloseButtonClicked,Event);
      }
      
      private function onCloseButtonClicked(param1:Event) : void
      {
         genericWindow.parent.removeChild(genericWindow);
      }
   }
}

