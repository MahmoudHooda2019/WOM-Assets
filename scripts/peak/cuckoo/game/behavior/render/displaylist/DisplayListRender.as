package peak.cuckoo.game.behavior.render.displaylist
{
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.Layer;
   import peak.cuckoo.game.attribute.view.BaseView;
   import peak.cuckoo.game.attribute.view.CompositeView;
   import peak.cuckoo.game.behavior.animation.bitmap.BitmapActionAnimation;
   import peak.cuckoo.game.behavior.animation.bitmap.BitmapLoopAnimation;
   import peak.cuckoo.game.behavior.animation.bitmap.BitmapStateDirectionAnimation;
   import peak.cuckoo.game.behavior.render.*;
   
   public class DisplayListRender extends BaseRender
   {
      
      private var renderingCanvas:Sprite;
      
      public var glowFilter:GlowFilter = new GlowFilter(16777215,1,5,5,5);
      
      protected var blackOutlineFilter:GlowFilter = new GlowFilter(0,1,5,5,5);
      
      protected var lightBlueOutlineFilter:GlowFilter = new GlowFilter(1744624,1,5,5,5);
      
      protected var whiteFilter:ColorTransform = new ColorTransform(2,2,2,0.8);
      
      public function DisplayListRender()
      {
         super();
         renderSpecificLoopAnimation = BitmapLoopAnimation;
         renderSpecificActionAnimation = BitmapActionAnimation;
         renderSpecificDirectionStateAnimation = BitmapStateDirectionAnimation;
         renderingCanvas = new Sprite();
         _canvas.addChild(renderingCanvas);
      }
      
      override protected function beginScene() : Boolean
      {
         renderingCanvas.removeChildren();
         return true;
      }
      
      override protected function renderScene() : void
      {
         renderLayer(owner.root.layers[0]);
         renderLayer(owner.root.layers[1]);
         renderLayer(owner.root.layers[2]);
         renderMainLayer(owner.root.layers[3]);
         renderLayer(owner.root.layers[4]);
      }
      
      private function renderMainLayer(param1:Layer) : void
      {
         var _loc7_:CompositeView = null;
         var _loc6_:* = null;
         var _loc5_:DisplayObject = null;
         var _loc2_:Sprite = null;
         var _loc4_:Sprite = null;
         for each(var _loc3_ in param1.renderChildrenContainer.renderChildren)
         {
            if(_loc3_.composite)
            {
               _loc7_ = _loc3_.composite.view as CompositeView;
               if(_loc3_.composite.filter)
               {
                  _loc2_ = _loc7_.sprite;
                  _loc2_.alpha = 1;
                  _loc2_.filters = [];
                  _loc2_.removeChildren();
                  for each(_loc6_ in _loc7_.children)
                  {
                     _loc5_ = _loc6_.view.bitmap;
                     _loc5_.x = _loc6_.bounds.point.x - _loc3_.bounds.point.x;
                     _loc5_.y = _loc6_.bounds.point.y - _loc3_.bounds.point.y;
                     _loc2_.addChild(_loc5_);
                  }
                  _loc2_.x = _loc3_.bounds.point.x;
                  _loc2_.y = _loc3_.bounds.point.y;
                  switch(_loc3_.filter - 1)
                  {
                     case 0:
                        _loc2_.filters = [glowFilter];
                        break;
                     case 1:
                        _loc2_.alpha = 0.5;
                        break;
                     case 2:
                        _loc2_.transform.colorTransform = whiteFilter;
                        break;
                     case 3:
                        _loc2_.filters[blackOutlineFilter];
                        break;
                     case 4:
                        _loc2_.filters[lightBlueOutlineFilter];
                  }
                  renderingCanvas.addChild(_loc2_);
               }
               else
               {
                  for each(_loc6_ in _loc7_.children)
                  {
                     _loc5_ = _loc6_.view.bitmap;
                     if(_loc5_.visible)
                     {
                        _loc5_.x = _loc6_.bounds.point.x;
                        _loc5_.y = _loc6_.bounds.point.y;
                        renderingCanvas.addChild(_loc5_);
                     }
                  }
               }
            }
            else
            {
               _loc3_.view.bitmap.x = _loc3_.bounds.point.x;
               _loc3_.view.bitmap.y = _loc3_.bounds.point.y;
               if(_loc3_.filter)
               {
                  _loc4_ = new Sprite();
                  _loc4_.addChild(_loc3_.view.bitmap);
                  switch(_loc3_.filter - 1)
                  {
                     case 0:
                        _loc4_.filters = [glowFilter];
                        break;
                     case 1:
                        _loc4_.alpha = 0.5;
                        break;
                     case 2:
                        _loc4_.transform.colorTransform = whiteFilter;
                        break;
                     case 3:
                        _loc4_.filters[blackOutlineFilter];
                        break;
                     case 4:
                        _loc4_.filters[lightBlueOutlineFilter];
                  }
                  renderingCanvas.addChild(_loc4_);
               }
               else
               {
                  renderingCanvas.addChild(_loc3_.view.bitmap);
               }
            }
         }
      }
      
      private function renderLayer(param1:Layer) : void
      {
         if(!param1)
         {
            return;
         }
         for each(var _loc2_ in param1.renderChildrenContainer.renderChildren)
         {
            _loc2_.view.bitmap.x = _loc2_.bounds.point.x;
            _loc2_.view.bitmap.y = _loc2_.bounds.point.y;
            renderingCanvas.addChild(_loc2_.view.bitmap);
         }
      }
      
      override public function prepareView(param1:BaseView) : void
      {
         param1.bitmap = new Bitmap(param1._bitmapData);
      }
      
      override public function updateView(param1:BaseView) : void
      {
         param1.bitmap.bitmapData = param1._bitmapData;
      }
   }
}

