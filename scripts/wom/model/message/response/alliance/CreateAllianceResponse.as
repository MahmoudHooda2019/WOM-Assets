package wom.model.message.response.alliance
{
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.game.alliance.AllianceSummaryInfo;
   import wom.model.message.util.AllianceDeserializeUtil;
   
   public class CreateAllianceResponse extends AbstractIncomingMessage
   {
      
      private var _resultCode:int;
      
      private var _allianceSummary:AllianceSummaryInfo;
      
      private var _allianceSig:String;
      
      public function CreateAllianceResponse()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _resultCode = param1.resultCode;
         if(_resultCode == 0 && "alliance" in param1)
         {
            _allianceSummary = AllianceDeserializeUtil.deserializeAllianceSummary(param1.alliance);
            _allianceSig = param1.asig;
         }
      }
      
      public function get resultCode() : int
      {
         return _resultCode;
      }
      
      public function get allianceSummary() : AllianceSummaryInfo
      {
         return _allianceSummary;
      }
      
      public function get allianceSig() : String
      {
         return _allianceSig;
      }
   }
}

