package wom.view.util
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import wom.model.game.window.WindowEnumeration;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.WindowHeaderTextField;
   import wom.view.component.button.rigid.CloseButton;
   
   public class GenericWindow extends Sprite
   {
      
      protected static const MARGIN:Number = 5;
      
      public static const WINDOW_WIDTH:Number = 750;
      
      public static const WINDOW_HEIGHT:Number = 525;
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      protected var contentReferencePoint:Sprite;
      
      protected var _background:DisplayObject;
      
      protected var _windowHeader:TextField;
      
      protected var _closeButton:CloseButton;
      
      protected var _windowWidth:int;
      
      protected var _windowHeight:int;
      
      protected var _closeButtonEnabled:Boolean;
      
      private var _windowEnumerations:Vector.<WindowEnumeration>;
      
      private var _stackable:Boolean;
      
      public function GenericWindow(param1:int = 750, param2:int = 525, param3:Vector.<WindowEnumeration> = null, param4:Object = null, param5:Object = null)
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
         contentReferencePoint = new Sprite();
         _windowHeader = new WindowHeaderTextField();
         _windowHeader.mouseEnabled = false;
         _windowHeader.x = _windowWidth / 2 - _windowHeader.width / 2;
         _windowHeader.width = _windowWidth - 60;
         _closeButton = new CloseButton();
         addChild(contentReferencePoint);
         addChild(_windowHeader);
         if(_closeButtonEnabled)
         {
            addChild(_closeButton);
         }
         contentReferencePoint.x = 5 * 5;
         contentReferencePoint.y = 84;
         alignHeader();
      }
      
      protected function alignHeader() : void
      {
         _windowHeader.x = _windowWidth / 2 - _windowHeader.width / 2;
         _windowHeader.y = -20;
         _closeButton.x = _windowWidth - _closeButton.width;
         _closeButton.y = 0;
      }
      
      protected function drawBackground() : void
      {
         if(_background == null)
         {
            _background = assetRepository.getDisplayObject("MainFrameBackground");
         }
         _background.width = _windowWidth;
         _background.height = _windowHeight;
         if(!contains(_background))
         {
            addChildAt(_background,0);
         }
      }
      
      public function get closeButton() : CloseButton
      {
         return _closeButton;
      }
      
      public function setHeader(param1:String, param2:Object = null) : void
      {
         if(param2)
         {
            _windowHeader.width = int(param2);
         }
         _windowHeader.text = param1;
         _windowHeader.x = _windowWidth / 2 - _windowHeader.width / 2;
         _windowHeader.y = -(_windowHeader.textHeight / 2) >> 0;
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
      
      public function canClose() : Boolean
      {
         return true;
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
   }
}

