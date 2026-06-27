package peak.cuckoo.game.behavior.render
{
   import flash.display.BitmapData;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.geom.Rectangle;
   import peak.cuckoo.core.Behavior;
   import peak.cuckoo.game.attribute.Viewport;
   import peak.cuckoo.game.attribute.view.BaseView;
   import peak.cuckoo.game.attribute.view.CuckooOverlay;
   import peak.cuckoo.game.behavior.animation.ActionAnimation;
   import peak.cuckoo.game.behavior.animation.LoopAnimation;
   import peak.cuckoo.game.behavior.animation.StateDirectionAnimation;
   import peak.cuckoo.game.behavior.render.blitting.BlittingRender;
   import peak.cuckoo.game.behavior.render.displaylist.DisplayListRender;
   import peak.cuckoo.game.behavior.render.gpu.GpuRender;
   import peak.cuckoo.game.behavior.render.gpu.GpuStarlingRender;
   import wom.Environment;
   
   public class BaseRender extends Behavior
   {
      
      public static const TYPE_ID:String = "BaseRender";
      
      public static const ALLOW_ZOOM_OUT_OF_BOUNDS:Boolean = false;
      
      public static const DISPLAY_LIST:uint = 1;
      
      public static const BLITTING:uint = 2;
      
      public static const GPU:uint = 3;
      
      public static const GPU_STARLING:uint = 4;
      
      public static const NO_FILTER:uint = 0;
      
      public static const OUTLINE_FILTER:uint = 1;
      
      public static const MOVE_FILTER:uint = 2;
      
      public static const WHITE_FILTER:uint = 3;
      
      public static const BLACK_OUTLINE_FILTER:uint = 4;
      
      public static const LIGHT_BLUE_OUTLINE_FILTER:uint = 5;
      
      public static const PURPLE_OUTLINE:int = 6;
      
      public static const LIGHT_BLUE_FILTER:int = 7;
      
      public static const INVALIDATED_CANVAS_RECT:uint = 1;
      
      public static const INVALIDATED_PAN:uint = 2;
      
      public static const INVALIDATED_ZOOM:uint = 4;
      
      public var RENDER_TYPE:uint;
      
      public var renderSpecificLoopAnimation:Class;
      
      public var renderSpecificActionAnimation:Class;
      
      public var renderSpecificDirectionStateAnimation:Class;
      
      public var invalidated:uint = 7;
      
      public var stage:Stage;
      
      protected var _canvas:Sprite;
      
      protected var _canvasRect:Rectangle;
      
      protected var _effectiveCanvasRect:Rectangle;
      
      protected var _canvasScrollRect:Rectangle;
      
      protected var _clipCanvas:Boolean;
      
      protected var _effectiveClipCanvas:Boolean;
      
      protected var _overlay:CuckooOverlay;
      
      protected var viewport:Viewport;
      
      protected var zoomFocalU:Number;
      
      protected var zoomFocalV:Number;
      
      private var minScale:Number;
      
      private var maxScale:Number;
      
      public function BaseRender()
      {
         super();
         _canvas = new Sprite();
         _overlay = new CuckooOverlay();
         _canvasRect = new Rectangle();
         _effectiveCanvasRect = new Rectangle();
         _canvasScrollRect = new Rectangle();
         _clipCanvas = false;
         renderSpecificLoopAnimation = LoopAnimation;
         renderSpecificActionAnimation = ActionAnimation;
         renderSpecificDirectionStateAnimation = StateDirectionAnimation;
         priority = 2;
         zoomFocalU = zoomFocalV = 0.5;
      }
      
      public static function getRender(param1:uint = 0, param2:String = "game") : BaseRender
      {
         var _loc3_:BaseRender = null;
         if(param1 == 1)
         {
            _loc3_ = new DisplayListRender();
         }
         else if(param1 == 2)
         {
            _loc3_ = new BlittingRender(param2);
         }
         else if(param1 == 3)
         {
            _loc3_ = new GpuRender();
         }
         else if(param1 == 4)
         {
            _loc3_ = new GpuStarlingRender();
         }
         else
         {
            _loc3_ = new DisplayListRender();
         }
         _loc3_.RENDER_TYPE = param1;
         return _loc3_;
      }
      
      override public function get typeId() : String
      {
         return "BaseRender";
      }
      
      override public function init() : void
      {
         super.init();
         stage = Environment.stage;
         viewport = owner.componentManager["Viewport"] as Viewport;
         _canvasScrollRect = new Rectangle();
         var _loc1_:Viewport = viewport;
         if(_loc1_.rect.x < _loc1_.bounds.x || _loc1_.rect.x + _loc1_.rect.width > _loc1_.bounds.x + _loc1_.bounds.width || _loc1_.rect.y < _loc1_.bounds.y || _loc1_.rect.y + _loc1_.rect.height > _loc1_.bounds.y + _loc1_.bounds.height)
         {
            _loc1_.moveTo(_loc1_.rect.x,_loc1_.rect.y);
         }
         undefined;
         if(Environment.hiRes)
         {
            minScale = 1;
            maxScale = 2;
            owner.root.scale = 1.5;
         }
         else
         {
            minScale = 0.5;
            maxScale = 1.5;
         }
      }
      
      override public function update() : void
      {
         if(beginScene())
         {
            renderScene();
            endScene();
            presentScene();
         }
         if(invalidated)
         {
            arrangeCanvasAndViewport();
            invalidated = 0;
         }
      }
      
      protected function beginScene() : Boolean
      {
         return false;
      }
      
      protected function renderScene() : void
      {
      }
      
      protected function endScene() : void
      {
      }
      
      protected function presentScene() : void
      {
      }
      
      public function zoom(param1:Number, param2:Number, param3:Number) : void
      {
         owner.root.scale *= 1 + param3;
         zoomFocalU = param1 / viewport.rect.width;
         zoomFocalV = param2 / viewport.rect.height;
         invalidateZoom();
         arrangeCanvasAndViewport();
      }
      
      public function zoomFocal(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) : void
      {
         var _loc6_:Number = owner.root.scale * param5;
         owner.root.scale = _loc6_ > maxScale ? maxScale : (_loc6_ < minScale ? minScale : _loc6_);
         zoomFocalU = param1;
         zoomFocalV = param2;
         owner.root.viewport.rect.x = param3 - owner.root.viewport.rect.width * param1;
         owner.root.viewport.rect.y = param4 - owner.root.viewport.rect.height * param2;
         invalidateZoom();
      }
      
      public function zoomIn() : void
      {
         zoomFocalU = zoomFocalV = 0.5;
         owner.root.scale *= 2;
         invalidateZoom();
      }
      
      public function zoomOut() : void
      {
         zoomFocalU = zoomFocalV = 0.5;
         owner.root.scale /= 2;
         invalidateZoom();
      }
      
      public function zoomReset() : void
      {
         zoomFocalU = zoomFocalV = 0.5;
         owner.root.scale = 1;
         invalidateZoom();
      }
      
      public function set canvasRect(param1:Rectangle) : void
      {
         _canvasRect.x = param1.x;
         _canvasRect.y = param1.y;
         _canvasRect.width = param1.width;
         _canvasRect.height = param1.height;
         this.invalidated |= 1;
         this.arrangeCanvasAndViewport();
         this.invalidated = 0;
      }
      
      final public function invalidatePan() : void
      {
         invalidated |= 2;
         arrangeCanvasAndViewport();
         invalidated = 0;
      }
      
      public function invalidateZoom() : void
      {
         invalidated |= 4;
         arrangeCanvasAndViewport();
         invalidated = 0;
      }
      
      final public function invalidateCanvasRect() : void
      {
         invalidated |= 1;
         arrangeCanvasAndViewport();
         invalidated = 0;
      }
      
      public function arrangeCanvasAndViewport() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         if(invalidated & (1 | 4))
         {
            _effectiveClipCanvas = _clipCanvas;
            _effectiveCanvasRect.x = _canvasRect.x;
            _effectiveCanvasRect.y = _canvasRect.y;
            _effectiveCanvasRect.width = _canvasRect.width;
            _effectiveCanvasRect.height = _canvasRect.height;
            if(_canvasRect.width > viewport.bounds.width * owner.root.scale || _canvasRect.height > viewport.bounds.height * owner.root.scale)
            {
               owner.root.scale = Math.max(_canvasRect.width / viewport.bounds.width,_canvasRect.height / viewport.bounds.height);
            }
            _loc1_ = _effectiveCanvasRect.width / owner.root.scale;
            _loc2_ = _effectiveCanvasRect.height / owner.root.scale;
            viewport.rect.x -= (_loc1_ - viewport.rect.width) * zoomFocalU;
            viewport.rect.y -= (_loc2_ - viewport.rect.height) * zoomFocalV;
            viewport.rect.width = _loc1_;
            viewport.rect.height = _loc2_;
            owner.root.validator.allInvalidated = true;
         }
         var _loc3_:Viewport = viewport;
         if(_loc3_.rect.x < _loc3_.bounds.x || _loc3_.rect.x + _loc3_.rect.width > _loc3_.bounds.x + _loc3_.bounds.width || _loc3_.rect.y < _loc3_.bounds.y || _loc3_.rect.y + _loc3_.rect.height > _loc3_.bounds.y + _loc3_.bounds.height)
         {
            _loc3_.moveTo(_loc3_.rect.x,_loc3_.rect.y);
         }
         undefined;
      }
      
      public function set clipCanvas(param1:Boolean) : void
      {
         _clipCanvas = param1;
         this.invalidated |= 1;
         this.arrangeCanvasAndViewport();
         this.invalidated = 0;
      }
      
      public function get canvas() : InteractiveObject
      {
         return _canvas;
      }
      
      public function get overlay() : InteractiveObject
      {
         return _overlay;
      }
      
      override protected function stop() : void
      {
         super.stop();
         stage = null;
      }
      
      override public function destroy() : void
      {
         disable();
      }
      
      public function prepareView(param1:BaseView) : void
      {
         param1.bitmapData = new BitmapData(1,1);
      }
      
      public function updateView(param1:BaseView) : void
      {
      }
   }
}

