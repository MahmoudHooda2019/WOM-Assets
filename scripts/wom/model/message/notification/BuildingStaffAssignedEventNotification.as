package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.game.Profile;
   
   public class BuildingStaffAssignedEventNotification extends AbstractIncomingMessage
   {
      
      private var _staffs:Vector.<Profile>;
      
      private var _instanceId:int;
      
      public function BuildingStaffAssignedEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _staffs = new Vector.<Profile>();
         for each(var _loc2_ in param1.staffsById)
         {
            _staffs.push(new Profile(_loc2_.gid,_loc2_.pid,_loc2_.a));
         }
         _instanceId = param1.instanceId;
      }
      
      public function get staffs() : Vector.<Profile>
      {
         return _staffs;
      }
      
      public function get instanceId() : int
      {
         return _instanceId;
      }
   }
}

