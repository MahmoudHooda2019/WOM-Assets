package wom.controller.command.unit
{
   import wom.controller.PCommand;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.ui.CancelActiveHiringEvent;
   import wom.model.component.CoreManager;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.hiring.HiringInfo;
   import wom.model.game.hiring.HiringPauseReasonType;
   import wom.model.game.hiring.HiringSlotView;
   import wom.model.game.job.UnitHireJob;
   import wom.model.game.resource.ResourceType;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.model.message.request.CancelActiveHiringRequest;
   
   public class CancelActiveHiringCommand extends PCommand
   {
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var event:CancelActiveHiringEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var coreManager:CoreManager;
      
      public function CancelActiveHiringCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc2_:HiringSlotView = null;
         var _loc5_:int = 0;
         var _loc1_:Number = NaN;
         var _loc4_:HiringInfo = city.hiringInfoDictionary[event.instanceId];
         var _loc3_:Boolean = false;
         if(_loc4_)
         {
            if(_loc4_.hiringQueue.hiringSlots.length <= 0)
            {
               _loc4_.activeHiring = null;
               _loc3_ = true;
            }
            else
            {
               _loc2_ = _loc4_.hiringQueue.hiringSlots[0];
               if(_loc2_.numberOfUnits > 1)
               {
                  _loc2_.numberOfUnits--;
                  _loc3_ = true;
               }
               else if(_loc2_.numberOfUnits == 1)
               {
                  _loc4_.hiringQueue.hiringSlots.splice(0,1);
                  _loc5_ = 0;
                  while(_loc5_ < _loc4_.hiringQueue.hiringSlots.length)
                  {
                     _loc4_.hiringQueue.hiringSlots[_loc5_].slotIndex = _loc5_ + 1;
                     _loc5_++;
                  }
                  _loc3_ = true;
               }
               if(_loc3_)
               {
                  _loc1_ = domainInfo.getUnit(_loc2_.unitId).hiringDurationPerLevelInSecs[(city.unitTypes[_loc2_.unitId] as UnitTypeInfo).currentLevel - 1] / userInfo.serverSpeed;
                  _loc4_.activeHiring = new UnitHireJob(_loc2_.unitId,0,_loc1_ * 1000 / userInfo.hiringSpeedModifier >> 0,event.instanceId,new Date().getTime(),_loc1_);
               }
            }
         }
         if(_loc3_)
         {
            if(_loc4_.isHiringPaused)
            {
               _loc4_.isHiringPaused = false;
               _loc4_.pauseReason = HiringPauseReasonType.UNPAUSED;
               _loc4_.lastHiredUnitId = -1;
            }
            var _loc6_:int = ResourceType.IRON.id;
            var _loc7_:Number = city.hiringSessionResourceAmounts[_loc6_] + getUnitHireCost(event.unitId);
            city.hiringSessionResourceAmounts[_loc6_] = _loc7_;
            dispatch(new ModelUpdateEvent("hiringInfoUpdated"));
            dispatch(new OutgoingMessageEvent("outgoingMessage",new CancelActiveHiringRequest(event.instanceId,event.validate)));
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

