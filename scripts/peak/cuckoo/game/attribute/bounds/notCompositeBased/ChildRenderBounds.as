package peak.cuckoo.game.attribute.bounds.notCompositeBased
{
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.attribute.bounds.RenderBounds;
   import peak.cuckoo.game.dto.Point3;
   
   public class ChildRenderBounds extends RenderBounds
   {
      
      private var compositeRenderBounds:RenderBounds;
      
      private var compositeProjected:Point3;
      
      public function ChildRenderBounds()
      {
         super();
      }
      
      override public function init() : void
      {
         var _loc1_:GameSprite = owner as GameSprite;
         projected = _loc1_.position.projected;
         compositeProjected = _loc1_.composite.position.projected;
         rect = owner.root.viewport.rect;
         compositeRenderBounds = _loc1_.composite.bounds;
         if(_loc1_.view.prepared)
         {
            this.baseWidth = this.width = _loc1_.view.bitmapDataRect.width;
            this.baseHeight = this.height = _loc1_.view.bitmapDataRect.height;
         }
         if(_loc1_.view.gpuImage)
         {
            this.baseWidth = this.width = _loc1_.view.width;
            this.baseHeight = this.height = _loc1_.view.height;
         }
         update();
      }
      
      override public function update() : void
      {
         point.x = compositeProjected.x + projected.x - rect.x;
         point.y = compositeProjected.y + projected.y - rect.y;
         right = point.x + baseWidth;
         bottom = point.y + baseHeight;
         (owner as GameSprite).view.gpuImage && (owner as GameSprite).view.gpuImage.updateCoords(true);
      }
   }
}

