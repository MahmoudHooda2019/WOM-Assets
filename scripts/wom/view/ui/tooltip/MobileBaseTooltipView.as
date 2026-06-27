package wom.view.ui.tooltip
{
   import peak.display.View;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.getCaptionTextFormat;
   
   public class MobileBaseTooltipView extends Sprite implements View
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _interactable:Boolean;
      
      protected var _bg:DisplayObject;
      
      protected var _viewWidth:int;
      
      protected var _viewHeight:int;
      
      private var _tooltipHeader:MobileCaptionTextField;
      
      public function MobileBaseTooltipView(param1:int, param2:int, param3:Boolean)
      {
         super();
         _viewWidth = param1;
         _viewHeight = param2;
         _interactable = param3;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
         drawLayout();
      }
      
      public function initLayout() : void
      {
         _bg = assetRepository.getDisplayObject("BackgroundTransparentPanel");
         _bg.width = _viewWidth;
         _bg.height = _viewHeight;
         addChild(_bg);
         _tooltipHeader = new MobileCaptionTextField();
         _tooltipHeader.textRendererProperties.textFormat = getCaptionTextFormat(42);
         addChild(_tooltipHeader);
         _tooltipHeader.text = "";
      }
      
      public function drawLayout() : void
      {
         if(_tooltipHeader)
         {
            _tooltipHeader.visible = _tooltipHeader.text != "";
         }
      }
      
      public function get interactable() : Boolean
      {
         return _interactable;
      }
      
      public function setHeader(param1:String) : void
      {
         _tooltipHeader.text = param1;
         _tooltipHeader.x = _viewWidth / 2 - _tooltipHeader.width / 2;
         _tooltipHeader.y = (-(_tooltipHeader.height / 2) >> 0) + 5;
      }
      
      override public function get width() : Number
      {
         return _viewWidth;
      }
      
      override public function get height() : Number
      {
         return _viewHeight;
      }
   }
}

