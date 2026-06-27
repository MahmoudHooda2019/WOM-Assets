package wom.view.util
{
   import feathers.controls.Label;
   import peak.component.mobile.MPRigidButton;
   import peak.starling.FlatteningSprite;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.game.window.WindowEnumeration;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.MobileWindowHeaderTextField;
   
   public class MobileGenericWindow extends Sprite
   {
      
      protected static const MARGIN:Number = 5;
      
      public static const WINDOW_WIDTH:Number = 750;
      
      public static const WINDOW_HEIGHT:Number = 525;
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      protected var _staticLayer:FlatteningSprite;
      
      protected var _background:DisplayObject;
      
      protected var _windowHeader:Label;
      
      protected var _closeButton:MPRigidButton;
      
      protected var _windowWidth:int;
      
      protected var _windowHeight:int;
      
      protected var _closeButtonEnabled:Boolean;
      
      protected var _windowEnumerations:Vector.<WindowEnumeration>;
      
      private var _stackable:Boolean;
      
      public function MobileGenericWindow(param1:int = 750, param2:int = 525, param3:Vector.<WindowEnumeration> = null, param4:Object = null, param5:Object = null)
      {
         super();
         _windowWidth = param1;
         _windowHeight = param2;
         _windowEnumerations = param3;
         _closeButtonEnabled = param4 != null ? Boolean(param4) : true;
         _stackable = param5 != null ? Boolean(param5) : true;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
         _staticLayer.setChildIndex(_windowHeader,_staticLayer.numChildren - 1);
         if(_closeButton && contains(_closeButton))
         {
            setChildIndex(_closeButton,numChildren - 1);
         }
         _staticLayer.flatten();
      }
      
      protected function initLayout() : void
      {
         _staticLayer = new FlatteningSprite();
         addChild(_staticLayer);
         drawBackground();
         createAndAddWindowHeader();
         createAndAddCloseButton();
         alignHeader();
      }
      
      protected function createAndAddCloseButton() : void
      {
         _closeButton = new MPRigidButton("ButtonClose","ButtonCloseHover");
         _closeButton.setPaddings(10,10,10,10);
         if(_closeButtonEnabled)
         {
            addChild(_closeButton);
            closeButton.validate();
         }
      }
      
      protected function createAndAddWindowHeader() : void
      {
         _windowHeader = new MobileWindowHeaderTextField();
         _windowHeader.x = _windowWidth - _windowHeader.width >> 1;
         _staticLayer.addChild(_windowHeader);
      }
      
      protected function alignHeader() : void
      {
         _windowHeader.x = _windowWidth / 2 - _windowHeader.width / 2;
         _windowHeader.y = -10;
         _closeButton.x = _windowWidth - _closeButton.width + 12;
         _closeButton.y = -7;
      }
      
      protected function drawBackground() : void
      {
         if(_background == null)
         {
            _background = assetRepository.getDisplayObject("MobileWindowBackground");
         }
         _background.width = _windowWidth;
         _background.height = _windowHeight;
         if(!_staticLayer.contains(_background))
         {
            _staticLayer.addChildAt(_background,0);
         }
      }
      
      public function get closeButton() : MPRigidButton
      {
         return _closeButton;
      }
      
      public function setHeader(param1:String) : void
      {
         _windowHeader.text = param1;
         _windowHeader.x = _windowWidth / 2 - _windowHeader.width / 2;
         _windowHeader.y = (-(_windowHeader.height / 2) >> 0) + 5;
      }
      
      override public function get height() : Number
      {
         return _windowHeight;
      }
      
      public function get windowWidth() : int
      {
         return _windowWidth;
      }
      
      public function get windowHeight() : int
      {
         return _windowHeight;
      }
      
      public function set windowHeight(param1:int) : void
      {
         _windowHeight = param1;
      }
      
      public function get windowEnumerations() : Vector.<WindowEnumeration>
      {
         return _windowEnumerations;
      }
      
      public function addWindowEnumeration(param1:WindowEnumeration) : void
      {
         if(_windowEnumerations == null)
         {
            _windowEnumerations = new Vector.<WindowEnumeration>();
         }
         _windowEnumerations.push(param1);
      }
      
      public function get stackable() : Boolean
      {
         return _stackable;
      }
      
      public function flattenStaticLayer() : void
      {
         _staticLayer.flatten();
      }
      
      public function unflattenStaticLayer() : void
      {
         _staticLayer.unflatten();
      }
   }
}

