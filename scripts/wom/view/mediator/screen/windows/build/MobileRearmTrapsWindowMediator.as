package wom.view.mediator.screen.windows.build
{
   import starling.events.Event;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.message.request.RearmTrapsRequest;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.notenough.MobileNotEnoughPopup;
   import wom.view.screen.windows.build.MobileRearmTrapsWindow;
   
   public class MobileRearmTrapsWindowMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileRearmTrapsWindow;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function MobileRearmTrapsWindowMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.rearmWithResourcesButton,"triggered",onRearmWithResourcesClicked,Event);
         eventMap.mapStarlingListener(view.rearmWithGoldButton,"triggered",onRearmWithGoldClicked,Event);
         eventMap.mapStarlingListener(view.trapsSilhouette,"change",onAssetChanged,Event);
         addContextListener("resourcesUpdated",onResourcesUpdated);
         onResourcesUpdated(null);
      }
      
      private function onResourcesUpdated(param1:Event) : void
      {
         view.updateWithResources(city.resourceAmounts);
      }
      
      private function onRearmWithGoldClicked(param1:Event) : void
      {
         if(userInfo.numberOfGolds < view.totalGoldCost)
         {
            dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileNotEnoughPopup("gold")));
            return;
         }
         rearm(true);
      }
      
      private function onRearmWithResourcesClicked(param1:Event) : void
      {
         rearm(false);
      }
      
      private function rearm(param1:Boolean) : void
      {
         dispatch(new OutgoingMessageEvent("outgoingMessage",new RearmTrapsRequest(param1)));
         closeWindow();
      }
      
      private function onAssetChanged(param1:Event) : void
      {
         view.drawLayout();
      }
   }
}

