package wom.model.component.attribute.view
{
   import peak.cuckoo.game.attribute.filter.Filter;
   import peak.cuckoo.game.attribute.filter.Filters;
   
   public class WomFilters extends Filters
   {
      
      public static const MOVE_FILTER:Filter = new Filter(0.5);
      
      public static const GRAY_FILTER:Filter = new Filter(1,8947848);
      
      public static const LIGHT_BLUE_FILTER:Filter = new Filter(1,1744624);
      
      public static const PURPLE_FILTER:Filter = new Filter(1,10118108);
      
      public function WomFilters()
      {
         super();
      }
   }
}

