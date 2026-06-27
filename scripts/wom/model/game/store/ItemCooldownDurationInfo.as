package wom.model.game.store
{
   public class ItemCooldownDurationInfo
   {
      
      private var _itemId:int;
      
      private var _cooldownDuration:Number;
      
      private var _infoCreationTime:Number;
      
      public function ItemCooldownDurationInfo(param1:int, param2:Number)
      {
         super();
         _itemId = param1;
         _cooldownDuration = param2;
         _infoCreationTime = new Date().getTime();
      }
      
      public function get itemId() : int
      {
         return _itemId;
      }
      
      public function get cooldownDuration() : Number
      {
         return _cooldownDuration;
      }
      
      public function get infoCreationTime() : Number
      {
         return _infoCreationTime;
      }
   }
}

