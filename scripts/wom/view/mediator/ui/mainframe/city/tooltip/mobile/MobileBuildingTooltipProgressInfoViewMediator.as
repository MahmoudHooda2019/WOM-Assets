package wom.view.mediator.ui.mainframe.city.tooltip.mobile
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import wom.controller.event.GameTickEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.hiring.HiringInfo;
   import wom.model.game.hiring.HiringQueueInfo;
   import wom.model.game.hiring.HiringSlotView;
   import wom.model.game.job.BuildingRepairJob;
   import wom.model.game.job.BuildingUpgradeJob;
   import wom.model.game.job.UnitHireJob;
   import wom.model.game.job.UnitTrainJob;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.view.ui.mainframe.city.tooltip.mobile.MobileBuildingTooltipProgressInfoView;
   
   public class MobileBuildingTooltipProgressInfoViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileBuildingTooltipProgressInfoView;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      public function MobileBuildingTooltipProgressInfoViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         injector.injectInto(view);
         updateView();
         addContextListener("tick",onTick);
      }
      
      private function onTick(param1:GameTickEvent) : void
      {
         updateView();
      }
      
      private function updateView() : void
      {
         var _loc5_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc8_:HiringQueueInfo = null;
         var _loc10_:Number = NaN;
         var _loc7_:int = 0;
         var _loc15_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc4_:UnitHireJob = null;
         var _loc11_:BuildingInfo = view.buildingInfo;
         var _loc14_:BuildingTypeDIO = domainInfo.getBuilding(_loc11_.buildingTypeId);
         var _loc16_:int = _loc11_.level == 0 ? 0 : _loc11_.level - 1;
         if(view.type == 7)
         {
            _loc12_ = 0;
            _loc10_ = 0;
            for each(var _loc6_ in city.hiringInfoDictionary)
            {
               if(_loc6_.activeHiring)
               {
                  _loc5_ = new Date().getTime() - _loc6_.activeHiring.jobCreationTime;
                  _loc2_ = _loc6_.activeHiring.remainingDuration - _loc5_;
                  if(_loc2_ > _loc10_)
                  {
                     _loc10_ = _loc2_;
                  }
               }
               _loc8_ = _loc6_.hiringQueue;
            }
            if(_loc8_)
            {
               for each(var _loc3_ in _loc8_.hiringSlots)
               {
                  _loc7_ = domainInfo.getUnit(_loc3_.unitId).hiringDurationPerLevelInSecs[(city.unitTypes[_loc3_.unitId] as UnitTypeInfo).currentLevel - 1];
                  _loc12_ += _loc3_.numberOfUnits * _loc7_ * 1000 / userInfo.hiringSpeedModifier / userInfo.serverSpeed;
               }
            }
            _loc12_ += _loc10_;
            _loc12_ = _loc12_ <= 0 ? 0 : _loc12_;
            view.updatePartial(_loc12_);
         }
         else if(view.type == 0)
         {
            for each(var _loc9_ in city.buildingRepairJobs)
            {
               if(_loc11_.instanceId == _loc9_.instanceId)
               {
                  _loc15_ = _loc14_.repairDurationsPerLevel[_loc16_] * 1000 / userInfo.serverSpeed;
                  _loc5_ = new Date().getTime() - _loc9_.jobCreationTime;
                  _loc2_ = _loc9_.durationRemaining - _loc5_;
                  _loc17_ = _loc15_ - _loc2_;
                  view.updateWithData(_loc17_,_loc15_,_loc2_);
                  break;
               }
            }
         }
         else if(view.type == 4)
         {
            for each(var _loc1_ in city.buildingUpgradeJobs)
            {
               if(_loc11_.instanceId == _loc1_.instanceId)
               {
                  _loc15_ = _loc1_.originalDuration;
                  _loc5_ = new Date().getTime() - _loc1_.jobCreationTime;
                  _loc2_ = _loc1_.durationRemaining - _loc5_;
                  _loc17_ = _loc15_ - _loc2_;
                  view.updateWithData(_loc17_,_loc15_,_loc2_);
                  break;
               }
            }
         }
         else if(view.type == 1)
         {
            if(city.activeRecruitJob)
            {
               _loc15_ = city.activeRecruitJob.originalDuration;
               _loc5_ = new Date().getTime() - city.activeRecruitJob.jobCreationTime;
               _loc2_ = city.activeRecruitJob.durationRemaining - _loc5_;
               _loc17_ = _loc15_ - _loc2_;
               view.updateWithData(_loc17_,_loc15_,_loc2_);
            }
         }
         else if(view.type == 2)
         {
            _loc4_ = city.hiringInfoDictionary[_loc11_.instanceId].activeHiring;
            if(_loc4_)
            {
               _loc15_ = domainInfo.getUnit(_loc4_.unitTypeId).hiringDurationPerLevelInSecs[city.unitTypes[_loc4_.unitTypeId].currentLevel - 1] * 1000 / userInfo.serverSpeed;
               _loc5_ = new Date().getTime() - _loc4_.jobCreationTime;
               _loc2_ = _loc4_.remainingDuration - _loc5_;
               _loc17_ = _loc15_ - _loc2_;
               view.updateWithData(_loc17_,_loc15_,_loc2_);
            }
         }
         else if(view.type == 3)
         {
            for each(var _loc13_ in city.unitTrainJobs)
            {
               if(_loc13_.instanceId == _loc11_.instanceId)
               {
                  _loc15_ = _loc13_.originalDuration;
                  _loc5_ = new Date().getTime() - _loc13_.jobCreationTime;
                  _loc2_ = _loc13_.durationRemaining - _loc5_;
                  _loc17_ = _loc15_ - _loc2_;
                  view.updateWithData(_loc17_,_loc15_,_loc2_);
                  break;
               }
            }
         }
      }
   }
}

