package wom.view.mediator.ui.mainframe.city.notification
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import peak.resource.SoundPlayer;
   import wom.controller.event.ui.UserNotificationEvent;
   import wom.model.game.UserInfo;
   import wom.model.game.VisitInfo;
   import wom.model.game.attack.GameModeType;
   import wom.model.game.viral.UserNotification;
   import wom.view.ui.mainframe.city.notification.MobileUserNotificationPanel;
   
   public class MobileUserNotificationPanelMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileUserNotificationPanel;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var soundPlayer:SoundPlayer;
      
      [Inject]
      public var visitInfo:VisitInfo;
      
      public function MobileUserNotificationPanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         injector.injectInto(view);
         addContextListener("userNotificationEventCompleted",onNotificationCompleted,UserNotificationEvent);
         checkNotifications();
      }
      
      private function onNotificationCompleted(param1:UserNotificationEvent) : void
      {
         checkNotifications();
      }
      
      private function checkNotifications() : void
      {
         var _loc1_:int = 0;
         var _loc2_:UserNotification = null;
         var _loc4_:int = 0;
         var _loc3_:Boolean = false;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         if(view.visible && userInfo.notifications.length > 0)
         {
            _loc1_ = 0;
            while(_loc1_ < userInfo.notifications.length)
            {
               _loc2_ = userInfo.notifications[_loc1_];
               if(_loc2_.type in UserNotification.GAME_MODE && (UserNotification.GAME_MODE[_loc2_.type] == GameModeType.UNKNOWN || userInfo.gameMode == UserNotification.GAME_MODE[_loc2_.type]))
               {
                  _loc4_ = -1;
                  _loc3_ = false;
                  _loc6_ = 0;
                  while(_loc6_ < view.notificationViews.length)
                  {
                     if(view.notificationViews[_loc6_].ongoingAnimation)
                     {
                        _loc4_ = _loc6_;
                        if(view.notificationViews[_loc6_].userNotification.type == _loc2_.type)
                        {
                           _loc3_ = true;
                        }
                     }
                     _loc6_++;
                  }
                  if(!_loc3_)
                  {
                     _loc5_ = _loc4_ < view.notificationViews.length - 1 ? _loc4_ + 1 : 0;
                     if(!view.notificationViews[_loc5_].ongoingAnimation)
                     {
                        userInfo.notifications.splice(_loc1_,1);
                        view.notificationViews[_loc5_].updateWithNotificationInfo(_loc2_);
                        if(_loc2_.type == 4)
                        {
                           soundPlayer.playSfxById("QuestCompleted");
                        }
                     }
                  }
               }
               _loc1_++;
            }
         }
      }
   }
}

