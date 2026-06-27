package wom.view.screen.popups
{
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getWomTextFormat;
   import wom.view.ui.common.MobileSpeechBubbleView;
   
   public class MobileDontKillMePopUp extends MobileBasePopUp
   {
      
      private static const WINDOW_WIDTH:int = 1230;
      
      private static const WINDOW_HEIGHT:int = 755;
      
      private var possibleCausesSprite:Sprite;
      
      private var possibleCausesBg:DisplayObject;
      
      private var possibleCausesTextField:MPTextField;
      
      private var tick0:DisplayObject;
      
      private var tick1:DisplayObject;
      
      private var tick2:DisplayObject;
      
      public function MobileDontKillMePopUp(param1:int = 1230, param2:int = 755)
      {
         var _loc4_:int;
         super(param1 >> 1,(_loc4_ = param2) >> 1);
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.popups.dontkillme.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         _imageAsset = assetRepository.getDisplayObject("PoseWorker3");
         addChild(_imageAsset);
         var _temp_4:* = §§findproperty(MobileSpeechBubbleView);
         var _temp_3:* = 470;
         var _loc2_:String = "ui.popups.dontkillme.message";
         _speechBubble = new MobileSpeechBubbleView(_temp_3,peak.i18n.PText.INSTANCE.getText0(_loc2_),null,false,37,203,55);
         addChild(_speechBubble);
         _actionButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Large");
         _actionButton.width = 196;
         var _temp_7:* = _actionButton;
         var _loc3_:String = "ui.popups.dontkillme.retry";
         _temp_7.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         addChild(_actionButton);
         possibleCausesSprite = new Sprite();
         addChild(possibleCausesSprite);
         possibleCausesBg = assetRepository.getDisplayObject("MobileDarkBackground");
         possibleCausesBg.width = 432;
         possibleCausesBg.height = 155;
         possibleCausesTextField = new MobileWomTextField();
         possibleCausesTextField.textRendererProperties.textFormat = getWomTextFormat(22,"left",16777215);
         possibleCausesTextField.width = 345;
         possibleCausesTextField.textRendererProperties.multiline = true;
         possibleCausesTextField.textRendererProperties.wordWrap = true;
         var _temp_11:* = possibleCausesTextField;
         var _loc4_:String = "ui.popups.dontkillme.possiblecauses.message";
         _temp_11.text = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         tick0 = assetRepository.getDisplayObject("SymbolTickDisable");
         tick1 = assetRepository.getDisplayObject("SymbolTickDisable");
         tick2 = assetRepository.getDisplayObject("SymbolTickDisable");
         possibleCausesSprite.addChild(possibleCausesBg);
         possibleCausesSprite.addChild(possibleCausesTextField);
         possibleCausesSprite.addChild(tick0);
         possibleCausesSprite.addChild(tick1);
         possibleCausesSprite.addChild(tick2);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(_imageAsset,_background,-180,-110);
         MobileAlignmentUtil.alignAccordingToPositionOf(_speechBubble,_background,107,50);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_actionButton,_background,320);
         possibleCausesSprite.x = _speechBubble.x + 19;
         possibleCausesSprite.y = 135;
         MobileAlignmentUtil.alignAccordingToPositionOf(possibleCausesTextField,possibleCausesBg,59,20);
         MobileAlignmentUtil.alignAccordingToPositionOf(tick0,possibleCausesBg,20,18);
         MobileAlignmentUtil.alignAccordingToPositionOf(tick1,possibleCausesBg,20,75);
         MobileAlignmentUtil.alignAccordingToPositionOf(tick2,possibleCausesBg,20,108);
      }
   }
}

