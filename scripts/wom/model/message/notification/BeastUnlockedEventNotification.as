package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class BeastUnlockedEventNotification extends AbstractIncomingMessage
   {
      
      private var _beastId:int;
      
      public function BeastUnlockedEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _beastId = param1.beastId;
      }
      
      public function get beastId() : int
      {
         return _beastId;
      }
   }
}

