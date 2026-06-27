package peak.cuckoo.game.attribute.bounds.compositeBased
{
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.attribute.bounds.RenderBounds;
   import peak.cuckoo.game.behavior.animation.Animation;
   import peak.cuckoo.game.dto.Point3;
   
   public class CompositeChildRenderBounds extends RenderBounds
   {
      
      private var compositeRenderBounds:RenderBounds;
      
      private var compositeProjected:Point3;
      
      public function CompositeChildRenderBounds()
      {
         super();
      }
      
      override public function init() : void
      {
         var _loc2_:Animation = null;
         var _loc1_:GameSprite = owner as GameSprite;
         projected = _loc1_.position.projected;
         compositeProjected = _loc1_.composite.position.projected;
         rect = owner.root.viewport.rect;
         compositeRenderBounds = _loc1_.composite.bounds;
         if(_loc1_.view.prepared)
         {
            if(_loc1_.view.bitmapDataRect)
            {
               this.baseWidth = this.width = _loc1_.view.bitmapDataRect.width;
               this.baseHeight = this.height = _loc1_.view.bitmapDataRect.height;
            }
         }
         if("Animation" in owner.componentManager)
         {
            _loc2_ = owner.componentManager["Animation"] as Animation;
            this.baseWidth = this.width = _loc2_.frameWidth;
            this.baseHeight = this.height = _loc2_.frameHeight;
         }
         else if(_loc1_.view.gpuImage)
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
         if(point.x < compositeRenderBounds.point.x)
         {
            compositeRenderBounds.point.x = point.x;
         }
         if(point.y < compositeRenderBounds.point.y)
         {
            compositeRenderBounds.point.y = point.y;
         }
         if(right > compositeRenderBounds.right)
         {
            compositeRenderBounds.right = right;
         }
         if(bottom > compositeRenderBounds.bottom)
         {
            compositeRenderBounds.bottom = bottom;
         }
      }
   }
}

