package wom.view.mediator.screen.windows.tuskhorn
{
   import starling.events.Event;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.defense.SoundTuskHornEvent;
   import wom.controller.event.model.NotEnoughResourceEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.controller.event.ui.TuskHornSelectMercenaryEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.dto.UnitTypeAmountDTO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.resource.ResourceType;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.unit.MobileNotEnoughResourcePopUp;
   import wom.view.screen.windows.tuskhorn.MobileTuskHornMercenaryView;
   import wom.view.screen.windows.tuskhorn.MobileTuskHornWindow;
   
   public class MobileTuskHornWindowMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileTuskHornWindow;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var cityInfo:CityStatusInfo;
      
      public function MobileTuskHornWindowMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         calculateCapacityAndPrice();
         addContextListener("jobsInfoUpdated",onUpgradeJobsUpdated,ModelUpdateEvent);
         addContextListener("minus",onMercenarySelect,TuskHornSelectMercenaryEvent);
         addContextListener("plus",onMercenarySelect,TuskHornSelectMercenaryEvent);
         eventMap.mapStarlingListener(view.clearAllButton,"triggered",onClearAllButtonClicked,Event);
         eventMap.mapStarlingListener(view.engageCombatButton,"triggered",onEngageCombatButtonClicked,Event);
         addContextListener("resourceTypeKnown",onNotEnoughMight,NotEnoughResourceEvent);
         view.addMercenaries(domainInfo.getUnits());
      }
      
      private function onNotEnoughMight(param1:NotEnoughResourceEvent) : void
      {
         if(param1.resourceType != ResourceType.MIGHT)
         {
            return;
         }
         view.addWindowEnumeration(new WindowEnumeration(0,{"womview":view}));
         view.addWindowEnumeration(new WindowEnumeration(18,{
            "tab":1,
            "page":1
         }));
         closeWindow();
      }
      
      private function onUpgradeJobsUpdated(param1:ModelUpdateEvent) : void
      {
         calculateCapacityAndPrice();
      }
      
      private function calculateCapacityAndPrice() : void
      {
         var _loc1_:BuildingTypeDIO = null;
         for each(var _loc2_ in cityInfo.buildings)
         {
            if(_loc2_.buildingTypeId == 25)
            {
               _loc1_ = domainInfo.getBuilding(25);
               view.price = _loc1_.buildingSpecificInfo[BuildingSpecificInfoType.MUSK_PRICES_PER_LEVEL.id][_loc2_.level - 1];
               view.capacity = _loc1_.buildingSpecificInfo[BuildingSpecificInfoType.MUSK_CAPACITIES_PER_LEVEL.id][_loc2_.level - 1];
               calculateSelected();
               return;
            }
         }
      }
      
      private function calculateSelected() : void
      {
         var _loc3_:UnitTypeInfo = null;
         var _loc2_:int = 0;
         for each(var _loc1_ in view.mercenaryViews)
         {
            _loc3_ = cityInfo.unitTypes[_loc1_.unitTypeDIO.id];
            _loc2_ += _loc1_.unitTypeDIO.spacesPerLevel[_loc3_.currentLevel - 1] * _loc1_.selectedCount;
         }
         view.updateSpaceStatus(_loc2_);
      }
      
      private function onMercenarySelect(param1:TuskHornSelectMercenaryEvent) : void
      {
         var _loc3_:Boolean = param1.type == "plus";
         var _loc2_:int = param1.id;
         var _loc5_:MobileTuskHornMercenaryView = findMercenaryViewById(_loc2_);
         if(!_loc3_ && _loc5_.selectedCount == 0)
         {
            return;
         }
         var _loc4_:UnitTypeInfo = cityInfo.unitTypes[_loc5_.unitTypeDIO.id];
         if(_loc3_ && _loc5_.unitTypeDIO.spacesPerLevel[_loc4_.currentLevel - 1] > view.capacity - view.selectedCapacity)
         {
            return;
         }
         _loc5_.selectedCount += _loc3_ ? 1 : -1;
         calculateSelected();
      }
      
      private function findMercenaryViewById(param1:int) : MobileTuskHornMercenaryView
      {
         for each(var _loc2_ in view.mercenaryViews)
         {
            if(_loc2_.unitTypeDIO.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function onClearAllButtonClicked(param1:Event) : void
      {
         for each(var _loc2_ in view.mercenaryViews)
         {
            _loc2_.selectedCount = 0;
         }
         calculateSelected();
      }
      
      private function onEngageCombatButtonClicked(param1:Event) : void
      {
         if(view.price > cityInfo.resourceAmounts[ResourceType.MIGHT.id])
         {
            dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileNotEnoughResourcePopUp(-1,ResourceType.MIGHT)));
            return;
         }
         var _loc3_:Vector.<UnitTypeAmountDTO> = new Vector.<UnitTypeAmountDTO>();
         for each(var _loc2_ in view.mercenaryViews)
         {
            if(_loc2_.selectedCount > 0)
            {
               _loc3_.push(new UnitTypeAmountDTO(_loc2_.unitTypeDIO.id,_loc2_.selectedCount));
            }
         }
         if(_loc3_.length > 0)
         {
            closeWindow();
            dispatch(new SoundTuskHornEvent("startDefense",_loc3_));
         }
      }
   }
}

