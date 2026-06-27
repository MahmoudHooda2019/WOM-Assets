package wom.view.mediator.screen.windows.recruitmentchamber
{
   import flash.events.Event;
   import peak.i18n.PText;
   import peak.messaging.OutgoingMessage;
   import peak.resource.SoundPlayer;
   import starling.events.Event;
   import wom.controller.event.GameTickEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.controller.event.ui.MobileUINotificationEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.dto.ResourceAmountDTO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.resource.ResourceType;
   import wom.model.game.store.StoreUtil;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.model.game.window.WindowEnumeration;
   import wom.model.message.request.BuyItemRequest;
   import wom.model.message.request.CancelRecruitmentRequest;
   import wom.model.message.request.RecruitUnitRequest;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.notenough.MobileNotEnoughPopup;
   import wom.view.screen.popups.resource.MobileResourceCapacityExceedsPopup;
   import wom.view.screen.popups.unit.MobileRecruitmentStopPopUp;
   import wom.view.screen.windows.recruitmentchamber.MobileRecruitmentChamberItemViewRenderer;
   import wom.view.screen.windows.recruitmentchamber.MobileRecruitmentChamberWindow;
   
   public class MobileRecruitmentChamberWindowMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileRecruitmentChamberWindow;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var soundPlayer:SoundPlayer;
      
      public function MobileRecruitmentChamberWindowMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.mercenaryList,"scrollComplete",onScrollCompleted,starling.events.Event);
         eventMap.mapStarlingListener(view.mercenaryList,"scrollStart",onScrollStart,starling.events.Event);
         addContextListener("unitTypesUpdated",onJobsUpdated,ModelUpdateEvent);
         addContextListener("tick",onTick,GameTickEvent);
         view.fillUnits(domainInfo.getUnits(),city.unitTypes);
         view.updateUnits(city.unitTypes,domainInfo.getUnits(),getBuildingLevel(),city.resourceAmounts[ResourceType.MIGHT.id]);
         mapListeners();
         view.scrollToRequiredPage();
      }
      
      private function getBuildingLevel() : int
      {
         for each(var _loc1_ in city.buildings)
         {
            if(view.buildingInstanceId == _loc1_.instanceId)
            {
               return _loc1_.level;
            }
         }
         return -1;
      }
      
      private function onTick(param1:GameTickEvent) : void
      {
         view.updateRecruitingUnitProgress(city.unitTypes,domainInfo.getUnits());
      }
      
      private function onJobsUpdated(param1:flash.events.Event) : void
      {
         view.updateUnits(city.unitTypes,domainInfo.getUnits(),getBuildingLevel(),city.resourceAmounts[ResourceType.MIGHT.id]);
      }
      
      private function mapListeners() : void
      {
         eventMap.mapStarlingListener(view.startButton,"triggered",onStartButton,starling.events.Event);
         eventMap.mapStarlingListener(view.recruitButton,"triggered",onRecruitButton,starling.events.Event);
         eventMap.mapStarlingListener(view.stopButton,"triggered",onStopButtonClicked,starling.events.Event);
         eventMap.mapStarlingListener(view.finishNowButton,"triggered",onFinishNowButtonClicked,starling.events.Event);
         eventMap.mapStarlingListener(view.speedUpButton,"triggered",onShortenWithRPButtonClicked,starling.events.Event);
      }
      
      private function onStopButtonClicked(param1:starling.events.Event) : void
      {
         var _loc2_:UnitTypeDIO = view.selectedUnitTypeDIO;
         var _loc3_:ResourceAmountDTO = _loc2_.unlockCost;
         if(_loc3_.resourceAmount + city.resourceAmounts[_loc3_.resourceType] > city.totalResourceCapacity >> 2)
         {
            dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileResourceCapacityExceedsPopup("cancel",new OutgoingMessageEvent("outgoingMessage",new CancelRecruitmentRequest()),"closeSecondaryPopUpWindow")));
         }
         else
         {
            dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileRecruitmentStopPopUp(view.selectedUnitTypeDIO.id)));
         }
      }
      
      private function onFinishNowButtonClicked(param1:starling.events.Event) : void
      {
         var _loc2_:Number = city.activeRecruitJob.jobCreationTime + city.activeRecruitJob.durationRemaining - new Date().getTime();
         if(_loc2_ < 300000)
         {
            dispatch(new OutgoingMessageEvent("outgoingMessage",new BuyItemRequest(2003,view.buildingInstanceId)));
         }
         else
         {
            dispatch(new OutgoingMessageEvent("outgoingMessage",new BuyItemRequest(2007,view.buildingInstanceId)));
         }
      }
      
      private function onShortenWithRPButtonClicked(param1:starling.events.Event) : void
      {
         var _loc2_:Number = city.activeRecruitJob.jobCreationTime + city.activeRecruitJob.durationRemaining - new Date().getTime();
         if(_loc2_ > 300000)
         {
            if(userInfo.reconPoints >= 30)
            {
               dispatch(new OutgoingMessageEvent("outgoingMessage",new BuyItemRequest(2004,view.buildingInstanceId)));
            }
            else
            {
               dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileNotEnoughPopup("recon")));
            }
         }
      }
      
      private function onRecruitButton(param1:starling.events.Event) : void
      {
         if(recruitUnit(true))
         {
            closeWindow();
         }
      }
      
      private function onStartButton(param1:starling.events.Event) : void
      {
         recruitUnit();
      }
      
      private function recruitUnit(param1:Boolean = false) : Boolean
      {
         var _loc3_:Number = NaN;
         var _loc7_:int = 0;
         var _loc5_:Array = null;
         var _loc8_:int = 0;
         var _loc2_:OutgoingMessage = null;
         var _loc6_:UnitTypeInfo = view.selectedUnitTypeInfo;
         if(!_loc6_.recruitable)
         {
            var _temp_3:* = §§findproperty(MobileUINotificationEvent);
            var _temp_2:* = "mobileUINotificationEventShow";
            var _loc10_:String = "m.ui.popups.actionnotpossible.type.100";
            dispatch(new MobileUINotificationEvent(_temp_2,peak.i18n.PText.INSTANCE.getText0(_loc10_)));
            return false;
         }
         if(view.anyRecruitingJobExist)
         {
            var _temp_6:* = §§findproperty(MobileUINotificationEvent);
            var _temp_5:* = "mobileUINotificationEventShow";
            var _loc11_:String = "m.ui.popups.actionnotpossible.type.1";
            dispatch(new MobileUINotificationEvent(_temp_5,peak.i18n.PText.INSTANCE.getText0(_loc11_)));
            return false;
         }
         var _loc4_:UnitTypeDIO = domainInfo.getUnit(_loc6_.unitTypeId);
         var _loc9_:ResourceAmountDTO = _loc4_.unlockCost;
         if(param1)
         {
            _loc3_ = _loc4_.unlockDurationInSecs / userInfo.serverSpeed;
            _loc7_ = StoreUtil.mercenaryTrainAndRecruitPrice(_loc9_.resourceAmount,_loc3_);
            if(_loc7_ > userInfo.numberOfGolds)
            {
               dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileNotEnoughPopup("gold")));
               return false;
            }
         }
         else if(_loc9_.resourceAmount > city.resourceAmounts[_loc9_.resourceType])
         {
            _loc5_ = [];
            _loc8_ = _loc9_.resourceAmount - city.resourceAmounts[_loc9_.resourceType];
            if(_loc8_ > 0)
            {
               _loc5_.push({
                  "resourceType":ResourceType.MIGHT.id,
                  "amount":_loc8_
               });
            }
            _loc2_ = new RecruitUnitRequest(_loc6_.unitTypeId,false,true);
            view.addWindowEnumeration(new WindowEnumeration(6,{"units":view.selectedUnitTypeDIO.id}));
            view.addWindowEnumeration(new WindowEnumeration(43,{
               "type":"recruit",
               "missingResourcesArray":_loc5_,
               "outgoingMessage":_loc2_
            }));
            closeWindow();
            return false;
         }
         if(param1)
         {
            soundPlayer.playSfxById("PurchaseSuccessful");
         }
         dispatch(new OutgoingMessageEvent("outgoingMessage",new RecruitUnitRequest(_loc6_.unitTypeId,param1)));
         return true;
      }
      
      private function onScrollStart(param1:starling.events.Event, param2:MobileRecruitmentChamberItemViewRenderer = null) : void
      {
         view.updateButtons(true);
      }
      
      private function onScrollCompleted(param1:starling.events.Event, param2:MobileRecruitmentChamberItemViewRenderer = null) : void
      {
         mapListeners();
         view.updateButtons();
      }
   }
}

