package wom.view.screen.windows.alliance.coa.mobile
{
   import peak.component.mobile.MPButton;
   import starling.display.DisplayObject;
   import starling.display.Shape;
   import starling.display.Sprite;
   import starling.events.Event;
   import wom.model.game.alliance.coa.VanityColorType;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   
   public class MobileVanityColorSelectorView extends Sprite
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var colorArea:Shape;
      
      private var colorPaletteView:MobileVanityColorPaletteView;
      
      private var _paletteButton:MPButton;
      
      private var _selectedColorType:VanityColorType;
      
      private var _selectorId:int;
      
      public function MobileVanityColorSelectorView(param1:int)
      {
         super();
         _selectorId = param1;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      private function initLayout() : void
      {
         _selectedColorType = VanityColorType.DEFAULT;
         _paletteButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Medium");
         _paletteButton.width = 111;
         _paletteButton.isToggle = true;
         _paletteButton.isSelected = false;
         var _loc1_:DisplayObject = assetRepository.getDisplayObject("SymbolPalette");
         _paletteButton.defaultIcon = _loc1_;
         _paletteButton.iconOffsetX = 24;
         _paletteButton.iconOffsetY = -2;
         addChild(_paletteButton);
         colorArea = new Shape();
         colorArea.x = 14;
         colorArea.y = 12;
         _paletteButton.addChild(colorArea);
         fillColorArea(_selectedColorType);
         colorPaletteView = new MobileVanityColorPaletteView(_selectorId);
         colorPaletteView.visible = false;
         colorPaletteView.y = -312;
         addChild(colorPaletteView);
         colorPaletteView.selectColor(_selectedColorType);
      }
      
      private function fillColorArea(param1:VanityColorType) : void
      {
         colorArea.graphics.clear();
         colorArea.graphics.lineStyle(0,param1.color,1);
         colorArea.graphics.beginFill(param1.color);
         colorArea.graphics.drawRoundRect(0,0,40,30,2);
         colorArea.graphics.endFill();
      }
      
      public function selectColor(param1:VanityColorType, param2:Boolean = false) : void
      {
         if(_selectedColorType != param1)
         {
            _selectedColorType = param1;
            fillColorArea(_selectedColorType);
            if(!param2)
            {
               colorPaletteView.selectColor(_selectedColorType);
            }
         }
         _paletteButton.isSelected = false;
         onPaletteButtonToggle();
         dispatchEvent(new Event("change"));
      }
      
      public function onPaletteButtonToggle() : void
      {
         colorPaletteView.visible = _paletteButton.isSelected;
      }
      
      public function closePalette() : void
      {
         colorPaletteView.visible = _paletteButton.isSelected = false;
      }
      
      public function get selectedColorType() : VanityColorType
      {
         return _selectedColorType;
      }
      
      public function get selectorId() : int
      {
         return _selectorId;
      }
      
      public function get paletteButton() : MPButton
      {
         return _paletteButton;
      }
   }
}

