package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class UnitLevelIncreasedEventNotification extends AbstractIncomingMessage
   {
      
      private var _unitTypeId:int;
      
      private var _level:int;
      
      public function UnitLevelIncreasedEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _unitTypeId = param1.unitTypeId;
         _level = param1.level;
      }
      
      public function get unitTypeId() : int
      {
         return _unitTypeId;
      }
      
      public function get level() : int
      {
         return _level;
      }
   }
}

