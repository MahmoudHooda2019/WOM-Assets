package wom.model.message.notification.league
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class UserIsPlacedIntoALeagueNotification extends AbstractIncomingMessage
   {
      
      private var _leagueLevelId:Number;
      
      private var _firstTime:Boolean;
      
      private var _remainingDuration:Number;
      
      private var _rpReward:Boolean;
      
      private var _ratio:Number;
      
      public function UserIsPlacedIntoALeagueNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _leagueLevelId = param1.leagueLevelId;
         _firstTime = param1.firstTime;
         _remainingDuration = param1.remainingDuration;
         if("leagueRewardType" in param1 && param1.leagueRewardType != null)
         {
            _rpReward = param1.leagueRewardType != "gold";
         }
         _ratio = 1;
         if("leagueRewardRatio" in param1 && param1.leagueRewardRatio != null)
         {
            _ratio = param1.leagueRewardRatio;
         }
      }
      
      public function get leagueLevelId() : Number
      {
         return _leagueLevelId;
      }
      
      public function get firstTime() : Boolean
      {
         return _firstTime;
      }
      
      public function get remainingDuration() : Number
      {
         return _remainingDuration;
      }
      
      public function get rpReward() : Boolean
      {
         return _rpReward;
      }
      
      public function get ratio() : Number
      {
         return _ratio;
      }
   }
}

