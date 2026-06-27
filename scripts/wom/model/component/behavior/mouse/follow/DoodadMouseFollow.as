package wom.model.component.behavior.mouse.follow
{
   import flash.geom.Point;
   import peak.cuckoo.game.dto.Point3;
   import wom.model.component.entity.gamesprite.Doodad;
   
   public class DoodadMouseFollow extends BaseMouseFollow
   {
      
      private var ownerDoodad:Doodad;
      
      public var offset:Point;
      
      public function DoodadMouseFollow()
      {
         super();
         target = new Point3();
         offset = new Point();
      }
      
      override public function init() : void
      {
         super.init();
         userInteract = owner.root.userInteract;
         ownerDoodad = owner as Doodad;
         startEnabled = false;
      }
      
      override public function onSignal0() : void
      {
         projection.reverse(userInteract.projectedPosition,target);
         target.x >>= 0;
         target.y >>= 0;
         position.move(target.x + offset.x,target.y + offset.y,0);
         ownerDoodad.position.move(target.x + offset.x,target.y + offset.y,ownerDoodad.zIndex + 500);
      }
      
      public function startDrag() : void
      {
         target.x = userInteract.projectedPosition.x >> 0;
         target.y = userInteract.projectedPosition.y >> 0;
         offset.x = ownerDoodad.position.point.x - target.x;
         offset.y = ownerDoodad.position.point.y - target.y;
         enable();
      }
      
      public function stopDrag() : void
      {
         disable();
      }
   }
}

