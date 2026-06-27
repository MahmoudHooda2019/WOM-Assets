package wom.view.mediator.ui.mainframe.city.notification
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import starling.events.Event;
   import wom.controller.event.GameModeChangedEvent;
   import wom.controller.event.mobile.MobileExternalInterfaceEvent;
   import wom.controller.event.ui.MobileUserNotificationViewEvent;
   import wom.controller.event.ui.UserNotificationEvent;
   import wom.model.game.viral.WallPostParams;
   import wom.view.ui.mainframe.city.notification.MobileUserNotificationView;
   
   public class MobileUserNotificationViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileUserNotificationView;
      
      [Inject]
      public var injector:IInjector;
      
      public function MobileUserNotificationViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         injector.injectInto(view);
         eventMap.mapStarlingListener(view.shareButton,"triggered",onShareButtonClicked,Event);
         addViewListener("mobileUserNotificationViewEventCompleted",onTweenComplete,MobileUserNotificationViewEvent);
         addContextListener("gameModeChange",onGameModeChange,GameModeChangedEvent);
      }
      
      private function onGameModeChange(param1:GameModeChangedEvent) : void
      {
         if(view && view.visible && view.userNotification && view.userNotification.type == 4)
         {
            view.hide(true);
         }
      }
      
      private function onShareButtonClicked(param1:Event) : void
      {
         if(view.userNotification != null && !view.userNotification.wallPostSuccess)
         {
            view.userNotification.wallPostSuccess = true;
            view.hide();
            switch(view.userNotification.subtype - 1)
            {
               case 0:
                  if("buildingTypeId" in view.userNotification.additionalInfo)
                  {
                     dispatch(new MobileExternalInterfaceEvent("makeWallPost",new WallPostParams(1,view.userNotification.additionalInfo["buildingTypeId"])));
                  }
                  break;
               case 1:
                  if("buildingTypeId" in view.userNotification.additionalInfo && "level" in view.userNotification.additionalInfo)
                  {
                     dispatch(new MobileExternalInterfaceEvent("makeWallPost",new WallPostParams(10,view.userNotification.additionalInfo["buildingTypeId"],view.userNotification.additionalInfo["level"])));
                  }
                  break;
               case 2:
                  if("buildingTypeId" in view.userNotification.additionalInfo && "level" in view.userNotification.additionalInfo)
                  {
                     dispatch(new MobileExternalInterfaceEvent("makeWallPost",new WallPostParams(2,view.userNotification.additionalInfo["buildingTypeId"],view.userNotification.additionalInfo["level"])));
                  }
            }
         }
      }
      
      private function onTweenComplete(param1:MobileUserNotificationViewEvent) : void
      {
         dispatch(new UserNotificationEvent("userNotificationEventCompleted"));
      }
   }
}

