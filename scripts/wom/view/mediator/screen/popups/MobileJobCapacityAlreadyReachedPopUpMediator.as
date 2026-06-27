package wom.view.mediator.screen.popups
{
   import starling.events.Event;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.job.BuildingUpgradeJob;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.MobileJobCapacityAlreadyReachedPopUp;
   
   public class MobileJobCapacityAlreadyReachedPopUpMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileJobCapacityAlreadyReachedPopUp;
      
      [Inject]
      public var city:CityStatusInfo;
      
      public function MobileJobCapacityAlreadyReachedPopUpMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.speedUpButton,"triggered",onSpeedUpButtonClicked,Event);
         eventMap.mapStarlingListener(view.hireExtraWorkerButton,"triggered",onHireExtraWorkerButtonClicked,Event);
         updateWithWorkerInfo(city.numberOfWorkers);
      }
      
      private function onSpeedUpButtonClicked(param1:Event) : void
      {
         var _loc2_:Number = 1.7976931348623157e+308;
         var _loc4_:int = -1;
         for each(var _loc3_ in city.buildingUpgradeJobs)
         {
            if(_loc3_.durationRemaining < _loc2_)
            {
               _loc2_ = _loc3_.durationRemaining;
               _loc4_ = _loc3_.instanceId;
            }
         }
         if(_loc4_ != -1)
         {
            view.addWindowEnumeration(new WindowEnumeration(18,{
               "instanceId":_loc4_,
               "tab":4
            }));
         }
         closeWindow();
      }
      
      private function updateWithWorkerInfo(param1:int) : void
      {
         view.updateWithWorkerInfo(param1);
      }
      
      protected function onHireExtraWorkerButtonClicked(param1:Event) : void
      {
         dispatch(new ModelUpdateEvent("workerAddButtonClicked"));
         closeWindow();
      }
   }
}

