package wom.model.message.response.alliance
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class KickAllianceMemberResponse extends AbstractIncomingMessage
   {
      
      private var _resultCode:int;
      
      public function KickAllianceMemberResponse()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _resultCode = param1.resultCode;
      }
      
      public function get resultCode() : int
      {
         return _resultCode;
      }
   }
}

