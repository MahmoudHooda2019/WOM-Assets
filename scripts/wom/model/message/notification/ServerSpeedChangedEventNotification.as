package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class ServerSpeedChangedEventNotification extends AbstractIncomingMessage
   {
      
      private var _serverSpeed:int;
      
      public function ServerSpeedChangedEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _serverSpeed = param1._erverSpeed;
      }
      
      public function get serverSpeed() : int
      {
         return _serverSpeed;
      }
   }
}

