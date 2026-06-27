package wom.view.mediator.screen.windows.announcement
{
   import wom.controller.event.AnnouncementHeaderEvent;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.windows.announcement.MobileAnnouncementWindow;
   
   public class MobileAnnouncementWindowMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileAnnouncementWindow;
      
      public function MobileAnnouncementWindowMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         addContextListener("announcementHeaderUpdated",onHeaderUpdated,AnnouncementHeaderEvent);
      }
      
      private function onHeaderUpdated(param1:AnnouncementHeaderEvent) : void
      {
         view.unflattenStaticLayer();
         view.setHeader(param1.header);
         view.flattenStaticLayer();
      }
   }
}

