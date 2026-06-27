package wom.view.ui.mainframe.defend
{
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.getCaptionTextFormat;
   import wom.view.ui.mainframe.MobileUILayer;
   
   public class MobileNPCAttackUILayer extends MobileUILayer
   {
      
      private var bottomPanelBackground:DisplayObject;
      
      private var bottomLine:DisplayObject;
      
      private var messageTextField:MobileCaptionTextField;
      
      public function MobileNPCAttackUILayer()
      {
         super();
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         removeChild(_landlordAvatar);
         bottomLine = assetRepository.getDisplayObject("DefenceViewLineSkin");
         bottomLine.width = visibleWidth;
         addChild(bottomLine);
         bottomPanelBackground = assetRepository.getDisplayObject("DefenceViewBarSkin");
         bottomPanelBackground.width = 550;
         addChild(bottomPanelBackground);
         messageTextField = new MobileCaptionTextField();
         messageTextField.textRendererProperties.textFormat = getCaptionTextFormat(42);
         var _temp_4:* = messageTextField;
         var _loc1_:String = "ui.mainframe.defend.enjoy";
         _temp_4.text = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         addChild(messageTextField);
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         bottomLine.width = visibleWidth;
         bottomLine.y = visibleHeight - bottomLine.height;
         bottomLine.x = 0;
         bottomPanelBackground.y = visibleHeight - bottomPanelBackground.height;
         bottomPanelBackground.x = visibleWidth - bottomPanelBackground.width >> 1;
         MobileAlignmentUtil.alignMiddleOf(messageTextField,bottomPanelBackground);
      }
   }
}

