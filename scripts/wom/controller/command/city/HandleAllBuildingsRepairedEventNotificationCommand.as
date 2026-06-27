package wom.controller.command.city
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.component.CoreManager;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.defense.NPCAttackStatus;
   
   public class HandleAllBuildingsRepairedEventNotificationCommand extends PCommand
   {
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var coreManager:CoreManager;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      public function HandleAllBuildingsRepairedEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc3_:BuildingTypeDIO = null;
         var _loc2_:Number = NaN;
         var _loc5_:int = 0;
         var _loc4_:Number = NaN;
         for each(var _loc1_ in city.buildings)
         {
            _loc3_ = domainInfo.getBuilding(_loc1_.buildingTypeId);
            _loc2_ = _loc1_.healthPoint;
            _loc5_ = _loc1_.level == 0 ? 0 : _loc1_.level - 1;
            _loc4_ = _loc3_.healthPointsPerLevel[_loc5_];
            if(_loc2_ != _loc4_ && !_loc1_.isTrap)
            {
               _loc1_.healthPoint = _loc4_;
               coreManager.notifyHealthPointChangeOfABuilding(_loc1_.instanceId);
               coreManager.manageBuildingBoundaryEnvironment(_loc1_.instanceId);
            }
         }
         coreManager.manageIncompleteBuildingIndicators();
         coreManager.manageResourceProducerAnimations();
         if(userInfo.npcAttackStatus == NPCAttackStatus.POSTPONED_FROM_UNHEALTHY_BUILDING)
         {
            userInfo.npcAttackStatus = NPCAttackStatus.WAIT;
            dispatch(new ModelUpdateEvent("npcAttackStatusUpdated"));
         }
      }
   }
}

