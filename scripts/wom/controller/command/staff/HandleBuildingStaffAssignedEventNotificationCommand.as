package wom.controller.command.staff
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.staff.GetStaffsEvent;
   import wom.model.component.CoreManager;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.staff.StaffInfo;
   import wom.model.message.notification.BuildingStaffAssignedEventNotification;
   
   public class HandleBuildingStaffAssignedEventNotificationCommand extends PCommand
   {
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var coreManager:CoreManager;
      
      public function HandleBuildingStaffAssignedEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc3_:int = 0;
         var _loc2_:BuildingStaffAssignedEventNotification = messageReceivedEvent.message as BuildingStaffAssignedEventNotification;
         for each(var _loc1_ in city.buildings)
         {
            if(_loc1_.instanceId == _loc2_.instanceId)
            {
               if(_loc1_.staffs == null)
               {
                  _loc1_.staffs = new Vector.<StaffInfo>();
               }
               _loc1_.staffs = new Vector.<StaffInfo>();
               _loc3_ = 0;
               while(_loc3_ < _loc2_.staffs.length)
               {
                  _loc1_.staffs.push(new StaffInfo(_loc3_ + 1,_loc2_.staffs[_loc3_]));
                  _loc3_++;
               }
               dispatch(new GetStaffsEvent("getStaffs"));
               break;
            }
         }
         coreManager.manageIncompleteBuildingIndicators();
      }
   }
}

