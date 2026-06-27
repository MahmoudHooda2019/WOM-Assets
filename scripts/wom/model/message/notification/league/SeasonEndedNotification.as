package wom.model.message.notification.league
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class SeasonEndedNotification extends AbstractIncomingMessage
   {
      
      private var _leagueLevelId:Number;
      
      private var _seasonStartTime:Number;
      
      private var _seasonEndTime:Number;
      
      private var _position:int;
      
      private var _reward:Number = NaN;
      
      private var _rpReward:Boolean;
      
      private var _ratio:Number;
      
      public function SeasonEndedNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _leagueLevelId = param1.leagueLevelId;
         _seasonStartTime = param1.seasonStartTime;
         _seasonEndTime = param1.seasonEndTime;
         _position = param1.position;
         if("reward" in param1 && param1.reward != null)
         {
            _reward = param1.reward;
         }
         _rpReward = true;
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
      
      public function get seasonStartTime() : Number
      {
         return _seasonStartTime;
      }
      
      public function get seasonEndTime() : Number
      {
         return _seasonEndTime;
      }
      
      public function get position() : int
      {
         return _position;
      }
      
      public function get reward() : Number
      {
         return _reward;
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

