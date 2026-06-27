package peak.cuckoo.game.behavior.cull
{
   import peak.cuckoo.game.GameSprite;
   
   public class ViewingFrustumCull extends BaseCull
   {
      
      public function ViewingFrustumCull()
      {
         super();
      }
      
      override public function init() : void
      {
         super.init();
      }
      
      override public function update() : void
      {
         var _loc3_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc4_:int = 0;
         if(viewContainer)
         {
            _loc3_ = viewport.rect.height;
            _loc2_ = viewport.rect.width;
            _loc4_ = 0;
            for each(var _loc1_ in allContainer.children)
            {
               if(_loc1_.bounds.right < 0 || _loc1_.bounds.point.x > _loc2_ || _loc1_.bounds.bottom < 0 || _loc1_.bounds.point.y > _loc3_)
               {
                  _loc1_.culled = true;
               }
               else
               {
                  viewContainer.renderChildren[_loc4_++] = _loc1_;
                  _loc1_.culled = false;
               }
            }
            viewContainer.renderChildren.length = _loc4_;
         }
      }
   }
}

