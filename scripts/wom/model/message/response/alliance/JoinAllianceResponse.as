package wom.model.message.response.alliance
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class JoinAllianceResponse extends AbstractIncomingMessage
   {
      
      private var _resultCode:int;
      
      private var _allianceId:Number;
      
      public function JoinAllianceResponse()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _resultCode = param1.resultCode;
         if(_resultCode == 0)
         {
            _allianceId = param1.allianceId;
         }
      }
      
      public function get resultCode() : int
      {
         return _resultCode;
      }
      
      public function get allianceId() : Number
      {
         return _allianceId;
      }
   }
}

