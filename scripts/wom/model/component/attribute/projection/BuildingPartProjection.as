package wom.model.component.attribute.projection
{
   import flash.geom.Point;
   import peak.cuckoo.game.Root;
   import peak.cuckoo.game.attribute.projection.BaseProjection;
   import peak.cuckoo.game.dto.Point3;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.component.entity.gamesprite.Decoration;
   
   public class BuildingPartProjection extends BaseProjection
   {
      
      private var isoOffset:Point;
      
      private var centerAlign:Boolean;
      
      public function BuildingPartProjection(param1:Boolean = false)
      {
         super(null);
         this.centerAlign = param1;
      }
      
      override public function init() : void
      {
         super.init();
         var _loc1_:int = (owner.parent is Building ? (owner.parent as Building).data.buildingTypeDIO.baseSize : (owner.parent is Decoration ? (owner.parent as Decoration).data.dio.baseSize : 0)) / 2;
         isoOffset = new Point(centerAlign ? _loc1_ * Root.PROJECTION_PITCH_X : 0,centerAlign ? _loc1_ * Root.PROJECTION_PITCH_Y : 0);
      }
      
      override public function transform(param1:Point3, param2:Point3) : void
      {
         param2.x = param1.x + isoOffset.x;
         param2.y = -param1.y - isoOffset.y;
         param2.z = param1.z;
      }
   }
}

