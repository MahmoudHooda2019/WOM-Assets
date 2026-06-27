package wom.view.screen.windows.announcement
{
   import feathers.controls.renderers.IListItemRenderer;
   import feathers.data.ListCollection;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import wom.model.game.AnnouncementInfo;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomCarousel;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   import wom.view.util.MobileBaseWindowPanel;
   
   public class MobileAnnouncementPanel extends MobileBaseWindowPanel
   {
      
      private static const WIDTH:int = 584;
      
      private static const HEIGHT:int = 480;
      
      private var _announcementList:MobileWomCarousel;
      
      private var _announcements:Vector.<AnnouncementInfo>;
      
      private var _numOfPagesTextField:MobileCaptionTextField;
      
      public function MobileAnnouncementPanel(param1:Vector.<AnnouncementInfo>)
      {
         super(584,480);
         _announcements = param1;
      }
      
      override protected function get backgroundAssetId() : String
      {
         return "TransparentAsset";
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         if(_announcements.length > 0)
         {
            _announcementList = MobileWomUIComponentFactory.createCarousel("horizontal",10,730,450);
            _announcementList.itemRendererFactory = announcementRendererFactory;
            _announcementList.width = 584 - 4;
            _announcementList.height = 480;
            addChild(_announcementList);
            _numOfPagesTextField = new MobileCaptionTextField();
            _numOfPagesTextField.textRendererProperties.textFormat = getCaptionTextFormat(21);
            addChild(_numOfPagesTextField);
            drawLayout();
         }
      }
      
      public function fillAnnouncements() : void
      {
         var _loc1_:Array = [];
         for each(var _loc2_ in _announcements)
         {
            if(!_loc2_.seen)
            {
               _loc1_.push({"announcementInfo":_loc2_});
            }
         }
         _announcementList.dataProvider = new ListCollection(_loc1_);
         var _temp_3:* = _numOfPagesTextField;
         var _temp_2:* = "ui.windows.announcement.numofpages";
         var _temp_1:* = 1;
         var _loc5_:int = _announcementList.dataProvider.length;
         var _loc6_:int = _temp_1;
         var _loc7_:String = _temp_2;
         _temp_3.text = peak.i18n.PText.INSTANCE.getText2(_loc7_,_loc6_,_loc5_);
         drawLayout();
      }
      
      private function announcementRendererFactory() : IListItemRenderer
      {
         var _loc1_:MobileAnnouncementItemViewRenderer = new MobileAnnouncementItemViewRenderer(assetRepository);
         _loc1_.width = 730;
         _loc1_.height = 440;
         return _loc1_;
      }
      
      override public function drawLayout() : void
      {
         if(_numOfPagesTextField != null)
         {
            MobileAlignmentUtil.alignAccordingToPositionOf(_numOfPagesTextField,bg,584 - 13 - _numOfPagesTextField.width,474);
         }
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_announcementList,bg,20);
         super.drawLayout();
      }
      
      public function get selectedAnnouncement() : AnnouncementInfo
      {
         var _loc2_:int = _announcementList.selectedPageIndex;
         var _loc3_:ListCollection = _announcementList.dataProvider;
         return _loc3_.getItemAt(_loc2_).announcementInfo;
      }
      
      public function get announcementList() : MobileWomCarousel
      {
         return _announcementList;
      }
      
      public function updateNumOfPages() : void
      {
         if(_numOfPagesTextField != null)
         {
            var _temp_3:* = _numOfPagesTextField;
            var _temp_2:* = "ui.windows.announcement.numofpages";
            var _temp_1:* = _announcementList.selectedPageIndex + 1;
            var _loc1_:int = _announcementList.dataProvider.length;
            var _loc2_:Number = _temp_1;
            var _loc3_:String = _temp_2;
            _temp_3.text = peak.i18n.PText.INSTANCE.getText2(_loc3_,_loc2_,_loc1_);
         }
      }
   }
}

