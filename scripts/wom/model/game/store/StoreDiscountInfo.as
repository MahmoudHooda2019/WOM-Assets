package wom.model.game.store
{
   import flash.utils.Dictionary;
   
   public class StoreDiscountInfo
   {
      
      private var _currency:StoreItemCurrencyType;
      
      private var _multiplier:Number;
      
      private var _remainingDuration:Number;
      
      private var _excludedStoreItemIds:Dictionary;
      
      public function StoreDiscountInfo(param1:StoreItemCurrencyType, param2:Number, param3:Number)
      {
         super();
         _currency = param1;
         _multiplier = param2;
         _remainingDuration = param3;
         _excludedStoreItemIds = new Dictionary();
      }
      
      public function get currency() : StoreItemCurrencyType
      {
         return _currency;
      }
      
      public function get multiplier() : Number
      {
         return _multiplier;
      }
      
      public function get remainingDuration() : Number
      {
         return _remainingDuration;
      }
      
      public function set remainingDuration(param1:Number) : void
      {
         _remainingDuration = param1;
      }
      
      public function get excludedStoreItemIds() : Dictionary
      {
         return _excludedStoreItemIds;
      }
   }
}

