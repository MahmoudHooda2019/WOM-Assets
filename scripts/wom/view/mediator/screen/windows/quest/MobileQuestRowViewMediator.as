package wom.view.mediator.screen.windows.quest
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import peak.logging.LoggerContexts;
   import peak.logging.log;
   import starling.events.Event;
   import wom.controller.event.ui.MobileCloseContainerOfDisplayObjectEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.service.kontagent.WomKontagentApi;
   import wom.view.screen.windows.quest.MobileQuestDetailWindow;
   import wom.view.screen.windows.quest.MobileQuestRowView;
   
   public class MobileQuestRowViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileQuestRowView;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var kontagentApi:WomKontagentApi;
      
      public function MobileQuestRowViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         injector.injectInto(view);
         eventMap.mapStarlingListener(view.detailsButton,"triggered",onMouseClick,Event);
      }
      
      private function onMouseClick(param1:Event) : void
      {
         if(!view.questInfo.completed)
         {
            kontagentApi.trackUIEvent("quest_panel");
            dispatch(new MobileCloseContainerOfDisplayObjectEvent("close",view));
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileQuestDetailWindow(view.questInfo)));
         }
         else
         {
            log(LoggerContexts.UNCAUGHT_ERROR,"quest detail window (already completed)! questId: " + view.questInfo.questId);
         }
      }
   }
}

