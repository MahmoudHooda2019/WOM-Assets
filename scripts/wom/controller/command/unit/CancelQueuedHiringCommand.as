package wom.controller.command.unit
{
   import wom.controller.PCommand;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.ui.CancelQueuedHiringEvent;
   import wom.model.component.CoreManager;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.building.BuildingInfoUtil;
   import wom.model.game.hiring.HiringInfo;
   import wom.model.game.hiring.HiringSlotView;
   import wom.model.game.resource.ResourceType;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.model.message.request.RemoveQueuedHiresRequest;
   
   public class CancelQueuedHiringCommand extends PCommand
   {
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var event:CancelQueuedHiringEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var coreManager:CoreManager;
      
      private var centralHiring:Boolean;
      
      public function CancelQueuedHiringCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc5_:HiringInfo = null;
         var _loc6_:int = 0;
         var _loc1_:HiringSlotView = null;
         var _loc2_:int = 0;
         centralHiring = BuildingInfoUtil.getBuildingByBuildingInstanceId(city.buildings,event.instanceId).buildingTypeId == 21;
         if(centralHiring)
         {
            var _loc8_:int = 0;
            var _loc7_:* = city.hiringInfoDictionary;
            for(var _loc4_ in _loc7_)
            {
               _loc5_ = city.hiringInfoDictionary[_loc4_];
            }
         }
         else
         {
            _loc5_ = city.hiringInfoDictionary[event.instanceId];
         }
         var _loc3_:Boolean = false;
         _loc6_ = 0;
         while(_loc6_ < _loc5_.hiringQueue.hiringSlots.length)
         {
            _loc1_ = _loc5_.hiringQueue.hiringSlots[_loc6_];
            if(_loc1_.slotIndex == event.slotIndex)
            {
               if(_loc1_.unitId == event.unitId)
               {
                  if(_loc1_.numberOfUnits > 1)
                  {
                     _loc1_.numberOfUnits--;
                     _loc3_ = true;
                  }
                  else if(_loc1_.numberOfUnits == 1)
                  {
                     _loc5_.hiringQueue.hiringSlots.splice(_loc6_,1);
                     _loc3_ = true;
                     _loc2_ = 0;
                     while(_loc2_ < _loc5_.hiringQueue.hiringSlots.length)
                     {
                        _loc5_.hiringQueue.hiringSlots[_loc2_].slotIndex = _loc2_ + 1;
                        _loc2_++;
                     }
                  }
               }
            }
            _loc6_++;
         }
         if(_loc3_)
         {
            _loc8_ = ResourceType.IRON.id;
            _loc7_ = city.hiringSessionResourceAmounts[_loc8_] + getUnitHireCost(event.unitId);
            city.hiringSessionResourceAmounts[_loc8_] = _loc7_;
            dispatch(new ModelUpdateEvent("hiringInfoUpdated"));
            dispatch(new OutgoingMessageEvent("outgoingMessage",new RemoveQueuedHiresRequest(event.instanceId,event.slotIndex,1,false)));
         }
      }
      
      private function getUnitHireCost(param1:int) : int
      {
         var _loc4_:int = 0;
         var _loc3_:Number = NaN;
         var _loc5_:UnitTypeInfo = city.unitTypes[param1];
         var _loc2_:UnitTypeDIO = domainInfo.getUnit(param1);
         if(_loc5_.recruited)
         {
            _loc4_ = _loc5_.currentLevel - 1;
            return _loc2_.hiringCostsPerLevel[_loc4_][0].resourceAmount;
         }
         return -1;
      }
   }
}

