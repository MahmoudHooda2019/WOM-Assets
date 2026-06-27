package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.game.Profile;
   
   public class WorkerStaffAssignedEventNotification extends AbstractIncomingMessage
   {
      
      private var _staffs:Vector.<Profile>;
      
      public function WorkerStaffAssignedEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _staffs = new Vector.<Profile>();
         for each(var _loc2_ in param1.staffs)
         {
            _staffs.push(new Profile(_loc2_.gid,_loc2_.pid,_loc2_.a));
         }
      }
      
      public function get staffs() : Vector.<Profile>
      {
         return _staffs;
      }
   }
}

