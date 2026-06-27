package wom.view.screen.windows.announcement
{
   import peak.util.MobileAlignmentUtil;
   import wom.model.game.AnnouncementInfo;
   import wom.view.util.MobileGenericWindow;
   
   public class MobileAnnouncementWindow extends MobileGenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 642;
      
      private static const WINDOW_HEIGHT:int = 541;
      
      private var _announcements:Vector.<AnnouncementInfo>;
      
      private var _announcementPanel:MobileAnnouncementPanel;
      
      public function MobileAnnouncementWindow(param1:Vector.<AnnouncementInfo> = null)
      {
         super(642,541);
         _announcements = param1 != null ? param1 : new Vector.<AnnouncementInfo>();
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         if(_announcements.length > 0)
         {
            setHeader(_announcements[0].header);
         }
         _announcementPanel = new MobileAnnouncementPanel(_announcements);
         addChild(_announcementPanel);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignMiddleOf(_announcementPanel,_background);
      }
   }
}

