package wom.model.game.event
{
   import wom.model.dto.PartInfoDTO;
   import wom.model.game.store.ItemCooldownDurationInfo;
   import wom.model.game.store.ItemEffectInfo;
   import wom.model.game.store.StoreItemCurrencyType;
   import wom.model.game.store.StoreItemInfo;
   
   public class EventStoreItemInfo extends StoreItemInfo
   {
      
      public static const SAMURAI_UNLOCK_COST:int = 300;
      
      public static const ACID_RAIN_UNLOCK_COST:int = 500;
      
      public static const SIEGE_TOWER_UNLOCK_COST:int = 800;
      
      public static const LONGBOWMAN_TOWER_UNLOCK_COST:int = 900;
      
      public static const CYCLOPS_UNLOCK_COST:int = 1500;
      
      public static const ICE_SHARDS_UNLOCK_COST:int = 1750;
      
      public static const ACID_TOWER_UNLOCK_COST:int = 2000;
      
      public static const HEAL_AURA_UNLOCK_COST:int = 2500;
      
      public static const LATEST_INTRODUCED_ITEM_UNLOCK_COST:int = 2500;
      
      private var _amount:int;
      
      private var _eventItemType:EventItemType;
      
      private var _assetLarge:String;
      
      private var _unlockCost:int;
      
      public function EventStoreItemInfo(param1:EventItemType, param2:int, param3:String, param4:String, param5:String, param6:StoreItemCurrencyType, param7:String, param8:Boolean, param9:int, param10:int, param11:String, param12:Vector.<PartInfoDTO> = null, param13:int = -1, param14:ItemEffectInfo = null, param15:ItemCooldownDurationInfo = null, param16:int = 0)
      {
         super(param2,param3,param5,param6,param7,param8,param9,param11,param12,param13,param14,param15);
         _amount = param16;
         _eventItemType = param1;
         _assetLarge = param4;
         _unlockCost = param10;
      }
      
      public function get amount() : int
      {
         return _amount;
      }
      
      public function get eventItemType() : EventItemType
      {
         return _eventItemType;
      }
      
      public function get assetLarge() : String
      {
         return _assetLarge;
      }
      
      public function get unlockCost() : int
      {
         return _unlockCost;
      }
   }
}

