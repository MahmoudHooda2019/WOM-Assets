package wom.controller.command.model
{
   import wom.controller.PCommand;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.model.GenerateUnitTypeInfosEvent;
   import wom.model.component.CoreManager;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.PrerequisiteDIO;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.job.UnitTrainJob;
   import wom.model.game.unit.UnitTypeInfo;
   
   public class GenerateUnitTypeInfosCommand extends PCommand
   {
      
      [Inject]
      public var event:GenerateUnitTypeInfosEvent;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var coreManager:CoreManager;
      
      public function GenerateUnitTypeInfosCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc2_:UnitTypeDIO = null;
         var _loc3_:* = null;
         var _loc7_:Boolean = false;
         var _loc1_:PrerequisiteDIO = null;
         var _loc6_:Boolean = false;
         for each(var _loc5_ in city.unitTypes)
         {
            _loc2_ = domainInfo.getUnit(_loc5_.unitTypeId);
            if(_loc2_)
            {
               if(_loc5_.recruited)
               {
                  _loc5_.recruitable = false;
                  if(_loc5_.currentLevel == _loc2_.maxLevels)
                  {
                     _loc5_.upgradable = false;
                  }
                  else
                  {
                     _loc7_ = false;
                     _loc1_ = _loc2_.trainingPrerequisitesPerLevel[_loc5_.currentLevel];
                     for each(_loc3_ in city.buildings)
                     {
                        if(_loc3_.buildingTypeId == _loc1_.id)
                        {
                           if(!_loc7_)
                           {
                              _loc7_ = _loc3_.level >= _loc1_.level;
                           }
                        }
                     }
                     _loc5_.upgradable = _loc7_;
                  }
                  _loc5_.currentlyRecruiting = false;
                  _loc5_.currentlyTraining = false;
                  for each(var _loc4_ in city.unitTrainJobs)
                  {
                     if(_loc4_.unitTypeId == _loc5_.unitTypeId)
                     {
                        _loc5_.currentlyTraining = true;
                        _loc5_.durationRemaining = _loc4_.durationRemaining;
                        _loc5_.originalDuration = _loc4_.originalDuration;
                        _loc5_.jobCreationTime = _loc4_.jobCreationTime;
                        break;
                     }
                  }
                  if(!_loc5_.currentlyTraining)
                  {
                     _loc5_.durationRemaining = 0;
                     _loc5_.originalDuration = 0;
                     _loc5_.jobCreationTime = 0;
                  }
               }
               else
               {
                  _loc5_.upgradable = false;
                  _loc6_ = false;
                  for each(_loc3_ in city.buildings)
                  {
                     if(_loc3_.buildingTypeId == _loc2_.unlockPrerequisite.id)
                     {
                        if(!_loc6_)
                        {
                           _loc6_ = _loc3_.level >= _loc2_.unlockPrerequisite.level;
                        }
                     }
                  }
                  _loc5_.recruitable = _loc6_;
                  _loc5_.currentlyTraining = false;
                  if(city.activeRecruitJob && city.activeRecruitJob.unitTypeId == _loc5_.unitTypeId)
                  {
                     _loc5_.currentlyRecruiting = true;
                     _loc5_.durationRemaining = city.activeRecruitJob.durationRemaining;
                     _loc5_.originalDuration = city.activeRecruitJob.originalDuration;
                     _loc5_.jobCreationTime = city.activeRecruitJob.jobCreationTime;
                  }
                  else
                  {
                     _loc5_.currentlyRecruiting = false;
                     _loc5_.durationRemaining = 0;
                     _loc5_.originalDuration = 0;
                     _loc5_.jobCreationTime = 0;
                  }
               }
            }
         }
         coreManager.recalculateAllUnitStats();
         dispatch(new ModelUpdateEvent("unitTypesUpdated"));
      }
   }
}

