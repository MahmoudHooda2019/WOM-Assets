package wom.view.ui.tutorial.mobile
{
   import feathers.display.Scale9Image;
   import feathers.textures.Scale9Textures;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   import starling.display.Quad;
   import wom.model.game.tutorial.TutorialMask;
   
   public class MobileTutorialMaskContainer extends DisplayObjectContainer
   {
      
      public static const NON_SIZED_RECTANGLE:Rectangle = new Rectangle();
      
      private var _visibleWidth:int;
      
      private var _visibleHeight:int;
      
      private var _scale9Image:Scale9Image;
      
      private var _scale9Textures:Scale9Textures;
      
      private var _scale9Grid:Rectangle;
      
      private var _quadTop:Quad;
      
      private var _quadLeft:Quad;
      
      private var _quadRight:Quad;
      
      private var _quadBottom:Quad;
      
      public function MobileTutorialMaskContainer(param1:Scale9Textures)
      {
         super();
         _scale9Textures = param1;
      }
      
      private function initComponents() : void
      {
         var _loc1_:* = 0;
         if(!_scale9Image)
         {
            _scale9Image = new Scale9Image(_scale9Textures);
            addChild(_scale9Image);
            _loc1_ = 0;
            _visibleWidth = Starling.current.stage.stageWidth;
            _visibleHeight = Starling.current.stage.stageHeight;
            _quadTop = new Quad(_visibleWidth,1,_loc1_);
            addChild(_quadTop);
            _quadLeft = new Quad(1,1,_loc1_);
            addChild(_quadLeft);
            _quadRight = new Quad(1,1,_loc1_);
            addChild(_quadRight);
            _quadBottom = new Quad(_visibleWidth,1,_loc1_);
            addChild(_quadBottom);
         }
      }
      
      public function update(param1:TutorialMask, param2:Rectangle = null) : void
      {
         _scale9Grid = param2 != null ? param2 : NON_SIZED_RECTANGLE;
         initComponents();
         _quadTop.scaleY = _scale9Grid.top;
         _quadLeft.y = _scale9Grid.top;
         _quadLeft.scaleX = _scale9Grid.left;
         _quadLeft.scaleY = _scale9Grid.height;
         _quadRight.x = _scale9Grid.right;
         _quadRight.y = _scale9Grid.top;
         _quadRight.scaleX = _visibleWidth - _scale9Grid.right;
         _quadRight.scaleY = _scale9Grid.height;
         _quadBottom.y = _scale9Grid.bottom;
         _quadBottom.scaleY = _visibleHeight - _scale9Grid.bottom;
         _quadTop.alpha = _quadLeft.alpha = _quadRight.alpha = _quadBottom.alpha = param1.alpha;
         _scale9Image.x = _scale9Grid.x;
         _scale9Image.y = _scale9Grid.y;
         _scale9Image.width = _scale9Grid.width;
         _scale9Image.height = _scale9Grid.height;
         _scale9Image.alpha = param1.imageAlpha;
      }
      
      override public function hitTest(param1:Point, param2:Boolean = false) : DisplayObject
      {
         if(param2 && (!visible || !touchable))
         {
            return null;
         }
         if(!getBounds(this).containsPoint(param1))
         {
            return null;
         }
         if(_scale9Grid.containsPoint(param1))
         {
            return null;
         }
         return this;
      }
   }
}

