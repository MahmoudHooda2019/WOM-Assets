package wom.model.component.attribute.projection
{
   import flash.geom.Point;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.attribute.bounds.RenderBounds;
   import peak.cuckoo.game.attribute.projection.BaseProjection;
   import peak.cuckoo.game.dto.Point3;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.component.entity.gamesprite.Decoration;
   
   public class HeightRevertedBuildingPartProjectionDeprecated extends BaseProjection
   {
      
      private var bounds:RenderBounds;
      
      private var isoOffset:Point;
      
      private var placeHolder:Boolean;
      
      public function HeightRevertedBuildingPartProjectionDeprecated(param1:Boolean = false)
      {
         super(null);
         this.placeHolder = param1;
      }
      
      override public function init() : void
      {
         super.init();
         bounds = (owner as GameSprite).bounds;
         var _loc1_:int = int(owner.parent is Building ? (owner.parent as Building).data.buildingTypeDIO.baseSize : (owner.parent is Decoration ? (owner.parent as Decoration).data.dio.baseSize : 0));
         isoOffset = new Point(placeHolder ? 0 : _loc1_,placeHolder ? 0 : _loc1_ * 0.5);
      }
      
      override public function transform(param1:Point3, param2:Point3) : void
      {
         param2.x = param1.x + isoOffset.x;
         param2.y = -param1.y - bounds.height - isoOffset.y;
         param2.z = param1.z;
      }
   }
}

