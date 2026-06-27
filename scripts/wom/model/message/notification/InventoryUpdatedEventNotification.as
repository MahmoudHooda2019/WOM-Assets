package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.dto.DecorationTypeAmountDTO;
   import wom.model.dto.PartInfoDTO;
   import wom.model.dto.UnitTypeAmountBatchDTO;
   import wom.model.dto.UnitTypeAmountDTO;
   import wom.model.game.inventory.ResourceGiftDTO;
   
   public class InventoryUpdatedEventNotification extends AbstractIncomingMessage
   {
      
      private var _partAmounts:Vector.<PartInfoDTO>;
      
      private var _resourceGifts:Vector.<ResourceGiftDTO>;
      
      private var _unitGifts:Vector.<UnitTypeAmountBatchDTO>;
      
      private var _decorationGifts:Vector.<DecorationTypeAmountDTO>;
      
      public function InventoryUpdatedEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _partAmounts = new Vector.<PartInfoDTO>();
         for(var _loc4_ in param1.partAmounts)
         {
            _partAmounts.push(new PartInfoDTO(_loc4_,"",param1.partAmounts[_loc4_]));
         }
         _resourceGifts = new Vector.<ResourceGiftDTO>();
         for each(var _loc3_ in param1.resourceGifts)
         {
            _resourceGifts.push(new ResourceGiftDTO(_loc3_.info.id,_loc3_.info.resourceGiftAmountType,_loc3_.amount));
         }
         _unitGifts = new Vector.<UnitTypeAmountBatchDTO>();
         if("unitGifts" in param1 && param1.unitGifts != null)
         {
            for each(var _loc2_ in param1.unitGifts)
            {
               _unitGifts.push(new UnitTypeAmountBatchDTO(UnitTypeAmountDTO.deserialize(_loc2_.info),int(_loc2_.amount)));
            }
         }
         _decorationGifts = new Vector.<DecorationTypeAmountDTO>();
         if("decorationGifts" in param1 && param1.decorationGifts != null)
         {
            for each(var _loc5_ in param1.decorationGifts)
            {
               _decorationGifts.push(DecorationTypeAmountDTO.deserialize(_loc5_));
            }
         }
      }
      
      public function get partAmounts() : Vector.<PartInfoDTO>
      {
         return _partAmounts;
      }
      
      public function get resourceGifts() : Vector.<ResourceGiftDTO>
      {
         return _resourceGifts;
      }
      
      public function get unitGifts() : Vector.<UnitTypeAmountBatchDTO>
      {
         return _unitGifts;
      }
      
      public function get decorationGifts() : Vector.<DecorationTypeAmountDTO>
      {
         return _decorationGifts;
      }
   }
}

