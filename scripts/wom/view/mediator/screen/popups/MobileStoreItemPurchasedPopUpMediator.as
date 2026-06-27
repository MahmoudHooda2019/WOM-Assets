package wom.view.mediator.screen.popups
{
   import starling.events.Event;
   import wom.controller.event.mobile.MobileExternalInterfaceEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.game.viral.WallPostParams;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.MobileStoreItemPurchasedPopUp;
   
   public class MobileStoreItemPurchasedPopUpMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileStoreItemPurchasedPopUp;
      
      public function MobileStoreItemPurchasedPopUpMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.itemAsset,"change",onAssetChanged,Event);
         eventMap.mapStarlingListener(view.boastToFriendsButton,"triggered",onBoastToFriendsButtonClicked,Event);
         view.lightView.rotate(120);
      }
      
      private function onAssetChanged(param1:Event) : void
      {
         view.drawLayout();
      }
      
      private function onBoastToFriendsButtonClicked(param1:Event) : void
      {
         dispatch(new MobileExternalInterfaceEvent("makeWallPost",new WallPostParams(13,view.storeItemInfo.id)));
         closeWindow();
      }
      
      override protected function closeWindow() : void
      {
         dispatch(new MobilePopUpWindowEvent("closeSecondaryPopUpWindow",view));
      }
   }
}

