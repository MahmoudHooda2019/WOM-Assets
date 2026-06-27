package wom.view.mediator.screen.windows.cancelconstruction
{
   import flash.events.Event;
   import starling.events.Event;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.message.request.CancelConstructionRequest;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.resource.MobileResourceCapacityExceedsPopup;
   import wom.view.screen.windows.cancelconstruction.MobileCancelConstructionWindow;
   
   public class MobileCancelConstructionWindowMediatior extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileCancelConstructionWindow;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      public function MobileCancelConstructionWindowMediatior()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.actionButton,"triggered",onUpgradeWithResourcesClicked,starling.events.Event);
         eventMap.mapStarlingListener(view.imageAsset,"change",onAssetChanged,starling.events.Event);
      }
      
      private function onUpgradeWithResourcesClicked(param1:starling.events.Event) : void
      {
         var _loc2_:flash.events.Event = null;
         closeWindow();
         if(view.capacityWillExceed)
         {
            _loc2_ = new OutgoingMessageEvent("outgoingMessage",new CancelConstructionRequest(view.buildingInfo.instanceId));
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileResourceCapacityExceedsPopup("cancel",_loc2_,"closePopUpWindow")));
         }
         else
         {
            dispatch(new OutgoingMessageEvent("outgoingMessage",new CancelConstructionRequest(view.buildingInfo.instanceId)));
         }
      }
      
      private function onAssetChanged(param1:starling.events.Event) : void
      {
         view.drawLayout();
      }
   }
}

