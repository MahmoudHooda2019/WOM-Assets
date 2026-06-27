package peak.cuckoo.game.attribute.filter
{
   import peak.cuckoo.core.Attribute;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.attribute.view.CompositeView;
   
   public class FilterManager extends Attribute
   {
      
      public static const TYPE_ID:String = "FilterManager";
      
      private static const NO_FILTER:Filter = new Filter();
      
      private var filters:Vector.<Filter>;
      
      private var ownerSprite:GameSprite;
      
      public function FilterManager()
      {
         super();
         filters = new Vector.<Filter>();
      }
      
      override public function init() : void
      {
         super.init();
         ownerSprite = owner as GameSprite;
         if(filters.length > 0)
         {
            if(ownerSprite.view is CompositeView)
            {
               for each(var _loc1_ in filters)
               {
                  addFilter(_loc1_);
               }
               filters.length = 0;
            }
            applyFilters();
         }
      }
      
      public function addFilter(param1:Filter) : void
      {
         if(ownerSprite && ownerSprite.view is CompositeView)
         {
            for each(var _loc2_ in (ownerSprite.view as CompositeView).children)
            {
               _loc2_.filterManager.addFilter(param1);
            }
         }
         else if(addIfAbsent(param1))
         {
            applyFilters();
         }
      }
      
      private function addIfAbsent(param1:Filter) : Boolean
      {
         for each(var _loc2_ in filters)
         {
            if(_loc2_ == param1)
            {
               return false;
            }
         }
         filters.push(param1);
         return true;
      }
      
      public function removeFilter(param1:Filter) : void
      {
         var _loc4_:int = 0;
         var _loc3_:Filter = null;
         if(ownerSprite && ownerSprite.view is CompositeView)
         {
            for each(var _loc2_ in (ownerSprite.view as CompositeView).children)
            {
               _loc2_.filterManager.removeFilter(param1);
            }
         }
         else
         {
            _loc4_ = 0;
            while(_loc4_ < filters.length)
            {
               _loc3_ = filters[_loc4_];
               if(_loc3_ == param1)
               {
                  filters.splice(_loc4_,1);
                  break;
               }
               _loc4_++;
            }
            applyFilters();
         }
      }
      
      public function clearFilters() : void
      {
         if(ownerSprite && ownerSprite.view is CompositeView)
         {
            for each(var _loc1_ in (ownerSprite.view as CompositeView).children)
            {
               _loc1_.filterManager.clearFilters();
            }
         }
         else
         {
            filters.length = 0;
            applyFilter(NO_FILTER);
         }
      }
      
      public function applyFilters() : void
      {
         if(ownerSprite && ownerSprite.view is CompositeView)
         {
            for each(var _loc1_ in (ownerSprite.view as CompositeView).children)
            {
               _loc1_.filterManager.applyFilters();
            }
         }
         else if(filters.length == 0)
         {
            applyFilter(NO_FILTER);
         }
         else
         {
            applyFilter(mergeFilters());
         }
      }
      
      private function mergeFilters() : Filter
      {
         return filters[filters.length - 1];
      }
      
      private function applyFilter(param1:Filter) : void
      {
         if(!ownerSprite)
         {
            return;
         }
         if(!ownerSprite.view)
         {
            return;
         }
         ownerSprite.view.alphaFilter(param1.alpha);
         ownerSprite.view.colorFilter(param1.color);
         ownerSprite.view.glowEnabled(param1.glow);
      }
   }
}

