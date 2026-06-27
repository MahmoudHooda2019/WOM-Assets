package wom.model.dto.gold
{
   import wom.model.game.gold.PaymentEngine;
   
   public class GoldProductDTO
   {
      
      public static const USD_CURRENCY:String = "USD";
      
      private var _id:String;
      
      private var _amountOfGold:int;
      
      private var _localPrice:Number;
      
      private var _localCurrency:String;
      
      private var _priceUSD:Number;
      
      private var _fbCredits:Number;
      
      private var _peakPayId:String;
      
      public function GoldProductDTO(param1:String, param2:int, param3:Number, param4:String, param5:Number = 0, param6:Number = NaN, param7:String = null)
      {
         super();
         _id = param1;
         _amountOfGold = param2;
         _localPrice = param3;
         _localCurrency = param4;
         _priceUSD = param5;
         _fbCredits = param6;
         _peakPayId = param7;
      }
      
      public static function deserializeGoldProducts(param1:Object, param2:String, param3:PaymentEngine) : Vector.<GoldProductDTO>
      {
         var _loc4_:* = null;
         var _loc5_:Number = NaN;
         var _loc8_:String = null;
         var _loc6_:Number = NaN;
         var _loc7_:Vector.<GoldProductDTO> = new Vector.<GoldProductDTO>();
         if(param3 == PaymentEngine.NEW)
         {
            for each(_loc4_ in param1)
            {
               if(_loc4_ != null && "id" in _loc4_ && _loc4_.id != null && "amount" in _loc4_ && _loc4_.amount != null && "prices" in _loc4_ && _loc4_.prices != null && (param2 in _loc4_.prices || "USD" in _loc4_.prices))
               {
                  _loc8_ = param2 in _loc4_.prices ? param2 : "USD";
                  _loc5_ = Number(_loc4_.prices[_loc8_]);
                  _loc6_ = Number("USD" in _loc4_.prices ? _loc4_.prices["USD"] : 0);
                  _loc7_.push(new GoldProductDTO(_loc4_.id,_loc4_.amount,_loc5_,_loc8_,_loc6_));
               }
            }
         }
         else if(param3 == PaymentEngine.OLD)
         {
            for each(_loc4_ in param1)
            {
               if(_loc4_ != null && "currency" in _loc4_ && _loc4_.currency != null && "user_currency" in _loc4_.currency && _loc4_.currency.user_currency != null && "currency_exchange_inverse" in _loc4_.currency && _loc4_.currency.currency_exchange_inverse != null && "currency_offset" in _loc4_.currency && _loc4_.currency.currency_offset != null)
               {
                  _loc5_ = int(_loc4_.price_credits * _loc4_.currency.currency_exchange_inverse * _loc4_.currency.currency_offset) / _loc4_.currency.currency_offset;
                  _loc6_ = (_loc4_.price_credits >> 0) / 10;
                  _loc7_.push(new GoldProductDTO(_loc4_.id,_loc4_.amount,_loc5_,_loc4_.currency.user_currency,_loc6_,_loc4_.price_credits));
               }
            }
         }
         return _loc7_;
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function get amountOfGold() : int
      {
         return _amountOfGold;
      }
      
      public function get localPrice() : Number
      {
         return _localPrice;
      }
      
      public function get localCurrency() : String
      {
         return _localCurrency;
      }
      
      public function get localCurrencyFormatted() : String
      {
         switch(_localCurrency)
         {
            case "USD":
               return String.fromCharCode(36);
            case "EUR":
               return String.fromCharCode(8364);
            case "GBP":
               return String.fromCharCode(163);
            case "TRY":
               return String.fromCharCode(168);
            default:
               return _localCurrency;
         }
      }
      
      public function get priceUSD() : Number
      {
         return _priceUSD;
      }
      
      public function get fbCredits() : Number
      {
         return _fbCredits;
      }
      
      public function get peakPayId() : String
      {
         return _peakPayId;
      }
      
      public function set localPrice(param1:Number) : void
      {
         _localPrice = param1;
      }
      
      public function set localCurrency(param1:String) : void
      {
         _localCurrency = param1;
      }
   }
}

