package peak.cuckoo.game.behavior
{
   import flash.geom.Point;
   import peak.cuckoo.core.Behavior;
   import peak.cuckoo.game.attribute.Viewport;
   import peak.cuckoo.game.dto.Point3;
   import peak.signal.Signal0;
   
   public class AutoScreenPanning extends Behavior
   {
      
      public static const TYPE_ID:String = "AutoScreenPanning";
      
      private var viewport:Viewport;
      
      private const targetPointOffset:Point = new Point();
      
      private var targetPoint:Point;
      
      private var wayPoints:Vector.<Point> = new Vector.<Point>();
      
      private var oldHipo:Number;
      
      private var userInteract:BaseInteract;
      
      public var panningFinished:Signal0;
      
      public var userCanDisable:Boolean = true;
      
      private var mouseSet:Boolean = false;
      
      public function AutoScreenPanning()
      {
         super();
         priority = 0;
      }
      
      override public function get typeId() : String
      {
         return "AutoScreenPanning";
      }
      
      override public function init() : void
      {
         super.init();
         viewport = owner.root.viewport;
         panningFinished = new Signal0();
         userInteract = owner.root.userInteract;
         startEnabled = false;
      }
      
      override public function update() : void
      {
         var _loc2_:Number = targetPointOffset.x - viewport.rect.x;
         var _loc4_:Number = targetPointOffset.y - viewport.rect.y;
         var _loc3_:Number = Math.sqrt(_loc2_ * _loc2_ + _loc4_ * _loc4_);
         var _loc1_:Number = Math.sqrt(_loc3_);
         if(_loc1_ < 2 || oldHipo == _loc3_)
         {
            disable();
         }
         oldHipo = _loc3_;
         viewport.moveTo(viewport.rect.x + _loc1_ * _loc2_ / _loc3_,viewport.rect.y + _loc1_ * _loc4_ / _loc3_);
      }
      
      override public function enable() : void
      {
         if(wayPoints.length == 0)
         {
            return;
         }
         super.enable();
      }
      
      override protected function start() : void
      {
         targetPoint = wayPoints[0];
         wayPoints.splice(0,1);
         targetPointOffset.x = targetPoint.x - viewport.rect.width / 2;
         targetPointOffset.y = targetPoint.y - viewport.rect.height / 2;
         oldHipo = -1;
         super.start();
      }
      
      override public function disable() : void
      {
         super.disable();
         if(wayPoints.length > 0)
         {
            enable();
         }
         else
         {
            mouseMoved(false);
            panningFinished.dispatch();
         }
      }
      
      public function reset() : void
      {
         wayPoints.length = 0;
         panningFinished.removeAll();
         disable();
      }
      
      public function addPoint(param1:Point3) : void
      {
         wayPoints.push(param1);
         disableWithDrag();
         enable();
      }
      
      public function addPointToCenter() : void
      {
         addPoint(new Point3(viewport.bounds.x + (viewport.bounds.width >> 1),viewport.bounds.y + (viewport.bounds.height >> 1)));
      }
      
      public function disableWithDrag() : void
      {
         if(userInteract && !mouseSet && userCanDisable)
         {
            mouseSet = true;
            userInteract.moveDrag.addFunction(mouseMoved);
         }
      }
      
      private function mouseMoved(param1:Boolean = true) : void
      {
         onMouseMoved();
         if(param1)
         {
            reset();
         }
      }
      
      private function onMouseMoved() : void
      {
         userInteract.moveDrag.removeFunction(mouseMoved);
         mouseSet = false;
      }
   }
}

