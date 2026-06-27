package wom.view.mediator.ui.mainframe.city.mobile
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import peak.i18n.PText;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.WomGameRootHolder;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.building.BuildingTypeInfo;
   import wom.view.ui.mainframe.city.mobile.MobileConstructableOptionsView;
   
   public class MobileConstructableOptionsViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var baseView:MobileConstructableOptionsView;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var gameRootHolder:WomGameRootHolder;
      
      protected var buildingInfo:BuildingInfo;
      
      protected var buildingTypeInfo:BuildingTypeInfo;
      
      protected var buildingTypeDIO:BuildingTypeDIO;
      
      public function MobileConstructableOptionsViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         injector.injectInto(baseView);
         updateData();
         updateView();
      }
      
      protected function updateView() : void
      {
         var _temp_2:* = baseView;
         var _temp_1:* = buildingInfo.level;
         var _loc1_:String = "domain.building." + buildingInfo.buildingTypeId + ".name";
         _temp_2.updateLevelAndName(_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc1_));
      }
      
      protected function updateData() : void
      {
         for each(buildingInfo in city.buildings)
         {
            if(buildingInfo.instanceId == baseView.instanceId)
            {
               break;
            }
         }
         buildingTypeDIO = domainInfo.getBuilding(buildingInfo.buildingTypeId);
      }
      
      protected function cancelSelection() : void
      {
         gameRootHolder.gameRoot.mobileUnselect();
      }
   }
}

