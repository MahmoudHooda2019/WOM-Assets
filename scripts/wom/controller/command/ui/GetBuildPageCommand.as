package wom.controller.command.ui
{
   import wom.controller.PCommand;
   import wom.controller.event.ui.BuildPageReadyEvent;
   import wom.controller.event.ui.GetBuildPageEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.building.BuildMenuCategory;
   import wom.model.game.building.BuildingTypeInfo;
   
   public class GetBuildPageCommand extends PCommand
   {
      
      [Inject]
      public var event:GetBuildPageEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var cityInfo:CityStatusInfo;
      
      public function GetBuildPageCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc5_:int = 0;
         var _loc3_:int = event.pageNumber;
         var _loc2_:BuildMenuCategory = event.category;
         var _loc6_:Vector.<BuildingTypeDIO> = getBuildingsByCategory(_loc2_);
         var _loc1_:int = Math.ceil(_loc6_.length / event.itemCountPerPage);
         var _loc4_:Vector.<*> = new Vector.<*>();
         _loc6_.sort(sortItems);
         if(_loc3_ == 2147483647)
         {
            _loc3_ = _loc1_ - 1;
         }
         _loc5_ = _loc3_ * event.itemCountPerPage;
         while(_loc5_ < (_loc3_ + 1) * event.itemCountPerPage && _loc5_ < _loc6_.length)
         {
            _loc4_.push(_loc6_[_loc5_]);
            _loc5_++;
         }
         dispatch(new BuildPageReadyEvent("buildPageReady",_loc3_,_loc6_.length,_loc4_,_loc2_));
      }
      
      public function getBuildingsByCategory(param1:BuildMenuCategory) : Vector.<BuildingTypeDIO>
      {
         if(param1.id != BuildMenuCategory.UNKNOWN.id)
         {
            return domainInfo.getBuildingsByBuildMenuCategory(param1);
         }
         return null;
      }
      
      private function sortItems(param1:BuildingTypeDIO, param2:BuildingTypeDIO) : int
      {
         if(absoluteMaxReached(param1) == absoluteMaxReached(param2))
         {
            if(currentMaxReached(param1) == currentMaxReached(param2))
            {
               if(param1.buildMenuIndex > param2.buildMenuIndex)
               {
                  return 1;
               }
               return -1;
            }
            if(currentMaxReached(param1))
            {
               return 1;
            }
            return -1;
         }
         if(absoluteMaxReached(param1))
         {
            return 1;
         }
         return -1;
      }
      
      private function absoluteMaxReached(param1:BuildingTypeDIO) : Boolean
      {
         var _loc2_:BuildingTypeInfo = cityInfo.buildingTypes[param1.id];
         return !(_loc2_.currentInstanceCount < param1.maxInstances || param1.multibuild && _loc2_.currentInstanceCount < param1.multipleInstancePrerequisites[param1.multipleInstancePrerequisites.length - 1].maxInstances);
      }
      
      private function currentMaxReached(param1:BuildingTypeDIO) : Boolean
      {
         var _loc2_:BuildingTypeInfo = cityInfo.buildingTypes[param1.id];
         return _loc2_.currentInstanceCount == _loc2_.maxInstanceCount;
      }
   }
}

