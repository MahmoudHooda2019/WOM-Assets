package wom.controller.command.model
{
   import wom.controller.PCommand;
   import wom.controller.event.model.FinishNowHiringEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.hiring.HiringInfo;
   import wom.model.game.unit.UnitInfo;
   import wom.model.game.unit.UnitStatusType;
   import wom.model.game.unit.UnitTypeInfo;
   
   public class BaseHiringCommand extends PCommand
   {
      
      [Inject]
      public var event:FinishNowHiringEvent;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function BaseHiringCommand()
      {
         super();
      }
      
      public static function calculateRemainingBarracksSpace(param1:DomainInfo, param2:CityStatusInfo, param3:UserInfo) : int
      {
         var _loc12_:int = 0;
         var _loc10_:UnitTypeInfo = null;
         var _loc5_:UnitTypeDIO = null;
         var _loc11_:int = 0;
         var _loc8_:BuildingTypeDIO = param1.getBuilding(19);
         var _loc9_:Vector.<int> = _loc8_.buildingSpecificInfo[BuildingSpecificInfoType.MERCENARY_CAPACITIES_PER_LEVEL.id];
         for each(var _loc7_ in param2.buildings)
         {
            if(_loc7_.buildingTypeId == 19)
            {
               _loc12_ = _loc7_.level == 0 ? 0 : _loc7_.level - 1;
               _loc11_ += _loc9_[_loc12_] * param3.barracksSpaceModifier;
            }
         }
         var _loc6_:int = _loc11_;
         for each(var _loc4_ in param2.units)
         {
            if(_loc4_.status == UnitStatusType.IN_BARRACKS)
            {
               _loc10_ = param2.unitTypes[_loc4_.typeId];
               _loc5_ = param1.getUnit(_loc4_.typeId);
               _loc6_ -= _loc5_.spacesPerLevel[_loc10_.currentLevel - 1];
            }
         }
         return _loc6_;
      }
      
      protected static function compareHiringInfoOnInstanceIds(param1:HiringInfo, param2:HiringInfo) : int
      {
         return param1.hiringBuildingInstanceId > param2.hiringBuildingInstanceId ? 1 : (param1.hiringBuildingInstanceId < param2.hiringBuildingInstanceId ? -1 : 0);
      }
      
      protected function sortHiringInfoList() : Vector.<HiringInfo>
      {
         var _loc1_:Vector.<HiringInfo> = new Vector.<HiringInfo>();
         for each(var _loc2_ in city.hiringInfoDictionary)
         {
            _loc1_.push(_loc2_);
         }
         _loc1_.sort(compareHiringInfoOnInstanceIds);
         return _loc1_;
      }
   }
}

