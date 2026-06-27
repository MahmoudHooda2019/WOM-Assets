package wom.controller.command.city
{
   import flash.utils.Dictionary;
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.model.GenerateBuildingTypeInfosEvent;
   import wom.controller.event.model.GenerateUnitTypeInfosEvent;
   import wom.model.component.CoreManager;
   import wom.model.component.WomPlannerRootV2;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.unit.UnitInfo;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.model.message.notification.BuildingRecycledEventNotification;
   
   public class HandleBuildingRecycledEventNotificationCommand extends PCommand
   {
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var coreManager:CoreManager;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var plannerRoot:WomPlannerRootV2;
      
      public function HandleBuildingRecycledEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc10_:int = 0;
         var _loc8_:Dictionary = null;
         var _loc9_:Number = NaN;
         var _loc4_:int = 0;
         var _loc6_:BuildingRecycledEventNotification = messageReceivedEvent.message as BuildingRecycledEventNotification;
         var _loc5_:Boolean = false;
         var _loc3_:Boolean = false;
         _loc10_ = 0;
         while(_loc10_ < city.buildings.length)
         {
            if(city.buildings[_loc10_].instanceId == _loc6_.instanceId)
            {
               if(city.buildings[_loc10_].buildingTypeId == 19)
               {
                  _loc5_ = true;
               }
               city.buildings.splice(_loc10_,1);
               _loc3_ = true;
               break;
            }
            _loc10_++;
         }
         if(!_loc3_)
         {
            _loc10_ = 0;
            while(_loc10_ < city.decorations.length)
            {
               if(city.decorations[_loc10_].instanceId == _loc6_.instanceId)
               {
                  city.decorations.splice(_loc10_,1);
                  break;
               }
               _loc10_++;
            }
            coreManager.removeDecoration(_loc6_.instanceId);
         }
         else
         {
            if(_loc5_)
            {
               _loc8_ = new Dictionary();
               _loc9_ = userInfo.barracksSpaceModifier;
               for each(var _loc2_ in city.buildings)
               {
                  if(_loc2_.buildingTypeId == 19 && _loc2_.level > 0)
                  {
                     _loc8_[_loc2_.instanceId] = int(domainInfo.getBuilding(_loc2_.buildingTypeId).buildingSpecificInfo[BuildingSpecificInfoType.MERCENARY_CAPACITIES_PER_LEVEL.id][_loc2_.level - 1] * _loc9_);
                  }
               }
               for each(var _loc1_ in city.units)
               {
                  if(_loc1_.buildingId == _loc6_.instanceId)
                  {
                     _loc4_ = -1;
                     for(var _loc7_ in _loc8_)
                     {
                        if(_loc4_ == -1 || _loc8_[_loc7_] > _loc8_[_loc4_])
                        {
                           _loc4_ = int(_loc7_);
                        }
                     }
                     var _loc12_:int = _loc4_;
                     var _loc11_:Number = _loc8_[_loc12_] - domainInfo.getUnit(_loc1_.typeId).spacesPerLevel[(city.unitTypes[_loc1_.typeId] as UnitTypeInfo).currentLevel - 1];
                     _loc8_[_loc12_] = _loc11_;
                     _loc1_.buildingId = _loc4_;
                     coreManager.assignUnitToBarracks(_loc1_);
                  }
               }
            }
            coreManager.removeBuilding(_loc6_.instanceId);
            dispatch(new GenerateBuildingTypeInfosEvent("generateBuildingTypeInfosEvent"));
            dispatch(new GenerateUnitTypeInfosEvent("generateUnitTypeInfosEvent"));
         }
         if(plannerRoot)
         {
            plannerRoot.removeRecycledBuilding(_loc6_.instanceId);
         }
      }
   }
}

