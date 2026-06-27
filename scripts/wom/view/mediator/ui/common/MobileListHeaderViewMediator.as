package wom.view.mediator.ui.common
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import wom.view.ui.common.MobileListHeaderView;
   
   public class MobileListHeaderViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileListHeaderView;
      
      [Inject]
      public var injector:IInjector;
      
      public function MobileListHeaderViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         injector.injectInto(view);
         view.updateSortingDirection(view.sortingDirection);
      }
   }
}

