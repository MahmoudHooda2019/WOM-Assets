package wom.view.ui.mainframe.city.notification
{
   import peak.display.View;
   import starling.display.Sprite;
   
   public class MobileUserNotificationPanel extends Sprite implements View
   {
      
      private static const MAX_VIEWS:int = 2;
      
      private static const VIEW_HEIGHT:int = 84;
      
      private var _notificationViews:Vector.<MobileUserNotificationView>;
      
      public function MobileUserNotificationPanel()
      {
         super();
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
         drawLayout();
      }
      
      public function initLayout() : void
      {
         var _loc1_:int = 0;
         _notificationViews = new Vector.<MobileUserNotificationView>(2);
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            _notificationViews[_loc1_] = new MobileUserNotificationView();
            addChild(_notificationViews[_loc1_]);
            _loc1_++;
         }
      }
      
      public function drawLayout() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            _notificationViews[_loc1_].x = 0;
            _notificationViews[_loc1_].y = _loc1_ * 84;
            _loc1_++;
         }
      }
      
      public function get notificationViews() : Vector.<MobileUserNotificationView>
      {
         return _notificationViews;
      }
      
      public function get visibleWidth() : int
      {
         return 284;
      }
   }
}

