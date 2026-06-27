package wom.controller.command.staff
{
   import wom.controller.PCommand;
   import wom.controller.event.staff.StaffsReadyEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.staff.StaffInfo;
   
   public class GetStaffsEventCommand extends PCommand
   {
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      public function GetStaffsEventCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc3_:* = undefined;
         var _loc1_:* = null;
         var _loc2_:BuildingTypeDIO = null;
         for each(_loc1_ in city.buildings)
         {
            if(_loc1_.buildingTypeId == 10)
            {
               _loc3_ = _loc1_.staffs != null ? _loc1_.staffs : new Vector.<StaffInfo>();
               break;
            }
         }
         _loc2_ = domainInfo.getBuilding(_loc1_.buildingTypeId);
         dispatch(new StaffsReadyEvent("staffsReady",_loc1_,_loc2_.buildingSpecificInfo[BuildingSpecificInfoType.STAFF_PREREQUISITES_PER_LEVEL.id][_loc1_.level >= _loc2_.maxLevels ? _loc2_.maxLevels - 1 : _loc1_.level],_loc3_));
      }
   }
}

