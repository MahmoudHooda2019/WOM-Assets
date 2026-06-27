package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class BuildingHelpedNotification extends AbstractIncomingMessage
   {
      
      private var _helperId:String;
      
      private var _instanceId:int;
      
      public function BuildingHelpedNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _helperId = param1.helperId;
         _instanceId = param1.instanceId;
      }
      
      public function get helperId() : String
      {
         return _helperId;
      }
      
      public function get instanceId() : int
      {
         return _instanceId;
      }
   }
}

