package wom.view.mediator.ui.mainframe.city.tooltip.mobile
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import wom.controller.event.GameTickEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.unit.UnitInfo;
   import wom.model.game.unit.UnitStatusType;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.view.ui.mainframe.city.tooltip.mobile.MobileBuildingTooltipHousingInfoView;
   
   public class MobileBuildingTooltipHousingInfoViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileBuildingTooltipHousingInfoView;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      public function MobileBuildingTooltipHousingInfoViewMediator()
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
         var _loc4_:int = 0;
         var _loc8_:int = 0;
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:UnitStatusType = null;
         var _loc2_:Boolean = false;
         switch(view.housingType)
         {
            case 0:
               _loc4_ = 19;
               _loc6_ = UnitStatusType.IN_BARRACKS;
               _loc2_ = true;
               break;
            case 1:
               _loc4_ = 37;
               break;
            case 2:
               _loc4_ = 43;
               _loc6_ = UnitStatusType.IN_ALLIANCE_BARRACKS;
               _loc2_ = true;
               break;
            case 3:
               _loc4_ = 38;
               break;
            default:
               return;
         }
         for each(var _loc1_ in city.units)
         {
            _loc8_ = domainInfo.getUnit(_loc1_.typeId).spacesPerLevel[(city.unitTypes[_loc1_.typeId] as UnitTypeInfo).currentLevel - 1];
            if(_loc6_ && _loc1_.status == _loc6_ || _loc1_.buildingId == view.buildingInfo.instanceId)
            {
               _loc5_ += _loc8_;
            }
         }
         for each(var _loc3_ in city.buildings)
         {
            if(_loc2_ && (_loc3_.buildingTypeId == _loc4_ && _loc3_.level > 0) || _loc3_.instanceId == view.buildingInfo.instanceId)
            {
               _loc7_ += int(domainInfo.getBuilding(_loc3_.buildingTypeId).buildingSpecificInfo[BuildingSpecificInfoType.MERCENARY_CAPACITIES_PER_LEVEL.id][_loc3_.level - 1] * (_loc4_ == 19 ? userInfo.barracksSpaceModifier : 1));
            }
         }
         view.updateWithData(_loc5_,_loc7_);
      }
   }
}

