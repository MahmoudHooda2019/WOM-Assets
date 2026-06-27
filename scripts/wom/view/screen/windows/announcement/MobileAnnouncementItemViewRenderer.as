package wom.view.screen.windows.announcement
{
   import feathers.controls.renderers.IListItemRenderer;
   import peak.component.mobile.MPItemRenderer;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.game.AnnouncementInfo;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileWomTextField;
   import wom.view.getWomTextFormat;
   
   public class MobileAnnouncementItemViewRenderer extends MPItemRenderer implements IListItemRenderer
   {
      
      private static const WIDTH:int = 560;
      
      private static const HEIGHT:int = 440;
      
      private var _announcementObject:Object;
      
      private var _announcement:AnnouncementInfo;
      
      private var assetRepository:MobileWomAssetRepository;
      
      private var _announcementAsset:DisplayObject;
      
      private var _descTextField:MobileWomTextField;
      
      private var background:DisplayObject;
      
      public function MobileAnnouncementItemViewRenderer(param1:MobileWomAssetRepository)
      {
         super();
         this.assetRepository = param1;
         init();
      }
      
      private function init() : void
      {
         drawBackground();
         _descTextField = new MobileWomTextField();
         _descTextField.width = 540;
         _descTextField.textRendererProperties.textFormat = getWomTextFormat(23,"center",16777215);
         _descTextField.textRendererProperties.wordWrap = true;
         addChild(_descTextField);
         drawLayout();
      }
      
      private function drawBackground() : void
      {
         if(!background)
         {
            background = assetRepository.getDisplayObject("MobileDarkBackground");
            addChild(background);
            background.width = 560;
            background.height = 440;
         }
      }
      
      private function drawLayout() : void
      {
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_descTextField,background,290);
         if(_announcementAsset)
         {
            MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_announcementAsset,background,0);
         }
      }
      
      override public function get data() : Object
      {
         return _announcementObject;
      }
      
      override public function set data(param1:Object) : void
      {
         if(param1)
         {
            _announcementObject = param1;
            _announcement = param1.announcementInfo;
            updateAnnouncement();
         }
      }
      
      private function updateAnnouncement() : void
      {
         _descTextField.text = _announcement.desc;
         if(_announcementAsset && contains(_announcementAsset))
         {
            removeChild(_announcementAsset);
         }
         _announcementAsset = assetRepository.getRemoteDisplayObject("Announcement_" + _announcement.id,560,276,_announcement.assetURL);
         addChild(_announcementAsset);
         drawLayout();
      }
   }
}

