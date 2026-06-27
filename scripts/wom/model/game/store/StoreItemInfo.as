package wom.model.game.store
{
   import wom.model.dto.PartInfoDTO;
   
   public class StoreItemInfo
   {
      
      public static const ITEM_ID_WORKER:int = 1001;
      
      public static const ITEM_ID_EXPAND_CITY:int = 1003;
      
      private var _id:int;
      
      private var _asset:String;
      
      private var _name:String;
      
      private var _currency:StoreItemCurrencyType;
      
      private var _description:String;
      
      private var _locked:Boolean;
      
      private var _price:int;
      
      private var _partRequirements:Vector.<PartInfoDTO>;
      
      private var _subline:String;
      
      private var _instanceId:int;
      
      private var _effectCooldown:ItemEffectInfo;
      
      private var _buyCooldown:ItemCooldownDurationInfo;
      
      public function StoreItemInfo(param1:int, param2:String, param3:String, param4:StoreItemCurrencyType, param5:String, param6:Boolean, param7:int, param8:String, param9:Vector.<PartInfoDTO> = null, param10:int = -1, param11:ItemEffectInfo = null, param12:ItemCooldownDurationInfo = null)
      {
         super();
         _id = param1;
         _asset = param2;
         _name = param3;
         _currency = param4;
         _description = param5;
         _locked = param6;
         _price = param7;
         _partRequirements = param9;
         _subline = param8;
         _instanceId = param10;
         _effectCooldown = param11;
         _buyCooldown = param12;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get asset() : String
      {
         return _asset;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get currency() : StoreItemCurrencyType
      {
         return _currency;
      }
      
      public function get locked() : Boolean
      {
         return _locked;
      }
      
      public function getPrice(param1:StoreDiscountInfo) : int
      {
         return _price * (param1 != null && param1.currency.id == _currency.id && !(_id in param1.excludedStoreItemIds) ? param1.multiplier : 1) >> 0;
      }
      
      public function getOriginalPrice() : int
      {
         return _price;
      }
      
      public function get partRequirements() : Vector.<PartInfoDTO>
      {
         return _partRequirements;
      }
      
      public function get description() : String
      {
         return _description;
      }
      
      public function get subline() : String
      {
         return _subline;
      }
      
      public function get instanceId() : int
      {
         return _instanceId;
      }
      
      public function get effectCooldown() : ItemEffectInfo
      {
         return _effectCooldown;
      }
      
      public function get buyCooldown() : ItemCooldownDurationInfo
      {
         return _buyCooldown;
      }
   }
}

