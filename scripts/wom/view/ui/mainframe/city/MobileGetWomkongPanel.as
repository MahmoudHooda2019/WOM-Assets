package wom.view.ui.mainframe.city
{
   import peak.component.mobile.MPRigidButton;
   import peak.component.mobile.MPTextField;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.starling.FlatteningSprite;
   import peak.util.MobileAlignmentUtil;
   import starling.display.Sprite;
   import wom.view.component.MobileWomTextField;
   import wom.view.getCaptionTextFormat;
   
   public class MobileGetWomkongPanel extends Sprite implements View
   {
      
      private static const WIDTH:int = 32;
      
      private static const HEIGHT:int = 33;
      
      private var _getWomkongButton:MPRigidButton;
      
      private var _textField:MPTextField;
      
      public function MobileGetWomkongPanel()
      {
         super();
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         _getWomkongButton = new MPRigidButton("IconGetWomkong","IconGetWomkong");
         addChild(_getWomkongButton);
         _textField = new MobileWomTextField();
         _textField.textRendererProperties.textFormat = getCaptionTextFormat(17,"center");
         _textField.textRendererProperties.wordWrap = true;
         _textField.width = 32;
         addChild(_textField);
      }
      
      public function drawLayout() : void
      {
         _getWomkongButton.validate();
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_textField,_getWomkongButton,_getWomkongButton.height - 10);
      }
      
      public function updateWomkongUnlockStatus(param1:Boolean) : void
      {
         if(parent is FlatteningSprite && parent.stage)
         {
            (parent as FlatteningSprite).unflatten();
         }
         var _loc2_:String;
         var _loc3_:String;
         _textField.text = param1 ? (_loc2_ = "ui.mainframe.city.tavern",peak.i18n.PText.INSTANCE.getText0(_loc2_)) : (_loc3_ = "ui.mainframe.city.getwomkong",peak.i18n.PText.INSTANCE.getText0(_loc3_));
         drawLayout();
         if(parent is FlatteningSprite && parent.stage)
         {
            (parent as FlatteningSprite).flatten();
         }
      }
      
      public function get getWomkongButton() : MPRigidButton
      {
         return _getWomkongButton;
      }
   }
}

