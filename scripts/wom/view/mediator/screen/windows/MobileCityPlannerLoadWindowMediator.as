package wom.view.mediator.screen.windows
{
   import starling.events.Event;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.model.game.CityStatusInfo;
   import wom.model.message.request.LoadCityPlanRequest;
   import wom.view.component.button.MobileWomButton;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.windows.cityplanner.MobileCityPlannerLoadLayoutRenderer;
   import wom.view.screen.windows.cityplanner.MobileCityPlannerLoadWindow;
   
   public class MobileCityPlannerLoadWindowMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileCityPlannerLoadWindow;
      
      [Inject]
      public var city:CityStatusInfo;
      
      public function MobileCityPlannerLoadWindowMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.planList,"rendererAdd",onRendererAdded,Event);
         eventMap.mapStarlingListener(view.planList,"rendererRemove",onRendererRemoved,Event);
         view.updateWithCityInfo(city.cityPlans,city.maxCityPlanSlots);
      }
      
      private function onRendererAdded(param1:Event, param2:MobileCityPlannerLoadLayoutRenderer) : void
      {
         eventMap.mapStarlingListener(param2.loadButton,"triggered",onLoadButtonClicked,Event);
      }
      
      private function onRendererRemoved(param1:Event, param2:MobileCityPlannerLoadLayoutRenderer) : void
      {
         eventMap.unmapStarlingListener(param2.loadButton,"triggered",onLoadButtonClicked,Event);
      }
      
      private function onLoadButtonClicked(param1:Event) : void
      {
         handleLoad((param1.target as MobileWomButton).data as int);
         this.closeWindow();
      }
      
      public function handleLoad(param1:int) : void
      {
         dispatch(new OutgoingMessageEvent("outgoingMessage",new LoadCityPlanRequest(param1)));
      }
   }
}

