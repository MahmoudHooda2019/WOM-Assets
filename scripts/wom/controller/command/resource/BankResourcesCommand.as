package wom.controller.command.resource
{
   import flash.utils.Dictionary;
   import wom.controller.PCommand;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.resource.BankResourcesEvent;
   import wom.model.component.CoreManager;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.resource.ResourceType;
   import wom.model.message.request.BankAllResourcesRequest;
   import wom.model.message.request.BankResourcesRequest;
   
   public class BankResourcesCommand extends PCommand
   {
      
      [Inject]
      public var event:BankResourcesEvent;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var coreManager:CoreManager;
      
      public function BankResourcesCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc8_:* = undefined;
         var _loc2_:BuildingTypeDIO = null;
         var _loc5_:ResourceType = null;
         var _loc7_:Number = NaN;
         var _loc3_:int = 0;
         super.execute();
         var _loc6_:int = city.totalResourceCapacity >> 2;
         var _loc1_:Dictionary = new Dictionary();
         for each(var _loc9_ in ResourceType.resourceTypes)
         {
            _loc1_[_loc9_.id] = _loc6_ - city.resourceAmounts[_loc9_.id];
         }
         if(event.type == "bankAllResources")
         {
            _loc8_ = new Vector.<BuildingInfo>();
            for each(var _loc4_ in city.buildings)
            {
               if(_loc4_.buildingTypeId == 14 || _loc4_.buildingTypeId == 11 || _loc4_.buildingTypeId == 13 || _loc4_.buildingTypeId == 12)
               {
                  _loc8_.push(_loc4_);
               }
            }
            _loc8_.sort(sortByInstanceId);
            for each(_loc4_ in _loc8_)
            {
               _loc2_ = domainInfo.getBuilding(_loc4_.buildingTypeId);
               if(BuildingSpecificInfoType.PRODUCED_RESOURCE.id in _loc2_.buildingSpecificInfo)
               {
                  _loc5_ = _loc2_.buildingSpecificInfo[BuildingSpecificInfoType.PRODUCED_RESOURCE.id];
                  if(_loc1_[_loc5_.id] > 0)
                  {
                     _loc7_ = Number(_loc4_.buildingSpecificInfo[BuildingSpecificInfoType.UNHARVESTED_RESOURCE.id]);
                     _loc3_ = 0;
                     if(_loc1_[_loc5_.id] < _loc7_)
                     {
                        _loc3_ = int(_loc1_[_loc5_.id]);
                        _loc1_[_loc5_.id] = 0;
                     }
                     else
                     {
                        _loc3_ = _loc7_;
                        _loc1_[_loc5_.id] -= _loc3_;
                     }
                     if(_loc3_ > 0)
                     {
                        var _loc13_:* = BuildingSpecificInfoType.UNHARVESTED_RESOURCE.id;
                        var _loc12_:* = _loc4_.buildingSpecificInfo[_loc13_] - _loc3_;
                        _loc4_.buildingSpecificInfo[_loc13_] = _loc12_;
                        coreManager.harvest(_loc4_.instanceId,_loc3_);
                        trace("Harvest : " + _loc4_.instanceId + " => " + _loc3_);
                     }
                  }
                  trace("Remaining Resource : " + _loc4_.instanceId + " => " + _loc4_.buildingSpecificInfo[BuildingSpecificInfoType.UNHARVESTED_RESOURCE.id]);
               }
            }
            dispatch(new OutgoingMessageEvent("outgoingMessage",new BankAllResourcesRequest()));
         }
         else
         {
            for each(_loc4_ in city.buildings)
            {
               if(_loc4_.instanceId == event.instanceId)
               {
                  _loc2_ = domainInfo.getBuilding(_loc4_.buildingTypeId);
                  _loc5_ = _loc2_.buildingSpecificInfo[BuildingSpecificInfoType.PRODUCED_RESOURCE.id];
                  _loc7_ = Number(_loc4_.buildingSpecificInfo[BuildingSpecificInfoType.UNHARVESTED_RESOURCE.id]);
                  _loc3_ = 0;
                  if(_loc1_[_loc5_.id] < _loc7_)
                  {
                     _loc3_ = int(_loc1_[_loc5_.id]);
                     _loc1_[_loc5_.id] = 0;
                  }
                  else
                  {
                     _loc3_ = _loc7_;
                     _loc1_[_loc5_.id] -= _loc3_;
                  }
                  if(_loc3_ > 0)
                  {
                     _loc12_ = BuildingSpecificInfoType.UNHARVESTED_RESOURCE.id;
                     _loc13_ = _loc4_.buildingSpecificInfo[_loc12_] - _loc3_;
                     _loc4_.buildingSpecificInfo[_loc12_] = _loc13_;
                     coreManager.harvest(_loc4_.instanceId,_loc3_);
                     trace("Harvest : " + _loc4_.instanceId + " => " + _loc3_);
                  }
               }
            }
            dispatch(new OutgoingMessageEvent("outgoingMessage",new BankResourcesRequest(event.instanceId)));
         }
         coreManager.manageResourceProducerAnimations();
      }
      
      private function sortByInstanceId(param1:BuildingInfo, param2:BuildingInfo) : int
      {
         if(param1.instanceId > param2.instanceId)
         {
            return 1;
         }
         if(param1.instanceId < param2.instanceId)
         {
            return -1;
         }
         return 0;
      }
   }
}

