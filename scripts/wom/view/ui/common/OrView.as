package wom.view.ui.common
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextFormats;
   
   public class OrView extends Sprite
   {
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      private var orIcon:DisplayObject;
      
      private var textField:TextField;
      
      public function OrView()
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
         orIcon = assetRepository.getDisplayObject("Or");
         addChildAt(orIcon,0);
         textField = new CaptionTextField(WomTextFormats.BLACK_FILTER_SOFT);
         textField.defaultTextFormat = WomTextFormats.CENTER_20;
         textField.width = orIcon.width;
         var _temp_3:* = textField;
         var _loc1_:String = "ui.common.or";
         _temp_3.text = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         addChild(textField);
         textField.height = textField.textHeight + 4;
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         AlignmentUtil.alignMiddleYAxisOf(textField,orIcon);
      }
   }
}

