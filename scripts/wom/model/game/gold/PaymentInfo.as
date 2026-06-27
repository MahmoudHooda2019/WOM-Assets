package wom.model.game.gold
{
   import flash.utils.Dictionary;
   import wom.model.dto.gold.GoldProductDTO;
   
   public class PaymentInfo
   {
      
      private var _paymentEngine:PaymentEngine;
      
      private var _goldProducts:Vector.<GoldProductDTO>;
      
      private var _mobileGoldProducts:Dictionary;
      
      private var _defaultCurrency:String;
      
      private var _topSellerGoldProductId:String;
      
      public function PaymentInfo()
      {
         super();
         _paymentEngine = PaymentEngine.NEW;
         _goldProducts = new Vector.<GoldProductDTO>();
         _mobileGoldProducts = new Dictionary();
         _defaultCurrency = "USD";
         _topSellerGoldProductId = null;
      }
      
      public function get paymentEngine() : PaymentEngine
      {
         return _paymentEngine;
      }
      
      public function set paymentEngine(param1:PaymentEngine) : void
      {
         _paymentEngine = param1;
      }
      
      public function get goldProducts() : Vector.<GoldProductDTO>
      {
         return _goldProducts;
      }
      
      public function set goldProducts(param1:Vector.<GoldProductDTO>) : void
      {
         _goldProducts = param1;
      }
      
      public function get mobileGoldProducts() : Dictionary
      {
         return _mobileGoldProducts;
      }
      
      public function set mobileGoldProducts(param1:Dictionary) : void
      {
         _mobileGoldProducts = param1;
      }
      
      public function getMobileGoldProductsLength() : int
      {
         var _loc1_:int = 0;
         if(_mobileGoldProducts != null)
         {
            for(var _loc2_ in _mobileGoldProducts)
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      public function get defaultCurrency() : String
      {
         return _defaultCurrency;
      }
      
      public function set defaultCurrency(param1:String) : void
      {
         _defaultCurrency = param1;
      }
      
      public function get topSellerGoldProductId() : String
      {
         return _topSellerGoldProductId;
      }
      
      public function set topSellerGoldProductId(param1:String) : void
      {
         _topSellerGoldProductId = param1;
      }
   }
}

