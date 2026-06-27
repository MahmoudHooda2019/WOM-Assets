package wom.view.ui.common
{
   import peak.component.mobile.MPButton;
   import peak.component.mobile.MPTextField;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   
   public class MobileInboxMenuButtonView extends Sprite implements View
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _button:MPButton;
      
      private var _counterBackground:DisplayObject;
      
      private var _counterTextField:MPTextField;
      
      public function MobileInboxMenuButtonView()
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
         _button = MobileWomUIComponentFactory.createMenuButton("Red","Medium","IconInboxMBordered",13,-4);
         _button.width = 92;
         var _temp_2:* = _button;
         var _loc1_:String = "ui.mainframe.city.menupanel.inbox";
         _temp_2.label = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         addChild(_button);
         _counterBackground = assetRepository.getDisplayObject("BackgroundBubble");
         _counterBackground.touchable = false;
         _counterBackground.visible = false;
         addChild(_counterBackground);
         _counterTextField = new MobileWomTextField();
         _counterTextField.touchable = false;
         _counterTextField.textRendererProperties.textFormat = getCaptionTextFormat(23,"center",16777215);
         _counterTextField.width = 32;
         _counterTextField.visible = false;
         addChild(_counterTextField);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(_counterBackground,_button,61,-7);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_counterTextField,_counterBackground,8);
         _counterTextField.x -= 2;
      }
      
      public function get button() : MPButton
      {
         return _button;
      }
      
      public function updateCounter(param1:int) : void
      {
         _counterTextField.text = String(param1);
         _counterBackground.visible = _counterTextField.visible = param1 > 0;
      }
   }
}

