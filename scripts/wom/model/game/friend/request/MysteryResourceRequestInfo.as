package wom.model.game.friend.request
{
   import wom.model.domain.domaininfoobject.PartTypeDIO;
   import wom.model.game.inventory.ResourceQuantityType;
   
   public class MysteryResourceRequestInfo extends MysteryGiftRequestInfo
   {
      
      private var _partDIO:PartTypeDIO;
      
      private var _bonusQuantity:ResourceQuantityType;
      
      public function MysteryResourceRequestInfo(param1:Number, param2:String, param3:PartTypeDIO, param4:ResourceQuantityType)
      {
         super(param1,15,param2);
         _partDIO = param3;
         _bonusQuantity = param4;
      }
      
      public function get partDIO() : PartTypeDIO
      {
         return _partDIO;
      }
      
      public function get bonusQuantity() : ResourceQuantityType
      {
         return _bonusQuantity;
      }
   }
}

