package wom.controller.command.model
{
   import flash.utils.Dictionary;
   import wom.controller.PCommand;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.model.GenerateBuildingTypeInfosEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.domain.domaininfoobject.MultipleInstancePrerequisitesDIO;
   import wom.model.domain.domaininfoobject.PrerequisiteDIO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.building.BuildingTypeInfo;
   
   public class GenerateBuildingTypeInfosCommand extends PCommand
   {
      
      [Inject]
      public var event:GenerateBuildingTypeInfosEvent;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      public function GenerateBuildingTypeInfosCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc2_:int = 0;
         var _loc11_:int = 0;
         var _loc1_:* = null;
         var _loc12_:BuildingTypeDIO = null;
         var _loc6_:* = 0;
         var _loc5_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         var _loc10_:Vector.<BuildingTypeDIO> = domainInfo.getBuildings();
         var _loc9_:Vector.<BuildingInfo> = city.buildings;
         if(!city.buildingTypes)
         {
            city.buildingTypes = new Dictionary();
         }
         for each(var _loc13_ in _loc10_)
         {
            _loc12_ = domainInfo.getBuilding(_loc13_.id);
            _loc2_ = 0;
            _loc11_ = 0;
            for each(_loc1_ in _loc9_)
            {
               if(_loc1_.buildingTypeId == _loc13_.id)
               {
                  _loc2_++;
               }
            }
            _loc6_ = _loc2_;
            if(_loc12_.buildingPrerequisitesPerInstance.length > 0)
            {
               for each(var _loc14_ in _loc12_.buildingPrerequisitesPerInstance)
               {
                  if(_loc6_ > 0)
                  {
                     _loc6_--;
                     _loc11_++;
                  }
                  else
                  {
                     _loc5_ = true;
                     for each(var _loc7_ in _loc14_)
                     {
                        _loc3_ = false;
                        _loc4_ = _loc7_.count;
                        for each(_loc1_ in _loc9_)
                        {
                           if(_loc1_.buildingTypeId == _loc7_.id)
                           {
                              if(_loc1_.level >= _loc7_.level)
                              {
                                 if(!_loc3_)
                                 {
                                    _loc3_ = true;
                                 }
                                 _loc4_--;
                              }
                           }
                        }
                        if(!_loc3_ || _loc4_ > 0)
                        {
                           _loc5_ = false;
                           break;
                        }
                     }
                     for each(_loc7_ in _loc12_.buildingPrerequisitesPerLevel[0])
                     {
                        _loc3_ = false;
                        _loc4_ = _loc7_.count;
                        for each(_loc1_ in _loc9_)
                        {
                           if(_loc1_.buildingTypeId == _loc7_.id)
                           {
                              if(_loc1_.level >= _loc7_.level)
                              {
                                 if(!_loc3_)
                                 {
                                    _loc3_ = true;
                                 }
                                 _loc4_--;
                              }
                           }
                        }
                        if(!_loc3_ || _loc4_ > 0)
                        {
                           _loc5_ = false;
                           break;
                        }
                     }
                     if(!_loc5_)
                     {
                        break;
                     }
                     _loc11_++;
                  }
               }
               if(city.buildingTypes[_loc13_.id])
               {
                  (city.buildingTypes[_loc13_.id] as BuildingTypeInfo).currentInstanceCount = _loc2_;
                  (city.buildingTypes[_loc13_.id] as BuildingTypeInfo).maxInstanceCount = _loc11_;
               }
               else
               {
                  city.buildingTypes[_loc13_.id] = new BuildingTypeInfo(_loc13_.id,_loc2_,_loc11_);
               }
            }
            else
            {
               _loc11_ = 0;
               for each(var _loc8_ in _loc12_.multipleInstancePrerequisites)
               {
                  _loc5_ = true;
                  for each(_loc7_ in _loc8_.prerequisites)
                  {
                     _loc3_ = false;
                     _loc4_ = _loc7_.count;
                     for each(_loc1_ in _loc9_)
                     {
                        if(_loc1_.buildingTypeId == _loc7_.id)
                        {
                           if(_loc1_.level >= _loc7_.level)
                           {
                              if(!_loc3_)
                              {
                                 _loc3_ = true;
                              }
                              _loc4_--;
                           }
                        }
                     }
                     if(!_loc3_ || _loc4_ > 0)
                     {
                        _loc5_ = false;
                        break;
                     }
                  }
                  if(!_loc5_)
                  {
                     break;
                  }
                  _loc11_ = _loc8_.maxInstances;
               }
               if(city.buildingTypes[_loc13_.id])
               {
                  (city.buildingTypes[_loc13_.id] as BuildingTypeInfo).currentInstanceCount = _loc2_;
                  (city.buildingTypes[_loc13_.id] as BuildingTypeInfo).maxInstanceCount = _loc11_;
               }
               else
               {
                  city.buildingTypes[_loc13_.id] = new BuildingTypeInfo(_loc13_.id,_loc2_,_loc11_);
               }
            }
         }
         dispatch(new ModelUpdateEvent("buildingTypesUpdated"));
      }
   }
}

