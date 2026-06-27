package wom.model.game.store
{
   public class StoreInfo
   {
      
      public static const FINISH_FREE_ITEM_ID:int = 2003;
      
      public static const CUT_30_MIN_ITEM_ID:int = 2004;
      
      public static const FINISH_NOW_ITEM_ID:int = 2007;
      
      public static const REPAIR_ITEM_ID:int = 2008;
      
      public static const TOWER_DAMAGE_BOOST_ID:int = 4012;
      
      public static const CUT_30_MIN_PRICE:int = 30;
      
      private var _discount:StoreDiscountInfo;
      
      public function StoreInfo()
      {
         super();
         _discount = null;
      }
      
      public function get discount() : StoreDiscountInfo
      {
         return _discount;
      }
      
      public function set discount(param1:StoreDiscountInfo) : void
      {
         _discount = param1;
      }
   }
}

