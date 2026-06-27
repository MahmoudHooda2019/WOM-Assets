package wom.view.mediator.ui.mainframe.combat.catapult
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import wom.controller.event.mobile.MobileCloseCatapultMenuOptionEvent;
   import wom.view.ui.mainframe.combat.catapult.MobileCatapultMenuOptionsView;
   
   public class MobileCatapultMenuOptionsViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileCatapultMenuOptionsView;
      
      [Inject]
      public var injector:IInjector;
      
      public function MobileCatapultMenuOptionsViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         injector.injectInto(view);
         addContextListener("closeOptionMenu",onCloseOptionMenu,MobileCloseCatapultMenuOptionEvent);
      }
      
      private function onCloseOptionMenu(param1:MobileCloseCatapultMenuOptionEvent) : void
      {
         if(view.visible)
         {
            view.visible = false;
            view.catapultMenuView.button.isSelected = false;
         }
      }
   }
}

