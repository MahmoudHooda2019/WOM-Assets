package wom.view.util
{
   import peak.component.mobile.MPRigidButton;
   import peak.component.mobile.MPTextField;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.game.window.WindowEnumeration;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   
   public class MobileFooWindow extends Sprite
   {
      
      protected static const MARGIN:Number = 5;
      
      public static const WINDOW_WIDTH:Number = 800;
      
      public static const WINDOW_HEIGHT:Number = 600;
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      protected var _background:DisplayObject;
      
      protected var _windowHeader:MPTextField;
      
      protected var _button:MobileWomButton;
      
      private var _closeButton:MPRigidButton;
      
      protected var _windowWidth:int;
      
      protected var _windowHeight:int;
      
      protected var _closeButtonEnabled:Boolean;
      
      protected var _windowEnumerations:Vector.<WindowEnumeration>;
      
      private var _stackable:Boolean;
      
      public function MobileFooWindow(param1:int = 800, param2:int = 600, param3:Vector.<WindowEnumeration> = null, param4:Object = null, param5:Object = null)
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
         setChildIndex(_windowHeader,numChildren - 1);
      }
      
      protected function initLayout() : void
      {
         drawBackground();
         createAndAddWindowHeader();
         createAndAddCloseButton();
         alignHeader();
         setHeader("Starling Generic Window");
         _closeButton = new MPRigidButton("ButtonClose","ButtonCloseHover");
         _closeButton.x = _windowWidth - (_closeButton.width >> 1);
         _closeButton.y = -_closeButton.width >> 1;
         addChild(_closeButton);
         _button = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Large");
         _button.defaultIcon = assetRepository.getDisplayObject("IconGoldS");
         _button.label = "Left";
         _button.rightLabel = "Right";
         _button.x = 400;
         _button.y = 500;
         _button.width = 500;
         addChild(_button);
      }
      
      protected function createAndAddCloseButton() : void
      {
      }
      
      protected function createAndAddWindowHeader() : void
      {
         _windowHeader = new MobileCaptionTextField();
         _windowHeader.textRendererProperties.textFormat = getCaptionTextFormat(46,"center");
         _windowHeader.x = _windowWidth / 2 - _windowHeader.width / 2;
         _windowHeader.width = _windowWidth - 60;
         _windowHeader.text = "StarlingGenericWindow";
         addChild(_windowHeader);
      }
      
      protected function alignHeader() : void
      {
         _windowHeader.x = _windowWidth / 2 - _windowHeader.width / 2;
         _windowHeader.y = -10;
      }
      
      protected function drawBackground() : void
      {
         if(_background == null)
         {
            _background = assetRepository.getDisplayObject("MobileWindowBackground");
         }
         _background.width = _windowWidth;
         _background.height = _windowHeight;
         if(!contains(_background))
         {
            addChildAt(_background,0);
         }
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
      
      public function get closeButton() : MPRigidButton
      {
         return _closeButton;
      }
   }
}

