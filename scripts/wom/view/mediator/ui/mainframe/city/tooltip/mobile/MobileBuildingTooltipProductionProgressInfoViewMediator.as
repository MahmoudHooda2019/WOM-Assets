package wom.view.mediator.ui.mainframe.city.tooltip.mobile
{
   import flash.utils.getTimer;
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import peak.config.DocumentConfiguration;
   import wom.controller.event.GameTickEvent;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.job.BuildingRepairJob;
   import wom.model.game.job.BuildingUpgradeJob;
   import wom.model.game.league.LeagueManager;
   import wom.view.ui.mainframe.city.tooltip.mobile.MobileBuildingTooltipProductionProgressInfoView;
   
   public class MobileBuildingTooltipProductionProgressInfoViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileBuildingTooltipProductionProgressInfoView;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var documentConfiguration:DocumentConfiguration;
      
      [Inject]
      public var leagueManager:LeagueManager;
      
      public function MobileBuildingTooltipProductionProgressInfoViewMediator()
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
         var _loc1_:Number = NaN;
         var _loc6_:int = 0;
         var _loc3_:Number = NaN;
         var _loc2_:int = 0;
         var _loc4_:Number = NaN;
         if(view.buildingInfo.buildingTypeId == 15)
         {
            _loc5_ = totalResourcesOfCity();
            _loc1_ = calculateTotalHarvestableResources();
            view.updateWithStockPileData(city.totalResourceCapacity,Math.floor(_loc5_),Math.floor(_loc1_));
         }
         else if(view.buildingInfo.buildingTypeId == 10)
         {
            _loc6_ = view.buildingInfo.level - 1;
            _loc3_ = Number(view.buildingTypeDIO.buildingSpecificInfo[BuildingSpecificInfoType.GOLD_PRODUCTION_PERIODS_IN_HOURS_PER_LEVEL.id][_loc6_]);
            _loc2_ = int(view.buildingTypeDIO.buildingSpecificInfo[BuildingSpecificInfoType.GOLD_CAPACITY.id]);
            view.updateWithTaxData(_loc3_,_loc2_,city.goldCapacity != null ? city.goldCapacity.updatedTimer : getTimer(),city.goldCapacity != null ? city.goldCapacity.remainingTime : _loc2_ * _loc3_ * 60 * 60 * 1000,userInfo.serverSpeed);
         }
         else if(view.buildingTypeDIO.kind.id == 11)
         {
            _loc4_ = 1;
            _loc6_ = view.buildingInfo.level - 1;
            if(view.buildingInfo.buildingTypeId == 14)
            {
               if(documentConfiguration.hasParameter("iron_event_timer") && documentConfiguration.getParameter("iron_event_timer") > 0 && documentConfiguration.getParameter("iron_event_timer") < 7 * 86400000)
               {
                  _loc4_ = 3;
               }
               if(leagueManager.myLeague != null)
               {
                  _loc4_ *= 1 + leagueManager.myLeague.levelDIO.ironProductionBonusPercentage / 100;
               }
            }
            view.updateWithResourceProductionData(view.buildingTypeDIO.buildingSpecificInfo[BuildingSpecificInfoType.STORAGE_CAPACITIES_PER_LEVEL.id][_loc6_],view.buildingInfo.buildingSpecificInfo[BuildingSpecificInfoType.UNHARVESTED_RESOURCE.id],view.buildingTypeDIO.buildingSpecificInfo[BuildingSpecificInfoType.PRODUCTION_AMOUNTS_PER_HOUR_PER_LEVEL.id][_loc6_] * userInfo.productionBoostModifier * _loc4_);
         }
         view.progressBar.validate();
      }
      
      private function totalResourcesOfCity() : Number
      {
         var _loc2_:Number = 0;
         for each(var _loc1_ in city.resourceAmounts)
         {
            _loc2_ += _loc1_;
         }
         return _loc2_;
      }
      
      private function calculateTotalHarvestableResources() : Number
      {
         var _loc4_:Boolean = false;
         var _loc3_:Number = 0;
         for each(var _loc5_ in city.buildings)
         {
            if(_loc5_.buildingSpecificInfo[BuildingSpecificInfoType.UNHARVESTED_RESOURCE.id])
            {
               _loc4_ = true;
               for each(var _loc2_ in city.buildingRepairJobs)
               {
                  if(_loc5_.instanceId == _loc2_.instanceId)
                  {
                     _loc4_ = false;
                  }
               }
               for each(var _loc1_ in city.buildingUpgradeJobs)
               {
                  if(_loc5_.instanceId == _loc1_.instanceId)
                  {
                     _loc4_ = false;
                  }
               }
               if(_loc4_)
               {
                  _loc3_ += _loc5_.buildingSpecificInfo[BuildingSpecificInfoType.UNHARVESTED_RESOURCE.id];
               }
            }
         }
         return _loc3_;
      }
   }
}

