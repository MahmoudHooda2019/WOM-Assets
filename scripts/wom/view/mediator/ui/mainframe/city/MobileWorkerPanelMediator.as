package wom.view.mediator.ui.mainframe.city
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import peak.starling.FlatteningSprite;
   import starling.events.Event;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.tutorial.TutorialEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.view.screen.windows.store.MobileHireWorkerWindow;
   import wom.view.screen.windows.store.MobileStoreWindow;
   import wom.view.ui.mainframe.city.MobileWorkerPanel;
   
   public class MobileWorkerPanelMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileWorkerPanel;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      public function MobileWorkerPanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         injector.injectInto(view);
         addContextListener("workerCountUpdated",onWorkerCountUpdated,ModelUpdateEvent);
         addContextListener("workerAddButtonClicked",onWorkerAddButtonClicked,ModelUpdateEvent);
         addContextListener("mandatoryTutorialsCompletionChanged",onMandatoryTutorialsCompletionChanged,TutorialEvent);
         eventMap.mapStarlingListener(view.workerAddButton,"triggered",onOpenButtonClicked,Event);
         workerCountUpdated();
         checkTutorial();
      }
      
      private function unflatten() : void
      {
         if(view.parent is FlatteningSprite && view.parent.stage)
         {
            (view.parent as FlatteningSprite).unflatten();
         }
      }
      
      private function flatten() : void
      {
         if(view.parent is FlatteningSprite && view.parent.stage)
         {
            (view.parent as FlatteningSprite).flatten();
         }
      }
      
      private function checkTutorial() : void
      {
         unflatten();
         if(userInfo.mandatoryTutorialCompleted)
         {
            view.workerAddButton.setPaddings(70,20,10,10);
         }
         else
         {
            view.workerAddButton.setPaddings(150,20,30,30);
         }
         flatten();
      }
      
      private function onMandatoryTutorialsCompletionChanged(param1:TutorialEvent) : void
      {
         checkTutorial();
      }
      
      private function workerCountUpdated() : void
      {
         unflatten();
         view.cityHasMaxWorkers = city.numberOfWorkers >= 5;
         view.workerAddButton.visible = city.numberOfWorkers < 5;
         view.workerStatusTextField.text = city.numberOfWorkers - city.numberOfWorkingWorkers + "/" + city.numberOfWorkers;
         view.drawLayout();
         flatten();
      }
      
      private function onWorkerCountUpdated(param1:ModelUpdateEvent) : void
      {
         workerCountUpdated();
      }
      
      private function openButtonClicked() : void
      {
         if(city.numberOfWorkers == 1)
         {
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileStoreWindow()));
         }
         else if(city.numberOfWorkers == 2 || city.numberOfWorkers == 3 || city.numberOfWorkers == 4)
         {
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileHireWorkerWindow()));
         }
      }
      
      private function onOpenButtonClicked(param1:Event) : void
      {
         openButtonClicked();
      }
      
      private function onWorkerAddButtonClicked(param1:ModelUpdateEvent) : void
      {
         openButtonClicked();
      }
   }
}

