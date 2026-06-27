package wom.model.message.response
{
   import wom.model.dto.UnitTypeAmountDTO;
   
   public class HireUnitResponse extends DefaultResponse
   {
      
      private var _instanceId:int;
      
      private var _unitAmounts:Vector.<UnitTypeAmountDTO>;
      
      public function HireUnitResponse()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         var _loc2_:int = 0;
         super.deserialize(param1);
         _instanceId = "instanceId" in param1 ? param1.instanceId : -1;
         _unitAmounts = new Vector.<UnitTypeAmountDTO>();
         if("unitAmounts" in param1 && resultCode == 0)
         {
            _loc2_ = 0;
            while(_loc2_ < param1.unitAmounts.length)
            {
               _unitAmounts.push(new UnitTypeAmountDTO(param1.unitAmounts[_loc2_].id,param1.unitAmounts[_loc2_].amount));
               _loc2_++;
            }
         }
      }
      
      public function get instanceId() : int
      {
         return _instanceId;
      }
      
      public function get unitAmounts() : Vector.<UnitTypeAmountDTO>
      {
         return _unitAmounts;
      }
   }
}

