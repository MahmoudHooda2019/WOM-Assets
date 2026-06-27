package wom.model.dto.gold
{
   import flash.utils.Dictionary;
   import wom.model.game.gold.PaymentEngine;
   
   public class MobileGoldProductDTO extends GoldProductDTO
   {
      
      public static const DEFAULT_COUNTRY:String = "--";
      
      private var _pricePointId:String;
      
      public function MobileGoldProductDTO(param1:String, param2:int, param3:Number, param4:String, param5:Number = 0, param6:Number = NaN, param7:String = null)
      {
         super(param1,param2,param3,param4,param5,param6);
         _pricePointId = param7;
      }
      
      public static function deserializeMobileGoldProducts(param1:Object, param2:String, param3:PaymentEngine) : Dictionary
      {
         var _loc6_:* = null;
         var _loc4_:GoldProductDTO = null;
         var _loc5_:* = undefined;
         var _loc7_:Dictionary = new Dictionary();
         if(param3 == PaymentEngine.NEW)
         {
            if("prices" in param1 && param1.prices != null)
            {
               for each(_loc6_ in param1.prices)
               {
                  if(_loc6_ && _loc6_ != null && "id" in _loc6_ && _loc6_.id != null)
                  {
                     if(!(_loc6_.country in _loc7_))
                     {
                        _loc7_[_loc6_.country] = new Vector.<GoldProductDTO>();
                     }
                     _loc4_ = new MobileGoldProductDTO(_loc6_.id,_loc6_.gold,_loc6_.price,_loc6_.currency,_loc6_.usdprice,NaN,_loc6_.ppid);
                     _loc7_[_loc6_.country].push(_loc4_);
                  }
               }
            }
         }
         else if(param3 == PaymentEngine.OLD)
         {
            _loc5_ = new Vector.<GoldProductDTO>();
            for each(_loc6_ in param1)
            {
               if(_loc6_ && _loc6_ != null && "gold" in _loc6_)
               {
                  _loc4_ = new MobileGoldProductDTO(_loc6_.gold,_loc6_.gold,_loc6_.user_price,_loc6_.local_currency,(_loc6_.credits >> 0) / 10,_loc6_.credits);
                  _loc5_.push(_loc4_);
               }
            }
            if(_loc5_.length > 0)
            {
               _loc7_["--"] = _loc5_;
            }
         }
         return _loc7_;
      }
      
      public function get pricePointId() : String
      {
         return _pricePointId;
      }
   }
}

