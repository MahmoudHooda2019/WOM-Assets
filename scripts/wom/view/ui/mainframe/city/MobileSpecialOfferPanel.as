package wom.view.ui.mainframe.city
{
   import peak.component.mobile.MPRigidButton;
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.Sprite;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileWomTextField;
   import wom.view.getCaptionTextFormat;
   
   public class MobileSpecialOfferPanel extends Sprite
   {
      
      private static const WIDTH:int = 36;
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _specialOfferButton:MPRigidButton;
      
      private var _textField:MPTextField;
      
      public function MobileSpecialOfferPanel()
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
         _specialOfferButton = new MPRigidButton("IconSpecialOffer","IconSpecialOffer");
         addChild(_specialOfferButton);
         _textField = new MobileWomTextField();
         _textField.textRendererProperties.textFormat = getCaptionTextFormat(19,"center");
         _textField.textRendererProperties.wordWrap = true;
         _textField.width = 36;
         addChild(_textField);
         var _temp_3:* = _textField;
         var _loc1_:String = "m.ui.mainframe.city.specialoffer";
         _temp_3.text = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         _specialOfferButton.validate();
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_textField,_specialOfferButton,_specialOfferButton.height - 20);
      }
      
      public function get specialOfferButton() : MPRigidButton
      {
         return _specialOfferButton;
      }
   }
}

