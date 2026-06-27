package wom.model.component.factory
{
   import flash.geom.Point;
   import peak.cuckoo.game.attribute.Position;
   import peak.cuckoo.game.dto.Point3;
   import wom.model.component.attribute.data.BuildingData;
   import wom.model.component.attribute.data.DecorationData;
   import wom.model.component.attribute.data.GuillotineData;
   import wom.model.component.attribute.projection.IsoBuildingProjection;
   import wom.model.component.attribute.view.WomFilters;
   import wom.model.component.attribute.viewManager.BuildingViewManager;
   import wom.model.component.attribute.viewManager.DecorationViewManager;
   import wom.model.component.behavior.TowerAnimationManager;
   import wom.model.component.behavior.building.BuildingRepair;
   import wom.model.component.behavior.building.BuildingUpgrade;
   import wom.model.component.behavior.building.CombineBuildingChildManager;
   import wom.model.component.behavior.building.UnitRecruit;
   import wom.model.component.behavior.mouse.follow.BuildingMouseFollow;
   import wom.model.component.behavior.mouse.follow.ConstructableMouseFollow;
   import wom.model.component.behavior.mouse.follow.MultiBuildMouseFollow;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.component.entity.gamesprite.Decoration;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.domain.domaininfoobject.DecorationTypeDIO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.WomGameRootHolder;
   import wom.model.game.attack.GameModeType;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.building.BuildingTypeInfo;
   import wom.model.game.building.DecorationInfo;
   import wom.model.game.building.DecorationVariationInfo;
   import wom.model.game.job.BuildingRepairJob;
   import wom.model.game.job.BuildingUpgradeJob;
   
   public class DefaultConstructableFactory implements ConstructableFactory
   {
      
      [Inject]
      public var gameRootHolder:WomGameRootHolder;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      public function DefaultConstructableFactory()
      {
         super();
      }
      
      public function createBuilding(param1:BuildingInfo, param2:BuildingTypeDIO, param3:BuildingTypeInfo, param4:BuildingUpgradeJob, param5:BuildingRepairJob) : Building
      {
         var _loc7_:Building = new Building();
         var _loc6_:Boolean = false;
         if((userInfo.gameMode == GameModeType.ATTACK || userInfo.gameMode == GameModeType.VISIT) && param1.isTrap && !city.spyEnabled)
         {
            _loc6_ = true;
         }
         if(!_loc6_)
         {
            _loc7_.componentManager.add(_loc7_.viewManager = new BuildingViewManager(_loc7_,param2));
         }
         _loc7_.componentManager.add(_loc7_.data = new BuildingData(param1,param3,param2));
         _loc7_.componentManager.add(_loc7_.position = new Position(new Point3(param1.position.x,param1.position.y,0)));
         var _loc8_:IsoBuildingProjection = new IsoBuildingProjection(param2.baseSize,new Point3());
         _loc7_.componentManager.add(_loc8_);
         _loc7_.interactive = true;
         _loc7_.composite = _loc7_;
         if(param4)
         {
            _loc7_.componentManager.add(new BuildingUpgrade(param4));
         }
         if(param5)
         {
            _loc7_.componentManager.add(new BuildingRepair(param5));
         }
         if(param2.id == 17 && city.activeRecruitJob)
         {
            _loc7_.componentManager.add(new UnitRecruit(city.activeRecruitJob));
         }
         if(param2.combineBuilding)
         {
            _loc7_.componentManager.add(new CombineBuildingChildManager(param2.edgeSpace,param2.gardenSpace,param2.buildingSpace,param2.gateCoord));
         }
         else if(param1.buildingTypeId == 27)
         {
            _loc7_.componentManager.add(new GuillotineData());
         }
         else if(param1.buildingTypeId == 35 || param1.buildingTypeId == 32 || param1.buildingTypeId == 36)
         {
            _loc7_.componentManager.add(new TowerAnimationManager());
         }
         if(!_loc6_)
         {
            gameRootHolder.gameRoot.layers[3].add(_loc7_);
         }
         return _loc7_;
      }
      
      public function createDecoration(param1:DecorationInfo, param2:DecorationTypeDIO) : Decoration
      {
         var _loc3_:Decoration = new Decoration();
         _loc3_.componentManager.add(_loc3_.viewManager = new DecorationViewManager(_loc3_));
         _loc3_.componentManager.add(_loc3_.position = new Position(new Point3(param1.position.x,param1.position.y,0)));
         _loc3_.componentManager.add(_loc3_.data = new DecorationData(param1,param2));
         _loc3_.componentManager.add(new IsoBuildingProjection(param2.baseSize,new Point3()));
         _loc3_.interactive = true;
         _loc3_.composite = _loc3_;
         gameRootHolder.gameRoot.layers[3].add(_loc3_);
         return _loc3_;
      }
      
      public function createBuildingSilhouette(param1:BuildingTypeDIO, param2:BuildingTypeInfo) : Building
      {
         var _loc3_:BuildingMouseFollow = null;
         var _loc4_:BuildingInfo = new BuildingInfo(1,-1,param1.id,param1.healthPointsPerLevel[0],new Point(0,0));
         var _loc5_:Building = new Building();
         if(param2.constructTypeId == 41)
         {
            _loc3_ = new MultiBuildMouseFollow(true);
         }
         else
         {
            _loc3_ = new BuildingMouseFollow(true);
         }
         _loc5_.componentManager.add(_loc3_);
         _loc5_.componentManager.add(_loc5_.viewManager = new BuildingViewManager(_loc5_,param1));
         _loc5_.componentManager.add(_loc5_.position = new Position(new Point3(0,0,0)));
         _loc5_.componentManager.add(_loc5_.data = new BuildingData(_loc4_,param2,param1));
         _loc5_.componentManager.add(new IsoBuildingProjection(param1.baseSize,param1.visualMap.sortPoint));
         _loc5_.composite = _loc5_;
         _loc5_.filterManager.addFilter(WomFilters.MOVE_FILTER);
         gameRootHolder.gameRoot.layers[3].add(_loc5_);
         return _loc5_;
      }
      
      public function createDecorationSilhouette(param1:DecorationVariationInfo, param2:Boolean = false) : Decoration
      {
         var _loc6_:Decoration = new Decoration();
         var _loc4_:DecorationTypeDIO = param1.dio;
         var _loc3_:DecorationInfo = new DecorationInfo(-1,param1.dio.id,param1.kind,new Point(),param2);
         var _loc5_:ConstructableMouseFollow = new ConstructableMouseFollow(true);
         _loc6_.componentManager.add(_loc5_);
         _loc6_.componentManager.add(_loc6_.viewManager = new DecorationViewManager(_loc6_));
         _loc6_.componentManager.add(_loc6_.position = new Position(new Point3(_loc3_.position.x,_loc3_.position.y,0)));
         _loc6_.componentManager.add(_loc6_.data = new DecorationData(_loc3_,_loc4_));
         _loc6_.componentManager.add(new IsoBuildingProjection(_loc4_.baseSize,new Point3()));
         _loc6_.composite = _loc6_;
         _loc6_.filterManager.addFilter(WomFilters.MOVE_FILTER);
         gameRootHolder.gameRoot.layers[3].add(_loc6_);
         return _loc6_;
      }
   }
}

