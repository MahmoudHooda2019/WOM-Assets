package wom.view.mediator.screen.popups.finishnow
{
   import starling.events.Event;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.model.FinishNowHiringEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.hiring.HiringInfo;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.finishnow.MobileFinishNowHiringPopUp;
   import wom.view.screen.popups.notenough.MobileNotEnoughPopup;
   
   public class MobileFinishNowHiringPopUpMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileFinishNowHiringPopUp;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function MobileFinishNowHiringPopUpMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.actionButton,"triggered",onFinishNowButtonClicked,Event);
         addContextListener("hiringInfoUpdated",onHiringInfoUpdated);
      }
      
      private function onHiringInfoUpdated(param1:ModelUpdateEvent) : void
      {
         var _loc2_:HiringInfo = city.hiringInfoDictionary[view.buildingInstanceId] as HiringInfo;
         if(_loc2_ == null || !_loc2_.activeHiring && !_loc2_.isHiringPaused)
         {
            closeWindow();
         }
      }
      
      private function onFinishNowButtonClicked(param1:Event) : void
      {
         closeWindow();
         if(view.price > userInfo.numberOfGolds)
         {
            dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileNotEnoughPopup("gold")));
         }
         else
         {
            dispatch(new FinishNowHiringEvent("finishAllHires",view.buildingInstanceId,view.centralHiring));
         }
      }
      
      override protected function closeWindow() : void
      {
         dispatch(new MobilePopUpWindowEvent("closeSecondaryPopUpWindow",view));
      }
   }
}

