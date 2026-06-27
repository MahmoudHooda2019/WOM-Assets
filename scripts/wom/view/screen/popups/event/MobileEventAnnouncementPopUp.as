package wom.view.screen.popups.event
{
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.resource.MobileWomDefaultAssetRepository;
   import wom.view.component.MobileWomTextField;
   import wom.view.getWomTextFormat;
   import wom.view.util.MobileGenericWindow;
   
   public class MobileEventAnnouncementPopUp extends MobileGenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 832;
      
      private static const WINDOW_HEIGHT:int = 562;
      
      private var imageBackground:DisplayObject;
      
      private var eventTextField:MPTextField;
      
      private var darkBackground:DisplayObject;
      
      private var eventBackgroundImageName:String;
      
      public function MobileEventAnnouncementPopUp(param1:String, param2:int = 832, param3:int = 562)
      {
         super(param2,param3);
         this.eventBackgroundImageName = param1;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc4_:String = "ui.popups.event.announcement.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc4_));
         darkBackground = assetRepository.getDisplayObject("MobileDarkBackground");
         darkBackground.width = 764;
         darkBackground.height = 490;
         addChild(darkBackground);
         var _loc3_:String = MobileWomDefaultAssetRepository.fixEventAssetName(eventBackgroundImageName);
         var _loc1_:Number = 764;
         var _loc2_:Number = 489;
         imageBackground = assetRepository.getRemoteDisplayObject(_loc3_,_loc1_,_loc2_);
         addChild(imageBackground);
         eventTextField = new MobileWomTextField();
         eventTextField.width = _background.width - 338;
         eventTextField.textRendererProperties.textFormat = getWomTextFormat(21,"center");
         eventTextField.textRendererProperties.wordWrap = true;
         addChild(eventTextField);
         var _temp_5:* = eventTextField;
         var _loc5_:String = "ui.popups.event.announcement.desc";
         _temp_5.text = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignMiddleOf(darkBackground,_background);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(imageBackground,darkBackground,0);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(eventTextField,imageBackground,_background.height - eventTextField.height - 100);
      }
   }
}

