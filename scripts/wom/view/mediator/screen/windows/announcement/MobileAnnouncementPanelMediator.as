package wom.view.mediator.screen.windows.announcement
{
   import starling.events.Event;
   import wom.controller.event.AnnouncementHeaderEvent;
   import wom.controller.event.mobile.MobileExternalInterfaceEvent;
   import wom.model.game.AnnouncementInfo;
   import wom.model.mobile.MobileConnectionServiceInfo;
   import wom.view.mediator.util.MobileBaseWindowPanelMediator;
   import wom.view.screen.windows.announcement.MobileAnnouncementItemViewRenderer;
   import wom.view.screen.windows.announcement.MobileAnnouncementPanel;
   
   public class MobileAnnouncementPanelMediator extends MobileBaseWindowPanelMediator
   {
      
      [Inject]
      public var view:MobileAnnouncementPanel;
      
      [Inject]
      public var mobileConnectionServiceInfo:MobileConnectionServiceInfo;
      
      public function MobileAnnouncementPanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.announcementList,"scrollComplete",onScrollCompleted,Event);
         view.fillAnnouncements();
         onScrollCompleted(null,null);
      }
      
      private function onScrollCompleted(param1:Event, param2:MobileAnnouncementItemViewRenderer = null) : void
      {
         var _loc3_:AnnouncementInfo = view.selectedAnnouncement;
         dispatch(new AnnouncementHeaderEvent("announcementHeaderUpdated",_loc3_.header));
         view.updateNumOfPages();
         if(!_loc3_.seen)
         {
            _loc3_.seen = true;
            dispatch(new MobileExternalInterfaceEvent("setAnnouncementAsSeen",_loc3_.id));
         }
      }
   }
}

