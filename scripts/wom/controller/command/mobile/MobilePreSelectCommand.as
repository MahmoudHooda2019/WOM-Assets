package wom.controller.command.mobile
{
   import flash.utils.getTimer;
   import org.robotlegs.mvcs.StarlingCommand;
   import peak.resource.SoundPlayer;
   import wom.controller.command.city.ConstructableActionCommandHelper;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.mobile.MobilePreSelectEvent;
   import wom.controller.event.resource.BankResourcesEvent;
   import wom.model.component.enum.CanvasMode;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.dto.PartInfoDTO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.WomGameRootHolder;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.inventory.InventoryItemCategory;
   import wom.model.game.inventory.InventoryItemDTO;
   import wom.model.game.job.BuildingRepairJob;
   import wom.model.game.job.BuildingUpgradeJob;
   import wom.model.game.job.UnitTrainJob;
   import wom.model.game.resource.ResourceType;
   import wom.model.message.request.ActivateBuildingRequest;
   import wom.model.message.request.BuyItemRequest;
   
   public class MobilePreSelectCommand extends StarlingCommand
   {
      
      public static const RESOURCE_PRODUCER_ONE_TAP_BARRIERS:Array = [23,54,105,198,344,594,1044,1665,2482,3528,6048,10584,15624];
      
      [Inject]
      public var event:MobilePreSelectEvent;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var gameRootHolder:WomGameRootHolder;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var soundPlayer:SoundPlayer;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function MobilePreSelectCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc20_:int = 0;
         var _loc11_:int = 0;
         var _loc8_:* = undefined;
         var _loc6_:Boolean = false;
         var _loc2_:PartInfoDTO = null;
         var _loc3_:Boolean = false;
         var _loc9_:int = 0;
         var _loc12_:Boolean = false;
         var _loc7_:Boolean = false;
         var _loc14_:* = null;
         super.execute();
         var _loc19_:int = getTimer();
         var _loc15_:BuildingInfo = ConstructableActionCommandHelper.findBuildingInfo(event.instanceId,city);
         if(_loc15_ == null)
         {
            if(gameRootHolder.gameRoot.canvasMode == CanvasMode.NORMAL)
            {
               gameRootHolder.gameRoot.mobileSelect(event.instanceId);
            }
            return;
         }
         var _loc17_:BuildingTypeDIO = domainInfo.getBuilding(_loc15_.buildingTypeId);
         var _loc4_:Number = -1;
         var _loc18_:Boolean = false;
         for each(var _loc5_ in city.buildingRepairJobs)
         {
            if(_loc5_.instanceId == _loc15_.instanceId)
            {
               _loc18_ = true;
               _loc4_ = _loc5_.durationRemaining - (new Date().getTime() - _loc5_.jobCreationTime);
            }
         }
         if(!_loc18_)
         {
            for each(var _loc1_ in city.buildingUpgradeJobs)
            {
               if(_loc1_.instanceId == _loc15_.instanceId)
               {
                  _loc18_ = true;
                  _loc4_ = _loc1_.durationRemaining - (new Date().getTime() - _loc1_.jobCreationTime);
               }
            }
         }
         if(!_loc18_ && _loc15_.buildingTypeId == 17 && city.activeRecruitJob)
         {
            _loc18_ = true;
            _loc4_ = city.activeRecruitJob.durationRemaining - (new Date().getTime() - city.activeRecruitJob.jobCreationTime);
         }
         if(!_loc18_ && _loc15_.buildingTypeId == 18)
         {
            for each(var _loc16_ in city.unitTrainJobs)
            {
               _loc18_ = true;
               _loc4_ = _loc16_.durationRemaining - (new Date().getTime() - _loc16_.jobCreationTime);
            }
         }
         if(_loc18_)
         {
            if(_loc4_ <= 300000)
            {
               dispatch(new OutgoingMessageEvent("outgoingMessage",new BuyItemRequest(2003,_loc15_.instanceId)));
               return;
            }
         }
         else if(_loc15_.incomplete)
         {
            _loc20_ = 0;
            _loc11_ = 0;
            while(_loc11_ < city.buildings.length)
            {
               if(city.buildings[_loc11_].buildingTypeId == _loc15_.buildingTypeId)
               {
                  if(!city.buildings[_loc11_].incomplete)
                  {
                     _loc20_++;
                  }
               }
               _loc11_++;
            }
            _loc8_ = _loc17_.buildingSpecificInfo[BuildingSpecificInfoType.PART_REQUIREMENTS_PER_LEVEL.id][_loc20_];
            _loc6_ = true;
            _loc11_ = 0;
            while(_loc11_ < _loc8_.length)
            {
               _loc2_ = _loc8_[_loc11_];
               _loc3_ = false;
               for each(var _loc13_ in userInfo.items)
               {
                  if(_loc13_.category == InventoryItemCategory.PARTS && _loc13_.id == _loc2_.id)
                  {
                     _loc3_ = true;
                     if(_loc6_)
                     {
                        _loc6_ = _loc2_.amount <= _loc13_.amount;
                     }
                  }
               }
               if(!_loc3_)
               {
                  _loc6_ = false;
                  break;
               }
               _loc11_++;
            }
            if(_loc6_)
            {
               dispatch(new OutgoingMessageEvent("outgoingMessage",new ActivateBuildingRequest(_loc15_.instanceId)));
               return;
            }
         }
         else if(_loc15_.buildingTypeId == 10)
         {
            _loc9_ = ConstructableActionCommandHelper.calculateUnharvestedGoldAmount(_loc19_,_loc15_,_loc17_,userInfo,city);
            if(_loc9_ > 0)
            {
               ConstructableActionCommandHelper.harvestGold(_loc9_,_loc15_.instanceId,soundPlayer,gameRootHolder,eventDispatcher);
               return;
            }
         }
         else if(_loc17_.kind.id == 11)
         {
            if(!userInfo.mandatoryTutorialCompleted && _loc15_.buildingSpecificInfo[BuildingSpecificInfoType.UNHARVESTED_RESOURCE.id] > 0 || city.resourceAmounts[(_loc17_.buildingSpecificInfo[BuildingSpecificInfoType.PRODUCED_RESOURCE.id] as ResourceType).id] < city.totalResourceCapacity >> 2 && _loc15_.buildingSpecificInfo[BuildingSpecificInfoType.UNHARVESTED_RESOURCE.id] >= RESOURCE_PRODUCER_ONE_TAP_BARRIERS[_loc15_.level - 1])
            {
               dispatch(new BankResourcesEvent("bankInstanceResources",_loc15_.instanceId));
               if(userInfo.mandatoryTutorialCompleted || !userInfo.tutorialsInfo.additionalInfo.autoSelectCommand)
               {
                  return;
               }
            }
         }
         else if(_loc15_.buildingTypeId == 15)
         {
            _loc12_ = false;
            _loc7_ = true;
            for each(var _loc10_ in ResourceType.resourceTypes)
            {
               if(_loc7_)
               {
                  _loc7_ = city.resourceAmounts[_loc10_.id] >= city.totalResourceCapacity >> 2;
               }
               if(city.resourceAmounts[_loc10_.id] < city.totalResourceCapacity >> 2)
               {
                  for each(_loc14_ in city.buildings)
                  {
                     _loc17_ = domainInfo.getBuilding(_loc14_.buildingTypeId);
                     if(_loc17_.kind.id == 11 && (_loc17_.buildingSpecificInfo[BuildingSpecificInfoType.PRODUCED_RESOURCE.id] as ResourceType).id == _loc10_.id && _loc14_.buildingSpecificInfo[BuildingSpecificInfoType.UNHARVESTED_RESOURCE.id] >= 1)
                     {
                        _loc12_ = true;
                        break;
                     }
                  }
               }
               if(_loc12_)
               {
                  break;
               }
            }
            if(_loc12_)
            {
               soundPlayer.playSfxById("CollectResource");
            }
            if(!_loc7_)
            {
               dispatch(new BankResourcesEvent("bankAllResources"));
            }
         }
         if(gameRootHolder.gameRoot.canvasMode == CanvasMode.NORMAL)
         {
            gameRootHolder.gameRoot.mobileSelect(_loc15_.instanceId);
         }
      }
   }
}

