package peak.cuckoo.game.behavior
{
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.system.Capabilities;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.attribute.view.CompositeView;
   import peak.signal.Signal0;
   import peak.signal.Slot0;
   import starling.display.DisplayObject;
   import wom.Environment;
   import wom.ane.velocity.events.VelocityEvent;
   
   public class StarlingTouchInteract extends BaseInteract
   {
      
      public static const TYPE_ID:String = "BaseInteract";
      
      private static const DRAG_THRESHOLD:int = Capabilities.screenDPI / 3;
      
      private var zooming:Boolean;
      
      protected var _grabbedZoomPoint:Point = new Point();
      
      protected var starlingStage:DisplayObject;
      
      protected var stagePosition:Point = new Point();
      
      protected var starlingPosition:Point = new Point();
      
      protected var scaleFactor:Number;
      
      protected var onCanvas:Boolean;
      
      private var screenPan:ScreenPan;
      
      public function StarlingTouchInteract()
      {
         super();
         priority = 0;
      }
      
      override public function get typeId() : String
      {
         return "BaseInteract";
      }
      
      override public function enable() : void
      {
         if(owner.root.active)
         {
            super.enable();
         }
      }
      
      override public function init() : void
      {
         super.init();
         render = owner.root.render;
         rect = owner.root.viewport.rect;
         projectedPosition = new Point();
         renderPosition = new Point();
         moveDiff = new Point();
         _grabbedMousePoint = new Point();
         grabbedCanvasPoint = new Point();
         click = new Signal0();
         ctrlClick = new Signal0();
         pickedEntityChanged = new Signal0();
         dragStarted = new Signal0();
         moveDrag = new Signal0();
         move = new Signal0();
         mouseDown = new Signal0();
         mouseUp = new Signal0();
         starlingStage = Environment.starling.stage;
         scaleFactor = Environment.starling.contentScaleFactor;
         screenPan = owner.root.componentManager["ScreenPan"] as ScreenPan;
      }
      
      override protected function start() : void
      {
         super.start();
         stage.addEventListener("mouseDown",onNativeDown,false,0,true);
         stage.addEventListener("mouseMove",onNativeMove,false,0,true);
         stage.addEventListener("mouseUp",onNativeUp,false,0,true);
         stage.addEventListener("panGestureMove",onPanGestureMove,false,0,true);
         stage.addEventListener("panGestureEnd",onPanGestureEnd,false,0,true);
         stage.addEventListener("pinchGestureMove",onPinchGesture,false,0,true);
         stage.addEventListener("pinchGestureEnd",onPinchGestureEnd,false,0,true);
      }
      
      override protected function stop() : void
      {
         super.stop();
         stage.removeEventListener("mouseDown",onNativeDown);
         stage.removeEventListener("mouseMove",onNativeMove);
         stage.removeEventListener("mouseUp",onNativeUp);
         stage.removeEventListener("panGestureMove",onPanGestureMove);
         stage.removeEventListener("panGestureEnd",onPanGestureEnd);
         stage.removeEventListener("pinchGestureMove",onPinchGesture);
         stage.removeEventListener("pinchGestureEnd",onPinchGestureEnd);
      }
      
      override public function terminate() : void
      {
         disable();
         click.removeAll();
         pickedEntityChanged.removeAll();
         dragStarted.removeAll();
         moveDrag.removeAll();
      }
      
      override public function destroy() : void
      {
         disable();
      }
      
      override protected function hitTestGameSprite(param1:GameSprite) : Boolean
      {
         return param1.view.hitTest(renderPosition.x - param1.bounds.point.x,renderPosition.y - param1.bounds.point.y);
      }
      
      override protected function hitTestCompositeGameSprite(param1:GameSprite, param2:int) : Boolean
      {
         var _loc5_:int = 0;
         var _loc3_:GameSprite = null;
         var _loc4_:Vector.<GameSprite> = (param1.view as CompositeView).children;
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc3_ = _loc4_[_loc5_];
            if(_loc3_.view.hitTest(renderPosition.x - _loc3_.bounds.point.x,renderPosition.y - _loc3_.bounds.point.y))
            {
               return true;
            }
            _loc5_++;
         }
         return false;
      }
      
      private function onNativeDown(param1:MouseEvent) : void
      {
         onCanvas = starlingStage.hitTest(starlingPosition,true) == starlingStage;
         if(!onCanvas)
         {
            return;
         }
         screenPan.reset();
         mouseDown.dispatch();
         grab();
      }
      
      private function onNativeMove(param1:MouseEvent) : void
      {
         stagePosition.x = param1.stageX;
         stagePosition.y = param1.stageY;
         starlingPosition.x = stagePosition.x / scaleFactor;
         starlingPosition.y = stagePosition.y / scaleFactor;
         renderPosition.x = stagePosition.x / owner.root.scale;
         renderPosition.y = stagePosition.y / owner.root.scale;
         projectedPosition.x = renderPosition.x + rect.x;
         projectedPosition.y = renderPosition.y + rect.y;
         if(down && !dragging && !zooming)
         {
            startDrag();
         }
         if(dragging)
         {
            moveDiff.x = renderPosition.x - _grabbedMousePoint.x;
            moveDiff.y = renderPosition.y - _grabbedMousePoint.y;
            if(underDragThreshold)
            {
               if(moveDiff.x < -DRAG_THRESHOLD || moveDiff.x > DRAG_THRESHOLD || moveDiff.y < -DRAG_THRESHOLD || moveDiff.y > DRAG_THRESHOLD)
               {
                  underDragThreshold = false;
               }
            }
            moveDrag.dispatch();
         }
      }
      
      private function onNativeUp(param1:MouseEvent) : void
      {
         mouseUp.dispatch();
         if(down && (!dragging || underDragThreshold) && !zooming)
         {
            hitTest();
            click.dispatch();
         }
         drop();
      }
      
      private function grab() : void
      {
         if(!down)
         {
            down = true;
            starlingStage.touchable = false;
         }
      }
      
      private function startDrag() : void
      {
         if(_dragEnabled)
         {
            hitTest();
            dragging = true;
            underDragThreshold = true;
            _grabbedMousePoint.x = renderPosition.x;
            _grabbedMousePoint.y = renderPosition.y;
            grabbedCanvasPoint.x = owner.root.viewport.rect.x;
            grabbedCanvasPoint.y = owner.root.viewport.rect.y;
            dragStarted.dispatch();
         }
      }
      
      private function drop() : void
      {
         dragging = false;
         down = false;
         starlingStage.touchable = true;
      }
      
      private function onPanGestureMove(param1:VelocityEvent) : void
      {
      }
      
      private function onPanGestureEnd(param1:VelocityEvent) : void
      {
         if(!onCanvas)
         {
            return;
         }
         drop();
         screenPan.addPanCommand(param1.velocityX,param1.velocityY);
      }
      
      private function onPinchGesture(param1:VelocityEvent) : void
      {
         if(!onCanvas)
         {
            return;
         }
         if(!down)
         {
            grab();
         }
         var _loc3_:Number = param1.positionX / stage.stageWidth;
         var _loc2_:Number = param1.positionY / stage.stageHeight;
         if(!zooming)
         {
            zooming = true;
            dragging = true;
            _grabbedZoomPoint.x = owner.root.viewport.rect.x + owner.root.viewport.rect.width * _loc3_;
            _grabbedZoomPoint.y = owner.root.viewport.rect.y + owner.root.viewport.rect.height * _loc2_;
            trace("start zoom",_grabbedZoomPoint);
         }
         owner.root.render.zoomFocal(_loc3_,_loc2_,_grabbedZoomPoint.x,_grabbedZoomPoint.y,param1.velocityY);
      }
      
      private function onPinchGestureEnd(param1:VelocityEvent) : void
      {
         drop();
         zooming = false;
      }
      
      override public function addMouseMoveHandler(param1:Slot0) : void
      {
         moveDrag.add(param1);
      }
      
      override public function removeMouseMoveHandler(param1:Slot0) : void
      {
         moveDrag.remove(param1);
      }
      
      private function onMouseWheel(param1:MouseEvent) : void
      {
         if(!onCanvas)
         {
            return;
         }
         var _loc3_:Number = param1.stageX / stage.stageWidth;
         var _loc2_:Number = param1.stageY / stage.stageHeight;
         _grabbedZoomPoint.x = owner.root.viewport.rect.x + owner.root.viewport.rect.width * _loc3_;
         _grabbedZoomPoint.y = owner.root.viewport.rect.y + owner.root.viewport.rect.height * _loc2_;
         render.zoomFocal(_loc3_,_loc2_,_grabbedZoomPoint.x,_grabbedZoomPoint.y,param1.delta < 0 ? 0.9 : 1.1);
      }
   }
}

