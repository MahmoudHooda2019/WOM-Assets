package wom.view.screen.popups
{
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.domain.domaininfoobject.BeastTypeDIO;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getWomTextFormat;
   import wom.view.ui.common.MobileSpeechBubbleView;
   
   public class MobileBeastUnleashedPopUp extends MobileBasePopUp
   {
      
      private static const WINDOW_WIDTH:int = 475;
      
      private static const WINDOW_HEIGHT:int = 580;
      
      private var _beastDIO:BeastTypeDIO;
      
      private var _chainAsset:DisplayObject;
      
      public function MobileBeastUnleashedPopUp(param1:BeastTypeDIO, param2:int = 475, param3:int = 580)
      {
         super(param2,param3);
         _beastDIO = param1;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _temp_1:* = "ui.popups.beast.unleashed.header";
         var _loc1_:String = "domain.beasts." + _beastDIO.id + ".name";
         var _loc2_:* = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         var _loc3_:String = _temp_1;
         setHeader(peak.i18n.PText.INSTANCE.getText1(_loc3_,_loc2_));
         _imageAsset = assetRepository.getDisplayObject("Womkong6");
         addChild(_imageAsset);
         _chainAsset = assetRepository.getDisplayObject("BrokenChain");
         addChild(_chainAsset);
         var _temp_6:* = §§findproperty(MobileSpeechBubbleView);
         var _temp_5:* = windowWidth - 50;
         var _loc4_:String = "ui.popups.beast.unleashed." + _beastDIO.id + ".desc";
         _speechBubble = new MobileSpeechBubbleView(_temp_5,peak.i18n.PText.INSTANCE.getText0(_loc4_),getWomTextFormat(23,"center",0),false,30,35);
         addChild(_speechBubble);
         _speechBubble.speechBubbleArrow.visible = false;
         _actionButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Large");
         _actionButton.width = 221;
         var _temp_9:* = _actionButton;
         var _loc5_:String = "ui.popups.beast.unleashed.done";
         _temp_9.label = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         addChild(_actionButton);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(_imageAsset,_background,58,34);
         MobileAlignmentUtil.alignAccordingToPositionOf(_chainAsset,_background,85,66);
         MobileAlignmentUtil.alignAccordingToPositionOf(_speechBubble,_background,25,395);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_actionButton,_background,windowHeight - _actionButton.height / 2 - 6);
      }
      
      public function get beastDIO() : BeastTypeDIO
      {
         return _beastDIO;
      }
      
      public function get chainAsset() : DisplayObject
      {
         return _chainAsset;
      }
   }
}

