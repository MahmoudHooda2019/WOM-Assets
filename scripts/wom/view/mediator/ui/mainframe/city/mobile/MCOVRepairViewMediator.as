package wom.view.mediator.ui.mainframe.city.mobile
{
   import peak.i18n.PText;
   import starling.events.Event;
   import wom.controller.event.GameTickEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.mobile.MobileConstructableOptionsEvent;
   import wom.controller.event.mobile.MobileSelectEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.job.BuildingRepairJob;
   import wom.model.game.store.StoreUtil;
   import wom.model.message.request.BuyItemRequest;
   import wom.view.screen.popups.notenough.MobileNotEnoughPopup;
   import wom.view.screen.windows.store.MobileStoreWindow;
   import wom.view.ui.mainframe.city.mobile.MCOVRepairView;
   import wom.view.ui.mainframe.city.tooltip.mobile.MobileBuildingTooltipProgressInfoView;
   
   public class MCOVRepairViewMediator extends MobileConstructableOptionsViewMediator
   {
      
      [Inject]
      public var repairView:MCOVRepairView;
      
      [Inject]
      public var cityInfo:CityStatusInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      protected var repairJob:BuildingRepairJob;
      
      public function MCOVRepairViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         updateRepairAllGoldAmout();
         eventMap.mapStarlingListener(repairView.repairAllButton,"triggered",onRepairAllButtonClicked);
         eventMap.mapStarlingListener(repairView.speedUpButton,"triggered",onSpeedUpButtonClicked);
         addContextListener("tick",onGameTick);
      }
      
      private function onSpeedUpButtonClicked() : void
      {
         cancelSelection();
         dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileStoreWindow(0,4,buildingInfo.instanceId)));
      }
      
      override protected function updateData() : void
      {
         super.updateData();
         retrieveJob();
      }
      
      private function retrieveJob() : void
      {
         var _loc2_:Boolean = false;
         for each(var _loc1_ in city.buildingRepairJobs)
         {
            if(buildingInfo.instanceId == _loc1_.instanceId)
            {
               _loc2_ = true;
               repairJob = _loc1_;
               break;
            }
         }
         if(!_loc2_)
         {
            repairJob = null;
         }
      }
      
      private function onGameTick(param1:GameTickEvent) : void
      {
         updateRepairAllGoldAmout();
      }
      
      private function updateRepairAllGoldAmout() : void
      {
         if(!repairJob || repairJob.durationRemaining + repairJob.jobCreationTime - new Date().getTime() <= 0)
         {
            dispatch(new MobileConstructableOptionsEvent("mobileConstructableOptionsClose"));
            dispatch(new MobileSelectEvent(buildingInfo.instanceId));
         }
         var _loc1_:int = calculateRepairAllPrice();
         var _loc2_:String;
         repairView.changeRepairGoldAmount(_loc1_ == 0 ? (_loc2_ = "ui.windows.store.free",peak.i18n.PText.INSTANCE.getText0(_loc2_)) : _loc1_ + "");
      }
      
      private function onRepairAllButtonClicked(param1:Event) : void
      {
         var _loc2_:int = calculateRepairAllPrice();
         cancelSelection();
         if(_loc2_ > userInfo.numberOfGolds)
         {
            dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileNotEnoughPopup("gold")));
         }
         else
         {
            dispatch(new OutgoingMessageEvent("outgoingMessage",new BuyItemRequest(2008)));
         }
      }
      
      override protected function updateView() : void
      {
         super.updateView();
         repairView.addInfoView(new MobileBuildingTooltipProgressInfoView(0,buildingInfo));
      }
      
      private function calculateRepairAllPrice() : int
      {
         var _loc3_:BuildingTypeDIO = null;
         var _loc4_:Number = NaN;
         var _loc5_:int = 0;
         var _loc1_:Number = 0;
         for each(var _loc2_ in cityInfo.buildings)
         {
            _loc3_ = domainInfo.getBuilding(_loc2_.buildingTypeId);
            if(!_loc3_.isHealthy(_loc2_.level,_loc2_.healthPoint))
            {
               _loc5_ = _loc2_.level == 0 ? 0 : _loc2_.level - 1;
               _loc4_ = _loc3_.healthPointsPerLevel[_loc5_];
               _loc1_ += (_loc4_ - _loc2_.healthPoint) / _loc4_ * _loc3_.repairDurationsPerLevel[_loc5_];
            }
         }
         return StoreUtil.buildingPrice(0,_loc1_ / userInfo.serverSpeed);
      }
   }
}

