package peak.cuckoo.game.attribute.bounds.compositeBased
{
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.attribute.bounds.RenderBounds;
   import peak.cuckoo.game.attribute.view.CompositeView;
   
   public class CompositeRenderBounds extends RenderBounds
   {
      
      private var compositeView:CompositeView;
      
      public function CompositeRenderBounds()
      {
         super();
      }
      
      override public function init() : void
      {
         compositeView = (owner as GameSprite).view as CompositeView;
         super.init();
      }
      
      override public function update() : void
      {
         point.x = point.y = 1000000;
         right = bottom = -1;
         for each(var _loc1_ in owner.children)
         {
            try
            {
               _loc1_.bounds.update();
            }
            catch(e:Error)
            {
               trace("zombie child-----------------------------------------------------------------");
            }
         }
         width = right - point.x;
         height = bottom - point.y;
         (owner as GameSprite).view.gpuImage && (owner as GameSprite).view.gpuImage.updateCoords(true);
      }
   }
}

