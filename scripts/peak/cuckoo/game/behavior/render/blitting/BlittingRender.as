package peak.cuckoo.game.behavior.render.blitting
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.Layer;
   import peak.cuckoo.game.attribute.view.BaseView;
   import peak.cuckoo.game.attribute.view.CompositeView;
   import peak.cuckoo.game.behavior.animation.bitmap.BitmapActionAnimation;
   import peak.cuckoo.game.behavior.animation.bitmap.BitmapLoopAnimation;
   import peak.cuckoo.game.behavior.animation.bitmap.BitmapStateDirectionAnimation;
   import peak.cuckoo.game.behavior.render.*;
   
   public class BlittingRender extends BaseRender
   {
      
      public static var STATIC_COMPOSITE_CANVAS_SIZE_WIDTH:int = 500;
      
      public static var STATIC_COMPOSITE_CANVAS_SIZE_HEIGHT:int = 500;
      
      protected var renderingCanvas:Bitmap;
      
      protected var renderingBitmapData:BitmapData;
      
      protected const COMPOSITE_CANVAS_PADDING_OVERALL:int = 10;
      
      protected const COMPOSITE_CANVAS_PADDING_OVERALL_TWICE:int = 20;
      
      private var compositeCanvasSizeHeight:int;
      
      protected var compositeCanvas:BitmapData;
      
      protected var whiteOutlineFilter:GlowFilter = new GlowFilter(16777215,1,5,5,5);
      
      protected var alphaFilter:ColorTransform = new ColorTransform(1,1,1,0.5);
      
      protected var whiteFilter:ColorTransform = new ColorTransform(2,2,2,0.8);
      
      protected var blackOutlineFilter:GlowFilter = new GlowFilter(0,1,5,5,5);
      
      protected var purpleOutlineFilter:GlowFilter = new GlowFilter(10118108,1,5,5,5);
      
      protected var lightBlueOutlineFilter:GlowFilter = new GlowFilter(1744624,1,5,5,5);
      
      protected var lightBlueFilter:ColorTransform = new ColorTransform(0.811,1.3,1.3,1);
      
      protected const tempPoint:Point = new Point();
      
      protected const tempRect:Rectangle = new Rectangle();
      
      protected var target:String;
      
      public function BlittingRender(param1:String)
      {
         super();
         this.target = param1;
         compositeCanvasSizeHeight = STATIC_COMPOSITE_CANVAS_SIZE_HEIGHT;
         compositeCanvas = new BitmapData(STATIC_COMPOSITE_CANVAS_SIZE_WIDTH,compositeCanvasSizeHeight,true,0);
         renderSpecificLoopAnimation = BitmapLoopAnimation;
         renderSpecificActionAnimation = BitmapActionAnimation;
         renderSpecificDirectionStateAnimation = BitmapStateDirectionAnimation;
         renderingCanvas = new Bitmap();
         _canvas.addChild(renderingCanvas);
      }
      
      override public function invalidateZoom() : void
      {
         super.invalidateZoom();
         this.invalidated |= 1;
         this.arrangeCanvasAndViewport();
         this.invalidated = 0;
      }
      
      override public function arrangeCanvasAndViewport() : void
      {
         var _loc1_:Boolean = false;
         super.arrangeCanvasAndViewport();
         if(viewport.rect.width == 0 || viewport.rect.height == 0)
         {
            return;
         }
         if(invalidated & (1 | 4))
         {
            _loc1_ = false;
            try
            {
               if(!renderingBitmapData || renderingBitmapData.width < viewport.rect.width || renderingBitmapData.height < viewport.rect.height)
               {
                  _loc1_ = true;
               }
            }
            catch(e:Error)
            {
               if(e.errorID == 2015)
               {
                  _loc1_ = true;
               }
               renderingBitmapData = null;
            }
            if(_loc1_)
            {
               try
               {
                  renderingCanvas.bitmapData = renderingBitmapData = CanvasBitmapDataProvider.getBitmapData(target,viewport.rect.width + 1,viewport.rect.height + 1);
               }
               catch(e:Error)
               {
                  throw new Error("Unable to create new BitmapData");
               }
               renderingCanvas.pixelSnapping = "always";
               renderingCanvas.smoothing = true;
            }
         }
      }
      
      override protected function beginScene() : Boolean
      {
         return renderingBitmapData != null && viewport.rect.width > 0 && viewport.rect.height > 0;
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
         var _loc4_:* = null;
         var _loc2_:Number = NaN;
         var _loc5_:Number = NaN;
         for each(var _loc3_ in param1.renderChildrenContainer.renderChildren)
         {
            if(_loc3_.composite)
            {
               if(_loc3_.composite.filter)
               {
                  _loc2_ = compositeCanvasSizeHeight - _loc3_.bounds.bottom - 10;
                  _loc5_ = _loc3_.bounds.point.x - 10;
                  for each(_loc4_ in (_loc3_.composite.view as CompositeView).children)
                  {
                     if(_loc4_.view._bitmapData)
                     {
                        tempPoint.x = _loc4_.bounds.point.x - _loc5_;
                        tempPoint.y = _loc2_ + _loc4_.bounds.point.y;
                        compositeCanvas.copyPixels(_loc4_.view._bitmapData,_loc4_.view.bitmapDataRect,tempPoint,null,null,true);
                     }
                  }
                  tempRect.x = 0;
                  tempRect.y = compositeCanvasSizeHeight - _loc3_.bounds.height - 20;
                  tempRect.width = _loc3_.bounds.width + 20;
                  tempRect.height = _loc3_.bounds.height + 20;
                  tempPoint.x = 0;
                  tempPoint.y = tempRect.y;
                  switch(_loc3_.composite.filter - 1)
                  {
                     case 0:
                        compositeCanvas.applyFilter(compositeCanvas,tempRect,tempPoint,whiteOutlineFilter);
                        break;
                     case 1:
                        compositeCanvas.colorTransform(compositeCanvas.rect,alphaFilter);
                        break;
                     case 2:
                        compositeCanvas.colorTransform(compositeCanvas.rect,whiteFilter);
                        break;
                     case 3:
                        compositeCanvas.applyFilter(compositeCanvas,tempRect,tempPoint,blackOutlineFilter);
                        break;
                     case 4:
                        compositeCanvas.applyFilter(compositeCanvas,tempRect,tempPoint,lightBlueOutlineFilter);
                        break;
                     case 5:
                        compositeCanvas.applyFilter(compositeCanvas,tempRect,tempPoint,purpleOutlineFilter);
                        break;
                     case 6:
                        compositeCanvas.colorTransform(compositeCanvas.rect,lightBlueFilter);
                  }
                  tempPoint.x = _loc3_.composite.bounds.point.x - 10;
                  tempPoint.y = _loc3_.composite.bounds.point.y - 10;
                  renderingBitmapData.copyPixels(compositeCanvas,tempRect,tempPoint);
                  compositeCanvas.fillRect(compositeCanvas.rect,0);
               }
               else
               {
                  for each(_loc4_ in (_loc3_.composite.view as CompositeView).children)
                  {
                     if(_loc4_.view._bitmapData)
                     {
                        renderingBitmapData.copyPixels(_loc4_.view._bitmapData,_loc4_.view.bitmapDataRect,_loc4_.bounds.point);
                     }
                  }
               }
            }
            else if(_loc3_.view._bitmapData)
            {
               if(_loc3_.filter)
               {
                  tempPoint.x = tempPoint.y = 10;
                  tempRect.x = tempRect.y = 0;
                  tempRect.width = _loc3_.bounds.width;
                  tempRect.height = _loc3_.bounds.height;
                  compositeCanvas.copyPixels(_loc3_.view._bitmapData,tempRect,tempPoint,null,null,true);
                  tempRect.width += 20;
                  tempRect.height += 20;
                  tempPoint.x = tempPoint.y = 0;
                  switch(_loc3_.filter - 1)
                  {
                     case 0:
                        compositeCanvas.applyFilter(compositeCanvas,tempRect,tempPoint,whiteOutlineFilter);
                        break;
                     case 1:
                        compositeCanvas.colorTransform(compositeCanvas.rect,alphaFilter);
                        break;
                     case 2:
                        compositeCanvas.colorTransform(compositeCanvas.rect,whiteFilter);
                        break;
                     case 3:
                        compositeCanvas.applyFilter(compositeCanvas,tempRect,tempPoint,blackOutlineFilter);
                        break;
                     case 4:
                        compositeCanvas.applyFilter(compositeCanvas,tempRect,tempPoint,lightBlueOutlineFilter);
                        break;
                     case 5:
                        compositeCanvas.applyFilter(compositeCanvas,tempRect,tempPoint,purpleOutlineFilter);
                        break;
                     case 6:
                        compositeCanvas.colorTransform(compositeCanvas.rect,lightBlueFilter);
                  }
                  tempPoint.x = _loc3_.bounds.point.x - 10;
                  tempPoint.y = _loc3_.bounds.point.y - 10;
                  renderingBitmapData.copyPixels(compositeCanvas,tempRect,tempPoint);
                  compositeCanvas.fillRect(tempRect,0);
               }
               else
               {
                  renderingBitmapData.copyPixels(_loc3_.view._bitmapData,_loc3_.view.bitmapDataRect,_loc3_.bounds.point);
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
            if(_loc2_.view._bitmapData)
            {
               renderingBitmapData.copyPixels(_loc2_.view._bitmapData,_loc2_.view.bitmapDataRect,_loc2_.bounds.point);
            }
         }
      }
      
      override public function prepareView(param1:BaseView) : void
      {
      }
      
      override public function updateView(param1:BaseView) : void
      {
      }
   }
}

import flash.display.BitmapData;

class CanvasBitmapDataProvider
{
   
   private static var cache:Object = {};
   
   public function CanvasBitmapDataProvider()
   {
      super();
   }
   
   public static function getBitmapData(param1:String, param2:int, param3:int) : BitmapData
   {
      var _loc4_:BitmapData = null;
      if(!(param1 in cache))
      {
         cache[param1] = _loc4_ = new BitmapData(param2,param3,false,0);
      }
      else
      {
         _loc4_ = cache[param1] as BitmapData;
         if(_loc4_.width < param2 || _loc4_.height < param3)
         {
            _loc4_.dispose();
            cache[param1] = _loc4_ = new BitmapData(param2,param3,false,0);
         }
      }
      return _loc4_;
   }
}
