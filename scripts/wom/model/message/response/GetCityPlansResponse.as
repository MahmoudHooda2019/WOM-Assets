package wom.model.message.response
{
   import flash.utils.Dictionary;
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.dto.CityPlanInfoDTO;
   
   public class GetCityPlansResponse extends AbstractIncomingMessage
   {
      
      private var _resultCode:int;
      
      private var _resultMessage:String;
      
      private var _cityPlans:Dictionary;
      
      private var _maxSlots:int;
      
      public function GetCityPlansResponse()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _resultCode = param1.resultCode;
         _resultMessage = param1.resultMessage;
         if(_resultCode == 0)
         {
            _cityPlans = new Dictionary();
            for each(var _loc2_ in param1.plans)
            {
               _cityPlans[_loc2_.slot] = new CityPlanInfoDTO(_loc2_.slot,_loc2_.name);
            }
            _maxSlots = param1.maxSlots;
         }
      }
      
      public function get cityPlans() : Dictionary
      {
         return _cityPlans;
      }
      
      public function get resultCode() : int
      {
         return _resultCode;
      }
      
      public function get resultMessage() : String
      {
         return _resultMessage;
      }
      
      public function get maxSlots() : int
      {
         return _maxSlots;
      }
   }
}

