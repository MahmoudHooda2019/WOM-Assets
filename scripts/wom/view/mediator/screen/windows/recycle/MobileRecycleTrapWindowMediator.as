package wom.view.mediator.screen.windows.recycle
{
   import flash.events.Event;
   import starling.events.Event;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.dto.ResourceAmountDTO;
   import wom.model.game.CityStatusInfo;
   import wom.model.message.request.RecycleBuildingRequest;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.resource.MobileResourceCapacityExceedsPopup;
   import wom.view.screen.windows.recycle.MobileRecycleTrapWindow;
   
   public class MobileRecycleTrapWindowMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileRecycleTrapWindow;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      public function MobileRecycleTrapWindowMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.confirmButton,"triggered",onConfirmButtonClicked,starling.events.Event);
         eventMap.mapStarlingListener(view.abandonButton,"triggered",onAbandonButtonClicked,starling.events.Event);
         eventMap.mapStarlingListener(view.trapsSilhouette,"change",onAssetChanged,starling.events.Event);
         view.updateWithResources(domainInfo.getBuilding(view.buildingInfo.buildingTypeId));
      }
      
      private function onAbandonButtonClicked(param1:starling.events.Event) : void
      {
         closeWindow();
      }
      
      private function onConfirmButtonClicked(param1:starling.events.Event) : void
      {
         var _loc2_:flash.events.Event = null;
         var _loc3_:Boolean = false;
         for each(var _loc4_ in domainInfo.getBuilding(view.buildingInfo.buildingTypeId).calculateRecycleGainForLevel(view.buildingInfo.level))
         {
            if(city.resourceAmounts[_loc4_.resourceType] + _loc4_.resourceAmount > city.totalResourceCapacity >> 2)
            {
               _loc3_ = true;
               break;
            }
         }
         _loc2_ = new OutgoingMessageEvent("outgoingMessage",new RecycleBuildingRequest(view.buildingInfo.instanceId));
         if(_loc3_)
         {
            dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileResourceCapacityExceedsPopup("recycle",_loc2_,"closeSecondaryPopUpWindow")));
         }
         else
         {
            dispatch(_loc2_);
         }
         closeWindow();
      }
      
      private function onAssetChanged(param1:starling.events.Event) : void
      {
         view.drawLayout();
      }
   }
}

