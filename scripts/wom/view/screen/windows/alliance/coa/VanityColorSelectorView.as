package wom.view.screen.windows.alliance.coa
{
   import flash.display.Sprite;
   import flash.events.Event;
   import wom.model.game.alliance.coa.VanityColorType;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.button.WomButton;
   import wom.view.component.button.colored.WomBlueMediumButton;
   
   public class VanityColorSelectorView extends Sprite
   {
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      private var colorArea:Sprite;
      
      private var colorPaletteView:VanityColorPaletteView;
      
      private var _paletteButton:WomButton;
      
      private var _selectedColorType:VanityColorType;
      
      private var _selectorId:int;
      
      public function VanityColorSelectorView(param1:int)
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
         colorArea = new Sprite();
         addChild(colorArea);
         fillColorArea(_selectedColorType);
         _paletteButton = new WomBlueMediumButton();
         _paletteButton.width = 40;
         _paletteButton.toggle = true;
         _paletteButton.selected = false;
         _paletteButton.setStyle("icon",assetRepository.getDisplayObject("IconRefresh"));
         _paletteButton.x = 40;
         addChild(_paletteButton);
         colorPaletteView = new VanityColorPaletteView(_selectorId);
         colorPaletteView.visible = false;
         colorPaletteView.x = 40;
         colorPaletteView.y = -116;
         addChild(colorPaletteView);
         colorPaletteView.selectColor(_selectedColorType);
      }
      
      private function fillColorArea(param1:VanityColorType) : void
      {
         colorArea.graphics.clear();
         colorArea.graphics.lineStyle(1,6710886,1,true);
         colorArea.graphics.beginFill(param1.color);
         colorArea.graphics.drawRoundRect(0,0,80,38,10);
         colorArea.graphics.endFill();
      }
      
      public function selectColor(param1:VanityColorType) : void
      {
         if(_selectedColorType != param1)
         {
            _selectedColorType = param1;
            fillColorArea(_selectedColorType);
            colorPaletteView.selectColor(_selectedColorType);
         }
         _paletteButton.selected = false;
         onPaletteButtonToggle();
         dispatchEvent(new Event("change"));
      }
      
      public function onPaletteButtonToggle() : void
      {
         colorPaletteView.visible = _paletteButton.selected;
      }
      
      public function closePalette() : void
      {
         colorPaletteView.visible = _paletteButton.selected = false;
      }
      
      public function get selectedColorType() : VanityColorType
      {
         return _selectedColorType;
      }
      
      public function get selectorId() : int
      {
         return _selectorId;
      }
      
      public function get paletteButton() : WomButton
      {
         return _paletteButton;
      }
   }
}

