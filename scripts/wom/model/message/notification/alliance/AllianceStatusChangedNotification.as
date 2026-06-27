package wom.model.message.notification.alliance
{
   import flash.utils.Dictionary;
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.game.alliance.AllianceSummaryInfo;
   import wom.model.message.util.AllianceDeserializeUtil;
   
   public class AllianceStatusChangedNotification extends AbstractIncomingMessage
   {
      
      private var _allianceSummary:AllianceSummaryInfo;
      
      private var _requestedAllianceIds:Dictionary;
      
      private var _allianceSig:String;
      
      public function AllianceStatusChangedNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _allianceSummary = AllianceDeserializeUtil.deserializeAllianceSummary(param1.alliance);
         _requestedAllianceIds = AllianceDeserializeUtil.deserializeRequestedAlliances(param1);
         _allianceSig = param1.asig;
      }
      
      public function get allianceSummary() : AllianceSummaryInfo
      {
         return _allianceSummary;
      }
      
      public function get requestedAllianceIds() : Dictionary
      {
         return _requestedAllianceIds;
      }
      
      public function get allianceSig() : String
      {
         return _allianceSig;
      }
   }
}

