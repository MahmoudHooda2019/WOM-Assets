package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.game.beast.BeastInfo;
   
   public class BeastStatusChangedEventNotification extends AbstractIncomingMessage
   {
      
      private var _beastView:BeastInfo = null;
      
      private var _beastJobSchedulerView:Object = null;
      
      public function BeastStatusChangedEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         var _loc2_:Object = param1.beastView;
         if(_loc2_)
         {
            if(_loc2_.beastJobSchedulerView)
            {
               _beastJobSchedulerView = _loc2_.beastJobSchedulerView;
            }
            _beastView = new BeastInfo(-1,null,-1,_loc2_.id,_loc2_.currentHealthPoints,_loc2_.numberOfTrainingsLeftToNextLevel,_loc2_.level,_loc2_.starved,_loc2_.bonusStage);
         }
      }
      
      public function get beastView() : BeastInfo
      {
         return _beastView;
      }
      
      public function get beastJobSchedulerView() : Object
      {
         return _beastJobSchedulerView;
      }
   }
}

