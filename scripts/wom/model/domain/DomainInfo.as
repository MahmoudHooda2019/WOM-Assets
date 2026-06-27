package wom.model.domain
{
   import flash.utils.Dictionary;
   import wom.model.domain.domaininfoobject.BeastTypeDIO;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.domain.domaininfoobject.CatapultTypeDIO;
   import wom.model.domain.domaininfoobject.ConstantsDIO;
   import wom.model.domain.domaininfoobject.DecorationTypeDIO;
   import wom.model.domain.domaininfoobject.EventItemDIO;
   import wom.model.domain.domaininfoobject.LeagueLevelDIO;
   import wom.model.domain.domaininfoobject.PartTypeDIO;
   import wom.model.domain.domaininfoobject.StaffDIO;
   import wom.model.domain.domaininfoobject.TavernItemDIO;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.domain.domaininfoobject.WorkerTypeDIO;
   import wom.model.game.building.BuildMenuCategory;
   import wom.model.game.building.BuildMenuDecorationCategory;
   import wom.model.game.unit.UnitAccessType;
   
   public interface DomainInfo
   {
      
      function init() : void;
      
      function getPart(param1:int) : PartTypeDIO;
      
      function getBuilding(param1:int) : BuildingTypeDIO;
      
      function getBuildings() : Vector.<BuildingTypeDIO>;
      
      function getBuildingsByBuildMenuCategory(param1:BuildMenuCategory) : Vector.<BuildingTypeDIO>;
      
      function getDecorationsByBuildMenuCategory(param1:BuildMenuDecorationCategory) : Vector.<DecorationTypeDIO>;
      
      function getUnits(param1:UnitAccessType = null, param2:Boolean = false) : Vector.<UnitTypeDIO>;
      
      function getUnitMap() : Dictionary;
      
      function getUnit(param1:int) : UnitTypeDIO;
      
      function getWorker() : WorkerTypeDIO;
      
      function getConstants() : ConstantsDIO;
      
      function getBeasts() : Vector.<BeastTypeDIO>;
      
      function getBeastMap() : Dictionary;
      
      function getBeast(param1:int) : BeastTypeDIO;
      
      function getStaffs() : Vector.<StaffDIO>;
      
      function getStaffMap() : Dictionary;
      
      function getStaff(param1:int) : StaffDIO;
      
      function getItems() : Vector.<PartTypeDIO>;
      
      function getEventItem(param1:int) : EventItemDIO;
      
      function getEventItems() : Vector.<EventItemDIO>;
      
      function getMapLayout() : Object;
      
      function getDecoration(param1:int) : DecorationTypeDIO;
      
      function getDecorations() : Vector.<DecorationTypeDIO>;
      
      function getCampaignLayout() : Object;
      
      function getTerrainLayout() : Object;
      
      function getLeagueLevels() : Vector.<LeagueLevelDIO>;
      
      function getLeagueLevel(param1:Number) : LeagueLevelDIO;
      
      function getTavernItems() : Vector.<TavernItemDIO>;
      
      function getTavernItem(param1:int) : TavernItemDIO;
      
      function getUnlockedTavernItem(param1:int) : TavernItemDIO;
      
      function getCatapults() : Dictionary;
      
      function getCatapult(param1:int) : CatapultTypeDIO;
   }
}

