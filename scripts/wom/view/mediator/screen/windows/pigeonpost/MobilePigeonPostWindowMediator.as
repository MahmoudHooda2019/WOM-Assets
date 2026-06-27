package wom.view.mediator.screen.windows.pigeonpost
{
   import starling.events.Event;
   import starling.events.TouchEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.mobile.MobileExternalInterfaceEvent;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.building.BuildingTypeInfo;
   import wom.model.message.request.UpdatePigeonPostSubscriptionsMessageRequest;
   import wom.service.mobile.MobileExternalPages;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.windows.pigeonpost.MobilePigeonPostWindow;
   
   public class MobilePigeonPostWindowMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobilePigeonPostWindow;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var cityInfo:CityStatusInfo;
      
      [Inject]
      public var mobileExternalPagesService:MobileExternalPages;
      
      public function MobilePigeonPostWindowMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.imageAsset,"change",onAssetChanged,Event);
         eventMap.mapStarlingListener(view.infoButton,"change",onAssetChanged,Event);
         eventMap.mapStarlingListener(view.actionButton,"triggered",onSaveCloseButtonClicked,Event);
         eventMap.mapStarlingListener(view.visitForumButton,"triggered",onForumButtonClicked,Event);
         eventMap.mapStarlingListener(view.infoButton,"triggered",onInfoButtonClicked,Event);
         addContextListener("subscribedActionsUpdated",onSubscribedActionsUpdated,ModelUpdateEvent);
         addContextListener("buildingTypesUpdated",onSubscribedActionsUpdated,ModelUpdateEvent);
         view.fillList(userInfo.subscribedActions,cityInfo.buildingTypes[29] as BuildingTypeInfo);
         if(mobileExternalPagesService.externalPages == null)
         {
            dispatch(new MobileExternalInterfaceEvent("getExternalURLs",{}));
         }
      }
      
      private function onAssetChanged(param1:Event) : void
      {
         view.drawLayout();
      }
      
      private function onSubscribedActionsUpdated(param1:ModelUpdateEvent) : void
      {
         view.fillList(userInfo.subscribedActions,cityInfo.buildingTypes[29] as BuildingTypeInfo);
      }
      
      private function onSaveCloseButtonClicked(param1:Event) : void
      {
         var _loc3_:Vector.<int> = new Vector.<int>();
         for each(var _loc2_ in view.checkBoxList.selectedItems)
         {
            _loc3_.push(_loc2_.subscription.id);
         }
         dispatch(new OutgoingMessageEvent("outgoingMessage",new UpdatePigeonPostSubscriptionsMessageRequest(_loc3_)));
         closeWindow();
      }
      
      private function onForumButtonClicked(param1:TouchEvent) : void
      {
         mobileExternalPagesService.openURL("pigeonpost");
      }
      
      private function onInfoButtonClicked(param1:Event) : void
      {
         view.infoButtonClicked();
      }
   }
}

