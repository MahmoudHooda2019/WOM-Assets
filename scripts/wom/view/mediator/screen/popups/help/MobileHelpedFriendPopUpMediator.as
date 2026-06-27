package wom.view.mediator.screen.popups.help
{
   import starling.events.Event;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.mobile.MobileExternalInterfaceEvent;
   import wom.model.game.viral.WallPostParams;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.help.MobileHelpedFriendLineRenderer;
   import wom.view.screen.popups.help.MobileHelpedFriendPopUp;
   
   public class MobileHelpedFriendPopUpMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var baseView:MobileHelpedFriendPopUp;
      
      public function MobileHelpedFriendPopUpMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(baseView.imageAsset,"change",onAssetChanged,Event);
         eventMap.mapStarlingListener(baseView.actionButton,"triggered",onSayThanksButtonClicked,Event);
         eventMap.mapStarlingListener(baseView.list,"rendererAdd",onRendererAdd,Event);
         eventMap.mapStarlingListener(baseView.list,"rendererRemove",onRendererRemove,Event);
         baseView.drawLayout();
      }
      
      private function onRendererRemove(param1:Event, param2:MobileHelpedFriendLineRenderer) : void
      {
         addContextListener("platformUsersUpdated",param2.onPlatformUsersUpdated,ModelUpdateEvent);
      }
      
      private function onRendererAdd(param1:Event, param2:MobileHelpedFriendLineRenderer) : void
      {
         removeContextListener("platformUsersUpdated",param2.onPlatformUsersUpdated,ModelUpdateEvent);
      }
      
      private function onAssetChanged(param1:Event) : void
      {
         baseView.drawLayout();
      }
      
      protected function onSayThanksButtonClicked(param1:Event) : void
      {
         closeWindow();
         dispatch(new MobileExternalInterfaceEvent("makeWallPost",new WallPostParams(4,baseView.numOfHelps)));
      }
   }
}

