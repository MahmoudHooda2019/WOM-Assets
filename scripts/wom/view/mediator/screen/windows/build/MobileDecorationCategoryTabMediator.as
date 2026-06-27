package wom.view.mediator.screen.windows.build
{
   import org.robotlegs.mvcs.StarlingMediator;
   import starling.events.Event;
   import wom.view.screen.windows.build.MobileDecorationCategoryTab;
   
   public class MobileDecorationCategoryTabMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileDecorationCategoryTab;
      
      public function MobileDecorationCategoryTabMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.tabBar,"change",onTabChanged,Event);
      }
      
      protected function onTabChanged(param1:Event) : void
      {
         view.activateTabByIndex(view.tabBar.selectedIndex);
      }
   }
}

