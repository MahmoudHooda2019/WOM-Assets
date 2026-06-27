package wom.view.screen.windows.store
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import peak.display.View;
   import peak.i18n.lang.Languages;
   import peak.util.AlignmentUtil;
   import peak.util.NumberUtil;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextFormats;
   
   public class CurrentProgressView extends Sprite implements View
   {
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      private var _background:DisplayObject;
      
      private var _itemAsset:DisplayObject;
      
      private var _labelTextField:TextField;
      
      protected var valueTextField:TextField;
      
      public function CurrentProgressView()
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
         _background = assetRepository.getDisplayObject("BackgroundDark");
         _background.width = 86;
         _background.height = 30;
         addChild(_background);
         _itemAsset = assetRepository.getDisplayObject(getItemAssetId());
         _itemAsset.scaleX = _itemAsset.scaleY = getItemAssetScale();
         addChild(_itemAsset);
         _labelTextField = new CaptionTextField(WomTextFormats.BLACK_FILTER);
         _labelTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_18;
         _labelTextField.autoSize = "left";
         _labelTextField.text = getLabel();
         addChild(_labelTextField);
         valueTextField = new CaptionTextField(WomTextFormats.BLACK_FILTER);
         valueTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_18;
         valueTextField.autoSize = "left";
         valueTextField.text = "";
         addChild(valueTextField);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         if(Languages.activeLanguageId == "ar")
         {
            _background.x = _background.y = 0;
            AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_labelTextField,_background,_background.width + 15);
            AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_itemAsset,_background,_background.width - (_itemAsset.width >> 1));
         }
         else
         {
            _background.x = _labelTextField.width + 15;
            _background.y = 0;
            AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_labelTextField,_background,-_labelTextField.width - 15);
            AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_itemAsset,_background,-(_itemAsset.width >> 1));
         }
         AlignmentUtil.alignMiddleOf(valueTextField,_background);
      }
      
      protected function getItemAssetId() : String
      {
         return "TransparentAsset";
      }
      
      protected function getItemAssetScale() : Number
      {
         return 1;
      }
      
      protected function getLabel() : String
      {
         return "";
      }
      
      public function get itemAsset() : DisplayObject
      {
         return _itemAsset;
      }
      
      public function update(param1:Number) : void
      {
         valueTextField.text = NumberUtil.numberFormat(param1,0,false,false);
         drawLayout();
      }
   }
}

