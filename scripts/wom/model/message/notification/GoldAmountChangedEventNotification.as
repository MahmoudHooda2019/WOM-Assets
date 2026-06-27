package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class GoldAmountChangedEventNotification extends AbstractIncomingMessage
   {
      
      private var _numberOfGolds:int;
      
      public function GoldAmountChangedEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _numberOfGolds = param1.numberOfGolds;
      }
      
      public function get numberOfGolds() : int
      {
         return _numberOfGolds;
      }
   }
}

