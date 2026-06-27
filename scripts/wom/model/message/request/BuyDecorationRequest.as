package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class BuyDecorationRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var _decorationTypeId:int;
      
      private var _x:int;
      
      private var _y:int;
      
      private var _fromStash:Boolean;
      
      private var _subType:String;
      
      public function BuyDecorationRequest(param1:int, param2:int, param3:int, param4:String = null, param5:Boolean = false)
      {
         super();
         _decorationTypeId = param1;
         _x = param2;
         _y = param3;
         _fromStash = param5;
         _subType = param4;
      }
      
      override public function serialize() : Object
      {
         return {
            "decorationTypeId":_decorationTypeId,
            "position":{
               "x":_x,
               "y":_y
            },
            "subType":_subType,
            "fromStash":_fromStash
         };
      }
   }
}

