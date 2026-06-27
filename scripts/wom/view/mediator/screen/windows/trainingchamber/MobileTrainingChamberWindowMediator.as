package wom.view.mediator.screen.windows.trainingchamber
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
   import wom.model.configuration.WomDocumentConfiguration;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.dto.ResourceAmountDTO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.event.EventItemUtil;
   import wom.model.game.job.UnitTrainJob;
   import wom.model.game.resource.ResourceType;
   import wom.model.game.store.StoreUtil;
   import wom.model.game.unit.UnitAccessType;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.model.game.window.WindowEnumeration;
   import wom.model.message.request.BuyItemRequest;
   import wom.model.message.request.CancelUnitTrainingRequest;
   import wom.model.message.request.TrainUnitRequest;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.notenough.MobileNotEnoughPopup;
   import wom.view.screen.popups.resource.MobileResourceCapacityExceedsPopup;
   import wom.view.screen.popups.unit.MobileTrainingStopPopUp;
   import wom.view.screen.windows.recruitmentchamber.MobileRecruitmentChamberItemViewRenderer;
   import wom.view.screen.windows.trainingchamber.MobileTrainingChamberWindow;
   
   public class MobileTrainingChamberWindowMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileTrainingChamberWindow;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var soundPlayer:SoundPlayer;
      
      [Inject]
      public var documentConfiguration:WomDocumentConfiguration;
      
      public function MobileTrainingChamberWindowMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         addContextListener("unitTypesUpdated",onUnitTypesUpdated,ModelUpdateEvent);
         eventMap.mapStarlingListener(view.mercenaryList,"scrollComplete",onScrollCompleted,starling.events.Event);
         eventMap.mapStarlingListener(view.mercenaryList,"scrollStart",onScrollStart,starling.events.Event);
         addContextListener("tick",onTick,GameTickEvent);
         updateActiveTrainingForThisBuilding();
         view.fillUnits(domainInfo.getUnits(documentConfiguration.trainEventItems ? UnitAccessType.ALL : UnitAccessType.DEFAULT),city.unitTypes,userInfo.unlockedEventItems,domainInfo.getEventItems());
         view.updateAllUnitViews(city.unitTypes,domainInfo.getUnits(documentConfiguration.trainEventItems ? UnitAccessType.ALL : UnitAccessType.DEFAULT),getBuildingLevel(),city.resourceAmounts[ResourceType.MIGHT.id],userInfo.unlockedEventItems,domainInfo.getEventItems());
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
         view.updateTrainingUnitProgresses(city.unitTypes,domainInfo.getUnits(documentConfiguration.trainEventItems ? UnitAccessType.ALL : UnitAccessType.DEFAULT),userInfo.unlockedEventItems,domainInfo.getEventItems());
      }
      
      private function onUnitTypesUpdated(param1:flash.events.Event) : void
      {
         updateActiveTrainingForThisBuilding();
         view.updateAllUnitViews(city.unitTypes,domainInfo.getUnits(documentConfiguration.trainEventItems ? UnitAccessType.ALL : UnitAccessType.DEFAULT),getBuildingLevel(),city.resourceAmounts[ResourceType.MIGHT.id],userInfo.unlockedEventItems,domainInfo.getEventItems());
      }
      
      private function updateActiveTrainingForThisBuilding() : void
      {
         for each(var _loc1_ in city.unitTrainJobs)
         {
            if(_loc1_.instanceId == view.buildingInstanceId)
            {
               view.activeTrainingUnitTypeIdForThisBuilding = _loc1_.unitTypeId;
               return;
            }
         }
         view.activeTrainingUnitTypeIdForThisBuilding = -1;
      }
      
      private function mapListeners() : void
      {
         eventMap.mapStarlingListener(view.trainButton,"triggered",onTrainButtonClicked,starling.events.Event);
         eventMap.mapStarlingListener(view.trainNowButton,"triggered",onTrainNowButtonClicked,starling.events.Event);
         eventMap.mapStarlingListener(view.stopButton,"triggered",onStopButtonClicked,starling.events.Event);
         eventMap.mapStarlingListener(view.finishNowButton,"triggered",onFinishNowButtonClicked,starling.events.Event);
         eventMap.mapStarlingListener(view.speedUpButton,"triggered",onShortenWithRPButtonClicked,starling.events.Event);
      }
      
      private function onStopButtonClicked(param1:starling.events.Event) : void
      {
         var _loc4_:UnitTypeInfo = view.selectedUnitTypeInfo;
         var _loc2_:UnitTypeDIO = view.selectedUnitTypeDIO;
         var _loc5_:Boolean = false;
         for each(var _loc3_ in _loc2_.trainingCostsPerLevel[_loc4_.currentLevel])
         {
            if(_loc3_.resourceAmount + city.resourceAmounts[_loc3_.resourceType] > city.totalResourceCapacity >> 2)
            {
               _loc5_ = true;
               break;
            }
         }
         if(_loc5_)
         {
            dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileResourceCapacityExceedsPopup("cancel",new OutgoingMessageEvent("outgoingMessage",new CancelUnitTrainingRequest(view.buildingInstanceId)),"closeSecondaryPopUpWindow")));
         }
         else
         {
            dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileTrainingStopPopUp(_loc2_.id,view.buildingInstanceId)));
         }
      }
      
      private function onFinishNowButtonClicked(param1:starling.events.Event) : void
      {
         if(calculateRemainingDurationForTrainingJob() <= 300000)
         {
            dispatch(new OutgoingMessageEvent("outgoingMessage",new BuyItemRequest(2003,view.buildingInstanceId)));
         }
         else
         {
            dispatch(new OutgoingMessageEvent("outgoingMessage",new BuyItemRequest(2007,view.buildingInstanceId)));
         }
      }
      
      private function calculateRemainingDurationForTrainingJob() : Number
      {
         for each(var _loc1_ in city.unitTrainJobs)
         {
            if(_loc1_.instanceId == view.buildingInstanceId)
            {
               return _loc1_.durationRemaining;
            }
         }
         return -1;
      }
      
      private function onShortenWithRPButtonClicked(param1:starling.events.Event) : void
      {
         if(calculateRemainingDurationForTrainingJob() > 300000)
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
      
      private function onTrainNowButtonClicked(param1:starling.events.Event) : void
      {
         trainUnit(true);
      }
      
      private function onTrainButtonClicked(param1:starling.events.Event) : void
      {
         trainUnit();
      }
      
      private function trainUnit(param1:Boolean = false) : void
      {
         var _loc10_:int = 0;
         var _loc9_:int = 0;
         var _loc7_:Array = null;
         var _loc11_:int = 0;
         var _loc2_:OutgoingMessage = null;
         var _loc8_:UnitTypeInfo = view.selectedUnitTypeInfo;
         var _loc4_:UnitTypeDIO = view.selectedUnitTypeDIO;
         if(_loc4_.event)
         {
            if(!EventItemUtil.isUnlocked(_loc4_,_loc8_,userInfo.unlockedEventItems,domainInfo.getEventItems()))
            {
               var _temp_3:* = §§findproperty(MobileUINotificationEvent);
               var _temp_2:* = "mobileUINotificationEventShow";
               var _loc16_:String = "ui.popups.actionnotpossible.type.104";
               dispatch(new MobileUINotificationEvent(_temp_2,peak.i18n.PText.INSTANCE.getText0(_loc16_)));
               return;
            }
         }
         else if(!_loc8_.recruited)
         {
            var _temp_6:* = §§findproperty(MobileUINotificationEvent);
            var _temp_5:* = "mobileUINotificationEventShow";
            var _loc17_:String = "ui.popups.actionnotpossible.type.4";
            dispatch(new MobileUINotificationEvent(_temp_5,peak.i18n.PText.INSTANCE.getText0(_loc17_)));
            return;
         }
         var _loc6_:int = _loc8_.currentLevel;
         if(_loc6_ == _loc4_.maxLevels)
         {
            _loc6_--;
         }
         for each(var _loc3_ in city.buildings)
         {
            if(_loc3_.instanceId == view.buildingInstanceId)
            {
               if(_loc3_.level < _loc4_.trainingPrerequisitesPerLevel[_loc6_].level)
               {
                  var _temp_10:* = §§findproperty(MobileUINotificationEvent);
                  var _temp_9:* = "mobileUINotificationEventShow";
                  var _loc18_:String = "ui.popups.actionnotpossible.type.6";
                  dispatch(new MobileUINotificationEvent(_temp_9,peak.i18n.PText.INSTANCE.getText0(_loc18_)));
                  return;
               }
               break;
            }
         }
         if(view.activeTrainingUnitTypeIdForThisBuilding != -1)
         {
            var _temp_13:* = §§findproperty(MobileUINotificationEvent);
            var _temp_12:* = "mobileUINotificationEventShow";
            var _loc19_:String = "ui.popups.actionnotpossible.type.5";
            dispatch(new MobileUINotificationEvent(_temp_12,peak.i18n.PText.INSTANCE.getText0(_loc19_)));
            return;
         }
         if(param1)
         {
            _loc10_ = StoreUtil.mercenaryTrainAndRecruitPrice(_loc4_.trainingCostsPerLevel[_loc6_][0].resourceAmount,_loc4_.trainingDurationPerLevelInSecs[_loc6_]);
            if(_loc10_ > userInfo.numberOfGolds)
            {
               dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileNotEnoughPopup("gold")));
               return;
            }
         }
         else
         {
            _loc9_ = 0;
            _loc7_ = [];
            for each(var _loc5_ in _loc4_.trainingCostsPerLevel[_loc6_])
            {
               _loc11_ = _loc5_.resourceAmount - city.resourceAmounts[_loc5_.resourceType];
               if(_loc11_ > 0)
               {
                  _loc7_.push({
                     "resourceType":_loc5_.resourceType,
                     "amount":_loc11_
                  });
                  _loc9_ += _loc11_;
               }
            }
            if(_loc9_ > 0)
            {
               _loc2_ = new TrainUnitRequest(_loc4_.id,view.buildingInstanceId,false,true);
               view.addWindowEnumeration(new WindowEnumeration(5,{"initialUnitTypeId":view.selectedUnitTypeDIO.id}));
               view.addWindowEnumeration(new WindowEnumeration(43,{
                  "type":"train",
                  "missingResourcesArray":_loc7_,
                  "outgoingMessage":_loc2_
               }));
               closeWindow();
               return;
            }
         }
         dispatch(new OutgoingMessageEvent("outgoingMessage",new TrainUnitRequest(_loc4_.id,view.buildingInstanceId,param1)));
         if(param1)
         {
            soundPlayer.playSfxById("PurchaseSuccessful");
            closeWindow();
         }
         else
         {
            soundPlayer.playSfxById("UseResources");
         }
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

