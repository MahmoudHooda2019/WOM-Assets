package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class TournamentEndedEventNotification extends AbstractIncomingMessage
   {
      
      private var _allianceRanking:int;
      
      private var _goldReward:int;
      
      private var _endTime:int;
      
      public function TournamentEndedEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _allianceRanking = param1.allianceRanking;
         _goldReward = param1.goldReward;
         _endTime = param1.endTime;
      }
      
      public function get allianceRanking() : int
      {
         return _allianceRanking;
      }
      
      public function get goldReward() : int
      {
         return _goldReward;
      }
      
      public function get endTime() : int
      {
         return _endTime;
      }
   }
}

