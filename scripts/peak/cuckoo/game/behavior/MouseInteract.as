package peak.cuckoo.game.behavior
{
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.ui.Mouse;
   import peak.cuckoo.game.GameSprite;
   import peak.display.CustomCursorManager;
   import peak.logging.LoggerContexts;
   import peak.logging.log;
   import peak.signal.Signal0;
   import peak.signal.Slot0;
   
   public class MouseInteract extends BaseInteract
   {
      
      public static const TYPE_ID:String = "BaseInteract";
      
      protected var canvas:InteractiveObject;
      
      protected var disableAfterDrag:Boolean = false;
      
      protected var pickedEntityWaiting:int;
      
      private var cursorManager:CustomCursorManager;
      
      public function MouseInteract(param1:String = "auto")
      {
         super();
         priority = 1;
         cursorManager = new CustomCursorManager(param1);
      }
      
      override public function get typeId() : String
      {
         return "BaseInteract";
      }
      
      override public function init() : void
      {
         super.init();
         startEnabled = false;
         render = owner.root.render;
         projectedPosition = new Point();
         renderPosition = new Point();
         click = new Signal0();
         ctrlClick = new Signal0();
         pickedEntityChanged = new Signal0();
         dragStarted = new Signal0();
         moveDrag = new Signal0();
         move = new Signal0();
         mouseDown = new Signal0();
         mouseUp = new Signal0();
         canvas = stage;
         this.enable();
      }
      
      override public function update() : void
      {
         renderPosition.x = canvas.mouseX;
         renderPosition.y = canvas.mouseY;
         projectedPosition.x = renderPosition.x + rect.x;
         projectedPosition.y = renderPosition.y + rect.y;
         hitTest();
      }
      
      override protected function setPickedEntity(param1:GameSprite) : void
      {
         if(pickedEntity != param1)
         {
            if(pickedEntity)
            {
               var _loc2_:CustomCursorManager = cursorManager;
               flash.ui.Mouse.cursor = _loc2_.defaultCursor;
               undefined;
               if(pickedEntity.filter == selectionOutlineStyle)
               {
                  pickedEntity.filter = 0;
               }
            }
            pickedEntity = param1;
            if(pickedEntity)
            {
               var _loc3_:CustomCursorManager = cursorManager;
               _loc3_.savedCursor = flash.ui.Mouse.cursor;
               flash.ui.Mouse.cursor = "button";
               undefined;
               if(pickedEntity.filter == 0)
               {
                  pickedEntity.filter = selectionOutlineStyle;
               }
            }
            pickedEntityWaiting = 0;
            pickedEntityChanged.dispatch();
         }
      }
      
      protected function onMouseDown(param1:MouseEvent) : void
      {
         false && log(LoggerContexts.CUCKOOMOUSE,"onMouseDown",canvas.name);
         down = true;
         stage.addEventListener("mouseUp",onMouseUp);
         if(_dragEnabled)
         {
            stage.addEventListener("mouseMove",onMouseMove);
            underDragThreshold = true;
            _grabbedMousePoint = new Point(param1.stageX,param1.stageY);
            grabbedCanvasPoint = new Point(owner.root.viewport.rect.x,owner.root.viewport.rect.y);
         }
         mouseDown.dispatch();
      }
      
      public function onRollOver(param1:MouseEvent) : void
      {
         false && log(LoggerContexts.CUCKOOMOUSE,"onRollOver",canvas.name);
         this.enable();
         if(disableAfterDrag)
         {
            disableAfterDrag = false;
         }
      }
      
      public function onRollOut(param1:MouseEvent) : void
      {
         false && log(LoggerContexts.CUCKOOMOUSE,"onRollOut",canvas.name);
         setPickedEntity(null);
         if(!dragging)
         {
            false && log(LoggerContexts.CUCKOOMOUSE,"disable",canvas.name);
            this.disable();
         }
         else
         {
            false && log(LoggerContexts.CUCKOOMOUSE,"disableAfterDrag",canvas.name);
            disableAfterDrag = true;
         }
      }
      
      protected function onMouseUp(param1:MouseEvent) : void
      {
         stage.removeEventListener("mouseUp",onMouseUp);
         stage.removeEventListener("mouseMove",onMouseMove);
         down = false;
         mouseUp.dispatch();
         if(dragging)
         {
            dragging = false;
            var _loc2_:CustomCursorManager = cursorManager;
            if(_loc2_.savedCursor && flash.ui.Mouse.cursor == "hand")
            {
               flash.ui.Mouse.cursor = _loc2_.savedCursor;
            }
            undefined;
            if(disableAfterDrag)
            {
               disableAfterDrag = false;
               this.disable();
            }
         }
         else if(param1.ctrlKey)
         {
            ctrlClick.dispatch();
         }
         else
         {
            click.dispatch();
         }
      }
      
      private function onMouseMove(param1:MouseEvent) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(underDragThreshold)
         {
            _loc2_ = param1.stageX - _grabbedMousePoint.x;
            _loc3_ = param1.stageY - _grabbedMousePoint.y;
            if(_loc2_ < -4 || _loc2_ > 4 || _loc3_ < -4 || _loc3_ > 4)
            {
               underDragThreshold = false;
            }
            return;
         }
         if(!dragging && down)
         {
            dragStarted.dispatch();
            dragging = true;
            var _loc4_:CustomCursorManager = cursorManager;
            _loc4_.savedCursor = flash.ui.Mouse.cursor;
            flash.ui.Mouse.cursor = "hand";
            undefined;
         }
         owner.root.viewport.moveTo(grabbedCanvasPoint.x - (param1.stageX - _grabbedMousePoint.x) / owner.root.scale,grabbedCanvasPoint.y - (param1.stageY - _grabbedMousePoint.y) / owner.root.scale);
         moveDrag.dispatch();
      }
      
      override protected function stop() : void
      {
         false && log(LoggerContexts.CUCKOOMOUSE,"stop",canvas.name);
         super.stop();
         stage.removeEventListener("mouseDown",onMouseDown);
         stage.removeEventListener("mouseUp",onMouseUp);
         stage.removeEventListener("mouseMove",onMouseMove);
      }
      
      override protected function start() : void
      {
         false && log(LoggerContexts.CUCKOOMOUSE,"start",canvas.name);
         super.start();
         stage.addEventListener("mouseDown",onMouseDown);
      }
      
      override public function addMouseMoveHandler(param1:Slot0) : void
      {
         if(!move.hasAnyHandler())
         {
            stage.addEventListener("mouseMove",onMouseMoveWithoutDrag);
         }
         move.add(param1);
      }
      
      override public function removeMouseMoveHandler(param1:Slot0) : void
      {
         move.remove(param1);
         try
         {
            if(!move.hasAnyHandler())
            {
               stage.removeEventListener("mouseMove",onMouseMoveWithoutDrag);
            }
         }
         catch(e:Error)
         {
         }
      }
      
      private function onMouseMoveWithoutDrag(param1:MouseEvent) : void
      {
         move.dispatch();
      }
      
      override public function terminate() : void
      {
         false && log(LoggerContexts.CUCKOOMOUSE,"terminate",canvas.name);
         disable();
         click.removeAll();
         pickedEntityChanged.removeAll();
         dragStarted.removeAll();
         moveDrag.removeAll();
         stage.removeEventListener("mouseDown",onMouseDown);
         stage.removeEventListener("mouseUp",onMouseUp);
         stage.removeEventListener("mouseMove",onMouseMove);
         stage.removeEventListener("mouseMove",onMouseMoveWithoutDrag);
      }
      
      override public function destroy() : void
      {
         disable();
      }
      
      override public function dragEnabled() : void
      {
         _dragEnabled = true;
      }
      
      override public function dragDisabled() : void
      {
         if(dragging)
         {
            onMouseUp(null);
         }
         _dragEnabled = false;
      }
      
      public function dragState() : Boolean
      {
         return _dragEnabled;
      }
      
      private function onMouseWheel(param1:MouseEvent) : void
      {
         render.zoom(canvas.mouseX,canvas.mouseY,param1.delta < 0 ? -0.1 : 0.1);
      }
   }
}

