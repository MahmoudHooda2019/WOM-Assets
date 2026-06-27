package wom.controller.command.city
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.component.CoreManager;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.dto.job.BuildingRepairJobDTO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.job.BuildingRepairJob;
   import wom.model.message.notification.BuildingRepairJobScheduledEventNotification;
   
   public class HandleBuildingRepairJobScheduledEventNotificationCommand extends PCommand
   {
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var coreManager:CoreManager;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function HandleBuildingRepairJobScheduledEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc11_:int = 0;
         var _loc5_:BuildingTypeDIO = null;
         var _loc6_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc7_:BuildingRepairJob = null;
         var _loc12_:int = 0;
         var _loc9_:BuildingRepairJobScheduledEventNotification = messageReceivedEvent.message as BuildingRepairJobScheduledEventNotification;
         var _loc1_:Vector.<BuildingRepairJob> = city.buildingRepairJobs;
         var _loc10_:Boolean = false;
         var _loc4_:BuildingRepairJobDTO = _loc9_.buildingRepairJob;
         for each(var _loc3_ in city.buildings)
         {
            if(_loc3_.instanceId == _loc4_.instanceId)
            {
               _loc11_ = _loc3_.level == 0 ? 0 : _loc3_.level - 1;
               _loc5_ = domainInfo.getBuilding(_loc3_.buildingTypeId);
               _loc6_ = _loc5_.healthPointsPerLevel[_loc11_];
               _loc8_ = _loc5_.repairDurationsPerLevel[_loc11_];
               _loc2_ = _loc8_ * 1000 / userInfo.serverSpeed;
               _loc3_.healthPoint = (_loc2_ - _loc9_.buildingRepairJob.durationRemaining) * _loc6_ / _loc2_ << 0;
               break;
            }
         }
         _loc12_ = 0;
         while(_loc12_ < _loc1_.length)
         {
            if(_loc1_[_loc12_].instanceId == _loc4_.instanceId)
            {
               _loc7_ = _loc1_[_loc12_] as BuildingRepairJob;
               _loc7_.durationRemaining = _loc4_.durationRemaining;
               _loc7_.jobCreationTime = new Date().getTime();
               _loc10_ = true;
               break;
            }
            _loc12_++;
         }
         if(!_loc10_)
         {
            _loc7_ = new BuildingRepairJob(_loc4_.instanceId,_loc4_.durationRemaining,new Date().getTime());
            _loc1_.push(_loc7_);
            coreManager.startRepair(_loc4_.instanceId,_loc7_);
         }
         dispatch(new ModelUpdateEvent("repairJobsUpdated"));
      }
   }
}

