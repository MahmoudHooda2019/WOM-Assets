package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class MaintenanceNotification extends AbstractIncomingMessage
   {
      
      private var _maintenanceTime:Number;
      
      private var _maintenanceMode:String;
      
      public function MaintenanceNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _maintenanceTime = param1.maintenanceTime;
         _maintenanceMode = param1.type;
      }
      
      public function get maintenanceTime() : Number
      {
         return _maintenanceTime;
      }
      
      public function get maintenanceMode() : String
      {
         return _maintenanceMode;
      }
   }
}

