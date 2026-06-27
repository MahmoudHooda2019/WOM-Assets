package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class BattlePointsChangedEventNotification extends AbstractIncomingMessage
   {
      
      private var _battlePoints:int;
      
      public function BattlePointsChangedEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _battlePoints = param1.battlePoints;
      }
      
      public function get battlePoints() : int
      {
         return _battlePoints;
      }
   }
}

