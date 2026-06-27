package wom.view.mediator.screen.windows.build
{
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.tutorial.TutorialTriggerEvent;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.mediator.util.MobileButtonTabbedWindowMediator;
   import wom.view.screen.windows.build.MobileBuildShowcaseWindow;
   
   public class MobileBuildShowcaseWindowMediator extends MobileButtonTabbedWindowMediator
   {
      
      [Inject]
      public var view:MobileBuildShowcaseWindow;
      
      public function MobileBuildShowcaseWindowMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         view.addResourceAction = onAddResourceClicked;
         super.onRegister();
         addContextListener("changeTabBarIndex",changeTabBarIndex,TutorialTriggerEvent);
         dispatch(new ModelUpdateEvent("resourcesUpdated"));
      }
      
      private function onAddResourceClicked() : void
      {
         var _loc1_:Vector.<WindowEnumeration> = new <WindowEnumeration>[new WindowEnumeration(12,{"tab":view.initialTabIndex})];
         view.addWindowEnumeration(new WindowEnumeration(18,{
            "tab":1,
            "windowEnumerations":_loc1_
         }));
         closeWindow();
      }
      
      private function changeTabBarIndex(param1:TutorialTriggerEvent) : void
      {
         var _loc2_:int = 0;
         if("tabBarIndex" in param1.additionalInfo)
         {
            _loc2_ = int(param1.additionalInfo["tabBarIndex"]);
            if(_loc2_ < view.tabButtons.length)
            {
               view.activateTabByButton(view.tabButtons[_loc2_]);
            }
         }
      }
   }
}

