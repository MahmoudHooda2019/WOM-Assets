package wom.view.mediator.ui.tooltip
{
   import starling.events.Event;
   import wom.controller.event.tutorial.TutorialEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.controller.event.ui.MobileTooltipEvent;
   import wom.model.game.UserInfo;
   import wom.view.screen.windows.store.MobileStoreWindow;
   import wom.view.ui.tooltip.MobileResourceBarTooltipView;
   
   public class MobileResourceBarTooltipViewMediator extends MobileBaseTooltipViewMediator
   {
      
      [Inject]
      public var view:MobileResourceBarTooltipView;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function MobileResourceBarTooltipViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         injector.injectInto(view);
         addContextListener("setMandatoryTutorialsCompleted",onSetMandatoryTutorialsCompleted,TutorialEvent);
         eventMap.mapStarlingListener(view.addButton,"triggered",onAddButtonClicked,Event);
         checkAddButtonVisibility();
      }
      
      private function onSetMandatoryTutorialsCompleted(param1:TutorialEvent) : void
      {
         checkAddButtonVisibility();
      }
      
      private function checkAddButtonVisibility() : void
      {
         view.addButton.visible = userInfo.mandatoryTutorialCompleted;
      }
      
      private function onAddButtonClicked() : void
      {
         dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileStoreWindow(0,1)));
         dispatch(new MobileTooltipEvent("mobileTooltipEventClose"));
      }
   }
}

