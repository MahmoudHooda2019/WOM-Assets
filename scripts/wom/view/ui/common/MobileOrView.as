package wom.view.ui.common
{
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import starling.display.Sprite;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.getCaptionTextFormat;
   
   public class MobileOrView extends Sprite
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var textField:MPTextField;
      
      public function MobileOrView()
      {
         super();
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      private function initLayout() : void
      {
         textField = new MobileCaptionTextField();
         textField.textRendererProperties.textFormat = getCaptionTextFormat(18);
         addChild(textField);
         var _temp_2:* = textField;
         var _loc1_:String = "ui.common.or";
         _temp_2.text = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         drawLayout();
      }
      
      private function drawLayout() : void
      {
      }
   }
}

