package wom.view.mediator.screen.windows
{
   import flash.utils.Dictionary;
   import starling.events.Event;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.component.WomPlannerRootV2;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.currency.CurrencyType;
   import wom.model.message.request.SaveCityPlanRequest;
   import wom.model.message.request.SetCityPlanSlotsRequest;
   import wom.view.component.button.MobileWomButton;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.notenough.MobileNotEnoughPopup;
   import wom.view.screen.windows.MobileCityPlannerSaveWindow;
   import wom.view.screen.windows.cityplanner.MobileCityPlannerSaveLayoutRenderer;
   
   public class MobileCityPlannerSaveWindowMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileCityPlannerSaveWindow;
      
      [Inject]
      public var plannerRoot:WomPlannerRootV2;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      public function MobileCityPlannerSaveWindowMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.planList,"rendererAdd",onRendererAdded,Event);
         eventMap.mapStarlingListener(view.planList,"rendererRemove",onRendererRemoved,Event);
         addContextListener("cityPlannerMaxSlotsChanged",onCityPlannerMaxSlotsChanged,ModelUpdateEvent);
         updateViewWithCityInfo();
      }
      
      private function onCityPlannerMaxSlotsChanged(param1:ModelUpdateEvent) : void
      {
         view.updateButtons(city.maxCityPlanSlots);
      }
      
      private function updateViewWithCityInfo() : void
      {
         var _loc1_:* = undefined;
         var _loc4_:* = undefined;
         var _loc2_:BuildingTypeDIO = domainInfo.getBuilding(26);
         var _loc3_:Dictionary = _loc2_.buildingSpecificInfo;
         if(_loc3_[BuildingSpecificInfoType.GOLD_COSTS_PER_PLANNER_SAVE_SLOT.id])
         {
            _loc1_ = _loc3_[BuildingSpecificInfoType.GOLD_COSTS_PER_PLANNER_SAVE_SLOT.id];
         }
         if(_loc3_[BuildingSpecificInfoType.RP_COSTS_PER_PLANNER_SAVE_SLOT.id])
         {
            _loc4_ = _loc3_[BuildingSpecificInfoType.RP_COSTS_PER_PLANNER_SAVE_SLOT.id];
         }
         view.updateWithCityInfo(city.cityPlans,city.maxCityPlanSlots,_loc1_,_loc4_);
      }
      
      private function onRendererAdded(param1:Event, param2:MobileCityPlannerSaveLayoutRenderer) : void
      {
         eventMap.mapStarlingListener(param2.saveButton,"triggered",onSaveButtonClicked,Event);
         eventMap.mapStarlingListener(param2.buyWithGoldButton,"triggered",onBuyWithGoldButtonClicked,Event);
         eventMap.mapStarlingListener(param2.buyWithRPButton,"triggered",onBuyWithRPButtonClicked,Event);
      }
      
      private function onRendererRemoved(param1:Event, param2:MobileCityPlannerSaveLayoutRenderer) : void
      {
         eventMap.unmapStarlingListener(param2.saveButton,"triggered",onSaveButtonClicked,Event);
         eventMap.unmapStarlingListener(param2.buyWithGoldButton,"triggered",onBuyWithGoldButtonClicked,Event);
         eventMap.unmapStarlingListener(param2.buyWithRPButton,"triggered",onBuyWithRPButtonClicked,Event);
      }
      
      private function onBuyWithGoldButtonClicked(param1:Event) : void
      {
         var _loc2_:MobileWomButton = param1.target as MobileWomButton;
         var _loc3_:int = _loc2_.data as int;
         if(int(_loc2_.rightLabel) > userInfo.numberOfGolds)
         {
            dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileNotEnoughPopup("gold")));
         }
         else
         {
            dispatch(new OutgoingMessageEvent("outgoingMessage",new SetCityPlanSlotsRequest(_loc3_,CurrencyType.GOLD.id)));
         }
      }
      
      private function onBuyWithRPButtonClicked(param1:Event) : void
      {
         var _loc2_:MobileWomButton = param1.target as MobileWomButton;
         var _loc3_:int = _loc2_.data as int;
         if(int(_loc2_.rightLabel) > userInfo.reconPoints)
         {
            dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileNotEnoughPopup("recon")));
         }
         else
         {
            dispatch(new OutgoingMessageEvent("outgoingMessage",new SetCityPlanSlotsRequest(_loc3_,CurrencyType.RECON_POINTS.id)));
         }
      }
      
      private function onSaveButtonClicked(param1:Event) : void
      {
         if(handleSave((param1.target as MobileWomButton).data as int))
         {
            this.closeWindow();
         }
      }
      
      public function handleSave(param1:int) : Boolean
      {
         var _loc2_:String = view.planList.dataProvider.getItemAt(param1 - 1).name;
         if(_loc2_ != "")
         {
            dispatch(new OutgoingMessageEvent("outgoingMessage",new SaveCityPlanRequest(param1,_loc2_,plannerRoot.getPlannerSnapShot())));
            return true;
         }
         return false;
      }
   }
}

