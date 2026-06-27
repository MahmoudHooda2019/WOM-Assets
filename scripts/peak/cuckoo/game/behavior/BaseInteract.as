package peak.cuckoo.game.behavior
{
   import flash.display.Stage;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import peak.cuckoo.core.Behavior;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.Layer;
   import peak.cuckoo.game.attribute.view.CompositeView;
   import peak.cuckoo.game.behavior.render.BaseRender;
   import peak.signal.Signal0;
   import peak.signal.Slot0;
   import wom.Environment;
   
   public class BaseInteract extends Behavior
   {
      
      public static const TYPE_ID:String = "BaseInteract";
      
      protected var render:BaseRender;
      
      protected var stage:Stage;
      
      protected var _grabbedMousePoint:Point;
      
      public var grabbedCanvasPoint:Point;
      
      public var moveDiff:Point;
      
      protected var _dragEnabled:Boolean = true;
      
      public var dragging:Boolean;
      
      public var underDragThreshold:Boolean;
      
      public var down:Boolean;
      
      public var projectedPosition:Point;
      
      protected var renderPosition:Point;
      
      protected var rect:Rectangle;
      
      public var selectionOutlineStyle:uint = 1;
      
      public var pickedEntity:GameSprite;
      
      public var click:Signal0;
      
      public var moveDrag:Signal0;
      
      public var move:Signal0;
      
      public var dragStarted:Signal0;
      
      public var pickedEntityChanged:Signal0;
      
      public var ctrlClick:Signal0;
      
      public var mouseDown:Signal0;
      
      public var mouseUp:Signal0;
      
      public function BaseInteract()
      {
         super();
      }
      
      protected function hitTest() : void
      {
         var _loc7_:int = 0;
         var _loc4_:Layer = null;
         var _loc5_:* = undefined;
         var _loc6_:int = 0;
         var _loc1_:GameSprite = null;
         var _loc2_:GameSprite = null;
         var _loc3_:Array = owner.root.layers;
         _loc7_ = 3;
         loop0:
         while(_loc7_ >= 2)
         {
            _loc4_ = _loc3_[_loc7_] as Layer;
            _loc5_ = _loc4_.renderChildrenContainer.renderChildren;
            _loc6_ = _loc5_.length - 1;
            while(_loc6_ >= 0)
            {
               _loc1_ = _loc5_[_loc6_];
               if(_loc1_.composite && _loc1_.interactive)
               {
                  if(renderPosition.x > _loc1_.bounds.point.x && renderPosition.y > _loc1_.bounds.point.y && renderPosition.x < _loc1_.bounds.right && renderPosition.y < _loc1_.bounds.bottom)
                  {
                     if(hitTestCompositeGameSprite(_loc1_.composite,_loc4_.type))
                     {
                        _loc2_ = _loc1_.composite;
                     }
                  }
               }
               if(_loc1_.interactive)
               {
                  if(renderPosition.x > _loc1_.bounds.point.x && renderPosition.y > _loc1_.bounds.point.y && renderPosition.x < _loc1_.bounds.right && renderPosition.y < _loc1_.bounds.bottom)
                  {
                     if(hitTestGameSprite(_loc1_))
                     {
                        _loc2_ = _loc1_;
                     }
                  }
               }
               if(_loc2_)
               {
                  break loop0;
               }
               _loc6_--;
            }
            _loc7_--;
         }
         setPickedEntity(_loc2_);
      }
      
      protected function hitTestGameSprite(param1:GameSprite) : Boolean
      {
         return (uint(param1.view._bitmapData.getPixel32(renderPosition.x - param1.bounds.point.x,renderPosition.y - param1.bounds.point.y) & 0xFF000000)) > 0;
      }
      
      protected function hitTestCompositeGameSprite(param1:GameSprite, param2:int) : Boolean
      {
         var _loc5_:int = 0;
         var _loc3_:GameSprite = null;
         var _loc4_:Vector.<GameSprite> = (param1.view as CompositeView).children;
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc3_ = _loc4_[_loc5_];
            if(_loc3_.view._bitmapData)
            {
               if((uint(_loc3_.view._bitmapData.getPixel32(renderPosition.x - _loc3_.bounds.point.x,renderPosition.y - _loc3_.bounds.point.y) & 0xFF000000)) > 2147483648)
               {
                  return true;
               }
            }
            _loc5_++;
         }
         return false;
      }
      
      override public function get typeId() : String
      {
         return "BaseInteract";
      }
      
      override public function init() : void
      {
         super.init();
         stage = Environment.stage;
         rect = owner.root.viewport.rect;
      }
      
      override public function update() : void
      {
      }
      
      protected function setPickedEntity(param1:GameSprite) : void
      {
         if(pickedEntity != param1)
         {
            pickedEntity = param1;
            pickedEntityChanged.dispatch();
         }
      }
      
      override protected function stop() : void
      {
         super.stop();
      }
      
      override protected function start() : void
      {
         super.start();
      }
      
      public function addMouseMoveHandler(param1:Slot0) : void
      {
      }
      
      public function removeMouseMoveHandler(param1:Slot0) : void
      {
      }
      
      public function dragEnabled() : void
      {
      }
      
      public function dragDisabled() : void
      {
      }
      
      override public function terminate() : void
      {
      }
      
      override public function destroy() : void
      {
         disable();
      }
   }
}

