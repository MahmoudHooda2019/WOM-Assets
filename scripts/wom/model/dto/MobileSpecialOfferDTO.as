package wom.model.dto
{
   public class MobileSpecialOfferDTO
   {
      
      private var _goldAmount:int;
      
      private var _price:Number;
      
      private var _offerPercentage:int;
      
      private var _expireDate:Number;
      
      private var _title:String;
      
      private var _itemCount:int;
      
      private var _hashed_id:String;
      
      private var _textLanguage:String;
      
      private var _currencySymbol:String;
      
      private var _peakPayId:String;
      
      public function MobileSpecialOfferDTO(param1:int, param2:Number, param3:int, param4:Number, param5:String, param6:int, param7:String, param8:String, param9:String, param10:String = null)
      {
         super();
         _goldAmount = param1;
         _price = param2;
         _offerPercentage = param3;
         _expireDate = param4;
         _title = param5;
         _itemCount = param6;
         _hashed_id = param7;
         _textLanguage = param8;
         _currencySymbol = param9;
         _peakPayId = param10;
      }
      
      public static function deserialize(param1:Object) : MobileSpecialOfferDTO
      {
         var _loc2_:String = "peakpay_id" in param1 && param1.peakpay_id != null ? param1.peakpay_id : null;
         return new MobileSpecialOfferDTO(param1.gold,param1.price,param1.ratio,param1.expiry,param1.title,param1.count,param1.hashed_id,param1.text,"$",_loc2_);
      }
      
      public function get goldAmount() : int
      {
         return _goldAmount;
      }
      
      public function set goldAmount(param1:int) : void
      {
         _goldAmount = param1;
      }
      
      public function get price() : Number
      {
         return _price;
      }
      
      public function set price(param1:Number) : void
      {
         _price = param1;
      }
      
      public function get offerPercentage() : int
      {
         return _offerPercentage;
      }
      
      public function set offerPercentage(param1:int) : void
      {
         _offerPercentage = param1;
      }
      
      public function get expireDate() : Number
      {
         return _expireDate;
      }
      
      public function set expireDate(param1:Number) : void
      {
         _expireDate = param1;
      }
      
      public function get title() : String
      {
         return _title;
      }
      
      public function set title(param1:String) : void
      {
         _title = param1;
      }
      
      public function get itemCount() : int
      {
         return _itemCount;
      }
      
      public function set itemCount(param1:int) : void
      {
         _itemCount = param1;
      }
      
      public function get hashed_id() : String
      {
         return _hashed_id;
      }
      
      public function set hashed_id(param1:String) : void
      {
         _hashed_id = param1;
      }
      
      public function get textLanguage() : String
      {
         return _textLanguage;
      }
      
      public function set textLanguage(param1:String) : void
      {
         _textLanguage = param1;
      }
      
      public function get currencySymbol() : String
      {
         return _currencySymbol;
      }
      
      public function set currencySymbol(param1:String) : void
      {
         _currencySymbol = param1;
      }
      
      public function get peakPayId() : String
      {
         return _peakPayId;
      }
   }
}

