package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class MobileApplicationStatusChangedRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      public static const ACTIVATED:int = 1;
      
      public static const DEACTIVATED:int = 0;
      
      private var _status:int;
      
      private var _duration:int;
      
      public function MobileApplicationStatusChangedRequest(param1:int, param2:int = 0)
      {
         super();
         this._status = param1;
         _duration = param2;
      }
      
      override public function serialize() : Object
      {
         if(_status == 1)
         {
            return {"st":_status};
         }
         return {
            "st":_status,
            "duration":_duration
         };
      }
   }
}

