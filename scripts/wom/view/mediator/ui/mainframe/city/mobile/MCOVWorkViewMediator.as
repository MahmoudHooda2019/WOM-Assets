package wom.view.mediator.ui.mainframe.city.mobile
{
   import peak.i18n.PText;
   import starling.events.Event;
   import wom.controller.event.GameTickEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.model.FinishNowHiringEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.game.hiring.HiringInfo;
   import wom.model.game.hiring.HiringSlotView;
   import wom.model.game.job.UnitTrainJob;
   import wom.model.game.store.StoreUtil;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.model.message.request.BuyItemRequest;
   import wom.view.screen.popups.notenough.MobileNotEnoughPopup;
   import wom.view.ui.mainframe.city.mobile.MCOVWorkView;
   import wom.view.ui.mainframe.city.tooltip.mobile.MobileBuildingTooltipProgressInfoView;
   
   public class MCOVWorkViewMediator extends MCOVEnterViewMediator
   {
      
      [Inject]
      public var workView:MCOVWorkView;
      
      private var remaining:Number;
      
      private var original:Number;
      
      private var jobFound:Boolean;
      
      public function MCOVWorkViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(workView.finishNowButton.button,"triggered",onFinishNowButtonClicked);
         eventMap.mapStarlingListener(workView.cut30Button.button,"triggered",onCut30ButtonClicked);
         eventMap.mapStarlingListener(workView.boostButton,"triggered",onBoostButtonClicked);
         addContextListener("tick",onGameTick,GameTickEvent);
         gameTick();
      }
      
      override public function onRemove() : void
      {
         super.onRemove();
      }
      
      private function calculateDurations() : void
      {
         var _loc1_:int = 0;
         var _loc3_:Number = NaN;
         var _loc4_:Boolean = false;
         jobFound = false;
         if(buildingTypeDIO.id == 18)
         {
            for each(var _loc2_ in city.unitTrainJobs)
            {
               if(_loc2_.instanceId == buildingInfo.instanceId)
               {
                  remaining = _loc2_.durationRemaining - (new Date().getTime() - _loc2_.jobCreationTime);
                  original = _loc2_.originalDuration;
                  jobFound = true;
                  return;
               }
            }
         }
         else if(buildingTypeDIO.id == 17)
         {
            if(city.activeRecruitJob)
            {
               remaining = city.activeRecruitJob.durationRemaining - (new Date().getTime() - city.activeRecruitJob.jobCreationTime);
               original = city.activeRecruitJob.originalDuration;
               jobFound = true;
               return;
            }
         }
         else if(buildingTypeDIO.id == 20)
         {
            for each(var _loc6_ in city.hiringInfoDictionary)
            {
               if(_loc6_.hiringBuildingInstanceId == buildingInfo.instanceId)
               {
                  jobFound = true;
                  remaining = _loc6_.activeHiring ? _loc6_.activeHiring.remainingDuration - (new Date().getTime() - _loc6_.activeHiring.jobCreationTime) : 0;
                  original = _loc6_.activeHiring ? _loc6_.activeHiring.originalDuration : 0;
                  if(_loc6_.activeHiring)
                  {
                     for each(var _loc5_ in _loc6_.hiringQueue.hiringSlots)
                     {
                        _loc1_ = _loc5_.unitId;
                        _loc3_ = _loc5_.numberOfUnits * domainInfo.getUnit(_loc1_).hiringDurationPerLevelInSecs[(city.unitTypes[_loc1_] as UnitTypeInfo).currentLevel - 1];
                     }
                  }
               }
            }
         }
         else if(buildingTypeDIO.id == 21)
         {
            jobFound = true;
            remaining = remaining = 0;
            _loc4_ = false;
            for each(_loc6_ in city.hiringInfoDictionary)
            {
               var _temp_16:* = §§findproperty(remaining);
               remaining += _loc6_.activeHiring ? _loc6_.activeHiring.remainingDuration - (new Date().getTime() - _loc6_.activeHiring.jobCreationTime) : 0;
               var _temp_17:* = §§findproperty(original);
               original += _loc6_.activeHiring ? _loc6_.activeHiring.originalDuration : 0;
               if(_loc6_.activeHiring && !_loc4_)
               {
                  _loc4_ = true;
                  for each(_loc5_ in _loc6_.hiringQueue.hiringSlots)
                  {
                     _loc1_ = _loc5_.unitId;
                     _loc3_ = _loc5_.numberOfUnits * domainInfo.getUnit(_loc1_).hiringDurationPerLevelInSecs[(city.unitTypes[_loc1_] as UnitTypeInfo).currentLevel - 1];
                     remaining += _loc3_;
                     original += _loc3_;
                  }
               }
            }
         }
      }
      
      protected function gameTick() : void
      {
         var _loc1_:int = 0;
         calculateDurations();
         if(buildingTypeDIO.id == 20 || buildingTypeDIO.id == 21)
         {
            workView.finishNowButton.subLabel = "";
         }
         else
         {
            _loc1_ = calculateInstancePrice();
            var _loc2_:String;
            workView.finishNowButton.subLabel = _loc1_ == 0 ? (_loc2_ = "ui.windows.store.free",peak.i18n.PText.INSTANCE.getText0(_loc2_)) : _loc1_ + "";
         }
      }
      
      protected function onGameTick(param1:GameTickEvent) : void
      {
         gameTick();
      }
      
      protected function calculateInstancePrice() : int
      {
         if(buildingTypeDIO.id == 17 || buildingTypeDIO.id == 18)
         {
            return StoreUtil.mercenaryTrainAndRecruitPrice(0,remaining / 1000);
         }
         return 0;
      }
      
      protected function onBoostButtonClicked(param1:Event) : void
      {
      }
      
      protected function onFinishNowButtonClicked(param1:Event) : void
      {
         var _loc2_:int = 0;
         if(buildingTypeDIO.id == 20 || buildingTypeDIO.id == 21)
         {
            dispatch(new FinishNowHiringEvent("calculateFinishNowPrice",buildingInfo.instanceId,buildingTypeDIO.id == 21));
         }
         else
         {
            _loc2_ = calculateInstancePrice();
            cancelSelection();
            if(_loc2_ > userInfo.numberOfGolds)
            {
               dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileNotEnoughPopup("gold")));
            }
            else if(_loc2_ == 0)
            {
               dispatch(new OutgoingMessageEvent("outgoingMessage",new BuyItemRequest(2003,buildingInfo.instanceId)));
            }
            else
            {
               dispatch(new OutgoingMessageEvent("outgoingMessage",new BuyItemRequest(2007,buildingInfo.instanceId)));
            }
         }
      }
      
      protected function onCut30ButtonClicked(param1:Event) : void
      {
         if(30 > userInfo.reconPoints)
         {
            cancelSelection();
            dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileNotEnoughPopup("recon")));
         }
         else
         {
            dispatch(new OutgoingMessageEvent("outgoingMessage",new BuyItemRequest(2004,buildingInfo.instanceId)));
         }
      }
      
      override protected function updateView() : void
      {
         super.updateView();
         var _loc1_:int = 0;
         if(buildingTypeDIO.id == 20)
         {
            _loc1_ = 2;
         }
         else if(buildingTypeDIO.id == 21)
         {
            _loc1_ = 7;
         }
         else if(buildingTypeDIO.id == 17)
         {
            _loc1_ = 1;
         }
         else if(buildingTypeDIO.id == 18)
         {
            _loc1_ = 3;
         }
         workView.addInfoView(new MobileBuildingTooltipProgressInfoView(_loc1_,buildingInfo));
      }
      
      override protected function determineButtonStatus() : void
      {
         super.determineButtonStatus();
         if(buildingInfo.buildingTypeId == 17 || buildingInfo.buildingTypeId == 18 || buildingInfo.buildingTypeId == 21)
         {
            workView.determineButtonStatus(false,false);
         }
         var _loc1_:Boolean = buildingInfo.buildingTypeId == 21;
         var _loc2_:Boolean = buildingInfo.buildingTypeId == 17 || buildingInfo.buildingTypeId == 18;
         workView.determineWorkButtonsStatus(_loc1_,_loc2_);
      }
   }
}

