package peak.cuckoo.game.attribute.bounds.notCompositeBased
{
   import flash.geom.Point;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.attribute.Position;
   import peak.cuckoo.game.attribute.bounds.*;
   import peak.cuckoo.game.behavior.animation.Animation;
   
   public class ParentRenderBounds extends RenderBounds
   {
      
      public function ParentRenderBounds()
      {
         super();
         this.point = new Point();
      }
      
      override public function init() : void
      {
         var _loc2_:Animation = null;
         projected = (owner.componentManager["Position"] as Position).projected;
         rect = owner.root.viewport.rect;
         var _loc1_:GameSprite = owner as GameSprite;
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
         point.x = projected.x - rect.x;
         point.y = projected.y - rect.y;
         right = point.x + baseWidth;
         bottom = point.y + baseHeight;
         for each(var _loc1_ in owner.children)
         {
            _loc1_.bounds.update();
         }
         (owner as GameSprite).view.gpuImage && (owner as GameSprite).view.gpuImage.updateCoords(true);
      }
   }
}

