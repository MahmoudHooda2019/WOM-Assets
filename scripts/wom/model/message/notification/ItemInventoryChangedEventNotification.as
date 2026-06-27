package wom.model.message.notification
{
   import flash.utils.Dictionary;
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.game.store.ItemCooldownDurationInfo;
   import wom.model.game.store.ItemEffectInfo;
   import wom.model.game.store.ItemEffectType;
   
   public class ItemInventoryChangedEventNotification extends AbstractIncomingMessage
   {
      
      private var _storeItemEffects:Vector.<ItemEffectInfo>;
      
      private var _storeItemCooldownDurations:Dictionary;
      
      private var _stockpileBoostCount:int;
      
      public function ItemInventoryChangedEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         var _loc4_:ItemEffectType = null;
         var _loc5_:Object = param1.itemInventory;
         _stockpileBoostCount = _loc5_.stockPileBoostCount;
         _storeItemEffects = new Vector.<ItemEffectInfo>();
         for each(var _loc2_ in _loc5_.effects)
         {
            _loc4_ = ItemEffectType.determineItemEffectType(_loc2_.itemEffectType);
            _storeItemEffects.push(new ItemEffectInfo(_loc4_,_loc2_.bonusPercent,_loc2_.dateStartedUsing,_loc2_.dateEndOfUsage,_loc2_.remainingDuration));
         }
         _storeItemCooldownDurations = new Dictionary();
         for each(var _loc3_ in _loc5_.cooldownDurations)
         {
            _storeItemCooldownDurations[_loc3_.itemId] = new ItemCooldownDurationInfo(_loc3_.itemId,_loc3_.cooldownDuration);
         }
      }
      
      public function get storeItemEffects() : Vector.<ItemEffectInfo>
      {
         return _storeItemEffects;
      }
      
      public function get storeItemCooldownDurations() : Dictionary
      {
         return _storeItemCooldownDurations;
      }
      
      public function get stockpileBoostCount() : int
      {
         return _stockpileBoostCount;
      }
   }
}

