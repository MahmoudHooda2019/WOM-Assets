package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class SetCityPlanSlotsRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      public var _slots:int;
      
      public var _costType:int;
      
      public function SetCityPlanSlotsRequest(param1:int, param2:int)
      {
         super();
         _slots = param1;
         _costType = param2;
      }
      
      override public function serialize() : Object
      {
         return {
            "slots":_slots,
            "costType":_costType
         };
      }
   }
}

