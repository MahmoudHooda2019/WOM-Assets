package wom.model.component.behavior.mouse.follow
{
   import flash.geom.Point;
   import peak.cuckoo.core.Attribute;
   import peak.cuckoo.game.attribute.Position;
   import peak.cuckoo.game.attribute.projection.BaseProjection;
   import peak.cuckoo.game.behavior.BaseInteract;
   import peak.cuckoo.game.dto.Point3;
   import peak.signal.Slot0;
   
   public class BaseMouseFollow extends Attribute implements Slot0
   {
      
      public static const TYPE_ID:String = "MouseFollow";
      
      protected var projection:BaseProjection;
      
      protected var position:Position;
      
      protected var userInteract:BaseInteract;
      
      public var target:Point3;
      
      public var serverCoordinate:Point;
      
      public function BaseMouseFollow()
      {
         super();
         target = new Point3();
      }
      
      override public function get typeId() : String
      {
         return "MouseFollow";
      }
      
      override public function init() : void
      {
         super.init();
         projection = owner.componentManager["BaseProjection"] as BaseProjection;
         position = owner.componentManager["Position"] as Position;
         userInteract = owner.root.userInteract;
      }
      
      public function onSignal0() : void
      {
         projection.reverse(userInteract.projectedPosition,target);
         target.x >>= 0;
         target.y >>= 0;
         position.move(target.x,target.y,0);
      }
      
      override public function enable() : void
      {
         super.enable();
      }
      
      override protected function start() : void
      {
         super.start();
         owner.root.userInteract.addMouseMoveHandler(this);
      }
      
      override protected function stop() : void
      {
         if(userInteract)
         {
            userInteract.removeMouseMoveHandler(this);
         }
         super.stop();
      }
   }
}

