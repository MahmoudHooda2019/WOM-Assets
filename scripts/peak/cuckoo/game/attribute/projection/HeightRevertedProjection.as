package peak.cuckoo.game.attribute.projection
{
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.attribute.bounds.RenderBounds;
   import peak.cuckoo.game.dto.Point3;
   
   public class HeightRevertedProjection extends BaseProjection
   {
      
      private var bounds:RenderBounds;
      
      public function HeightRevertedProjection()
      {
         super(null);
      }
      
      override public function init() : void
      {
         super.init();
         bounds = (owner as GameSprite).bounds;
      }
      
      override public function transform(param1:Point3, param2:Point3) : void
      {
         param2.x = param1.x;
         param2.y = -param1.y - bounds.height;
         param2.z = param1.z;
      }
   }
}

