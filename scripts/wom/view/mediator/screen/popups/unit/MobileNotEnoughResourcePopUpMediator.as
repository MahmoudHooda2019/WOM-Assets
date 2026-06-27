package wom.view.mediator.screen.popups.unit
{
   import starling.events.Event;
   import wom.controller.event.model.NotEnoughResourceEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.game.resource.ResourceType;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.unit.MobileNotEnoughResourcePopUp;
   
   public class MobileNotEnoughResourcePopUpMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileNotEnoughResourcePopUp;
      
      public function MobileNotEnoughResourcePopUpMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.imageAsset,"change",onWorkerAssetChange);
         eventMap.mapStarlingListener(view.actionButton,"triggered",onOkButtonClicked,Event);
      }
      
      public function onWorkerAssetChange(param1:Event) : void
      {
         view.drawLayout();
      }
      
      protected function onOkButtonClicked(param1:Event) : void
      {
         var _loc2_:Object = view.resourceType == ResourceType.IRON ? {"unitTypeId":view.unitTypeId} : null;
         if(view.resourceType == ResourceType.UNKNOWN)
         {
            dispatch(new NotEnoughResourceEvent("resourceTypeUnknown",view.resourceType,_loc2_));
         }
         else
         {
            dispatch(new NotEnoughResourceEvent("resourceTypeKnown",view.resourceType,_loc2_));
         }
         closeWindow();
      }
      
      override protected function closeWindow() : void
      {
         dispatch(new MobilePopUpWindowEvent("closeSecondaryPopUpWindow",view));
      }
   }
}

