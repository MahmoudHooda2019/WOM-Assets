package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   import wom.model.game.defense.UnitBatchInfoDTO;
   
   public class SetAttackerNPCUnitsRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var _unitBatches:Vector.<UnitBatchInfoDTO>;
      
      public function SetAttackerNPCUnitsRequest(param1:Vector.<UnitBatchInfoDTO>)
      {
         super();
         _unitBatches = param1;
      }
      
      override public function serialize() : Object
      {
         var _loc2_:int = 0;
         var _loc1_:Array = new Array(_unitBatches.length);
         _loc2_ = 0;
         while(_loc2_ < _unitBatches.length)
         {
            _loc1_[_loc2_] = {
               "batch":_unitBatches[_loc2_].batch,
               "direction":_unitBatches[_loc2_].direction.id - 1
            };
            _loc2_++;
         }
         return {"unitBatches":_loc1_};
      }
   }
}

