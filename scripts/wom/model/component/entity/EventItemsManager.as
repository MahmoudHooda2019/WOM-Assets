package wom.model.component.entity
{
   import flash.geom.Point;
   import flash.utils.getTimer;
   import peak.cuckoo.core.Entity;
   import peak.cuckoo.game.attribute.Position;
   import peak.cuckoo.game.attribute.bounds.notCompositeBased.ParentRenderBounds;
   import peak.cuckoo.game.behavior.FpsSync;
   import peak.cuckoo.game.dto.Point3;
   import wom.controller.event.combat.CombatEventItemsEvent;
   import wom.controller.event.mobile.MobileCanvasOptionsPanelEvent;
   import wom.controller.event.mobile.MobileConstructableOptionsEvent;
   import wom.model.component.CuckooNotifier;
   import wom.model.component.WomGameRoot;
   import wom.model.component.attribute.data.DecorationData;
   import wom.model.component.attribute.data.UnitData;
   import wom.model.component.attribute.projection.IsoBuildingProjection;
   import wom.model.component.attribute.projection.IsoUnitProjection;
   import wom.model.component.attribute.view.WomFilters;
   import wom.model.component.attribute.viewManager.DecorationViewManager;
   import wom.model.component.attribute.viewManager.UnitViewManager;
   import wom.model.component.behavior.battle.attack.AcidTowerAttackManager;
   import wom.model.component.behavior.battle.attack.SiegeTowerAttackManager;
   import wom.model.component.behavior.battle.hit.SplashHit;
   import wom.model.component.behavior.battle.underatack.UnderAttackSiegeTower;
   import wom.model.component.behavior.mouse.follow.BaseMouseFollow;
   import wom.model.component.behavior.mouse.follow.WarBuildingMouseFollow;
   import wom.model.component.entity.attackcluster.SiegeTowerAttackCluster;
   import wom.model.component.entity.gamesprite.Decoration;
   import wom.model.component.entity.gamesprite.Unit;
   import wom.model.component.enum.CanvasMode;
   import wom.model.component.factory.DefaultUnitFactory;
   import wom.model.domain.domaininfoobject.DecorationTypeDIO;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.dto.DeployUnitCircleInfoDTO;
   import wom.model.dto.UnitTypeAmountDTO;
   import wom.model.game.building.BuildMenuDecorationCategory;
   import wom.model.game.building.DecorationInfo;
   import wom.model.game.unit.UnitInfo;
   import wom.model.game.unit.UnitStatusType;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.view.ui.MobileCanvasOptionsPanel;
   
   public class EventItemsManager extends Entity
   {
      
      private const WAR_BUILDING_BASE_SIZE:int = 8;
      
      private var womRoot:WomGameRoot;
      
      public var buildingSilhouette:Decoration;
      
      public var warBuilding:Unit;
      
      public var isAcidTower:Boolean;
      
      public function EventItemsManager()
      {
         super();
      }
      
      override public function init() : void
      {
         super.init();
         womRoot = root as WomGameRoot;
      }
      
      public function deployWarBuilding(param1:Boolean = false) : void
      {
         if(buildingSilhouette)
         {
            cancelDeployWarBuilding();
         }
         this.isAcidTower = param1;
         buildingSilhouette = new Decoration();
         var _loc2_:UnitTypeDIO = (womRoot.unitFactory as DefaultUnitFactory).domainInfo.getUnit(param1 ? 34 : 29);
         var _loc6_:UnitTypeInfo = womRoot.attackInfo.unitTypes[_loc2_.id];
         var _loc5_:int = _loc6_.currentLevel - 1;
         var _loc3_:WarBuildingMouseFollow = new WarBuildingMouseFollow(true,_loc2_.range(_loc5_),!param1,param1);
         buildingSilhouette.componentManager.add(_loc3_);
         buildingSilhouette.componentManager.add(buildingSilhouette.viewManager = new DecorationViewManager(buildingSilhouette));
         buildingSilhouette.componentManager.add(buildingSilhouette.position = new Position(new Point3(0,0,0)));
         var _loc4_:String = "U" + _loc2_.id + "Motion";
         _loc4_ = _loc4_ + "-0";
         buildingSilhouette.componentManager.add(buildingSilhouette.data = new DecorationData(new DecorationInfo(param1 ? 1000000 : 1000001,param1 ? 1000000 : 1000001,null,new Point()),new DecorationTypeDIO(param1 ? 1000000 : 1000001,null,8,BuildMenuDecorationCategory.UNKNOWN,null,_loc4_,0,0,false,new Point(3,-2),"",new Point())));
         buildingSilhouette.componentManager.add(new IsoBuildingProjection(8,new Point3()));
         buildingSilhouette.composite = buildingSilhouette;
         buildingSilhouette.filterManager.addFilter(WomFilters.MOVE_FILTER);
         womRoot.layers[3].add(buildingSilhouette);
         womRoot.addChild(buildingSilhouette);
         buildingSilhouette.init();
         womRoot.manageConstructableFloorWithRenderings(true,-1);
         womRoot.grid.addView();
         buildingSilhouette.viewManager.manageBuildingFloor(true);
         buildingSilhouette.interactive = true;
         womRoot.movingConstructable = buildingSilhouette;
         womRoot.canvasMode = CanvasMode.MOBILE_SIEGE_TOWER;
         buildingSilhouette.viewManager.drawMobileMoveArrows();
         womRoot.eventDispatcher.dispatchEvent(new MobileConstructableOptionsEvent("mobileConstructableOptionsClose"));
         womRoot.eventDispatcher.dispatchEvent(new MobileCanvasOptionsPanelEvent("showBuilidingOptionsPanel",womRoot.mobileOptionsPanel = new MobileCanvasOptionsPanel()));
         buildingSilhouette.bounds.update();
         (buildingSilhouette.componentManager["MouseFollow"] as BaseMouseFollow).onSignal0();
         (buildingSilhouette.componentManager["MouseFollow"] as BaseMouseFollow).disable();
      }
      
      public function cancelDeployWarBuilding() : void
      {
         womRoot.manageConstructableFloorWithRenderings(false,-1);
         womRoot.grid.removeView();
         if(buildingSilhouette)
         {
            womRoot.layers[3].remove(buildingSilhouette);
            buildingSilhouette.destroy();
            buildingSilhouette = null;
         }
         womRoot.eventDispatcher.dispatchEvent(new MobileCanvasOptionsPanelEvent("closeBuilidingOptionsPanel"));
         womRoot.movingConstructable = null;
         womRoot.canvasMode = CanvasMode.NORMAL;
      }
      
      public function buildWarBuilding(param1:Number, param2:Number) : void
      {
         womRoot.movingConstructable = null;
         womRoot.canvasMode = CanvasMode.NORMAL;
         param1 = buildingSilhouette.position.point.x;
         param2 = buildingSilhouette.position.point.y;
         womRoot.eventDispatcher.dispatchEvent(new MobileCanvasOptionsPanelEvent("closeBuilidingOptionsPanel"));
         womRoot.manageConstructableFloorWithRenderings(false,-1);
         womRoot.grid.removeView();
         if(buildingSilhouette)
         {
            womRoot.layers[3].remove(buildingSilhouette);
            buildingSilhouette.destroy();
         }
         buildingSilhouette = null;
         warBuilding = new Unit();
         var _loc8_:Number = womRoot.userInfo.unitArmorModifier;
         var _loc11_:Number = womRoot.userInfo.unitSpeedModifier;
         var _loc7_:Number = womRoot.userInfo.unitDamageModifier;
         var _loc9_:int = isAcidTower ? 34 : 29;
         var _loc5_:UnitTypeInfo = womRoot.attackInfo.unitTypes[_loc9_];
         var _loc4_:UnitTypeDIO = (womRoot.unitFactory as DefaultUnitFactory).domainInfo.getUnit(_loc9_);
         var _loc13_:int = _loc5_.currentLevel == 0 ? 0 : _loc5_.currentLevel - 1;
         var _loc12_:Number = _loc4_.healthPointsPerLevel[_loc13_];
         var _loc3_:UnitInfo = new UnitInfo(DefaultUnitFactory.generateUnitId(),UnitStatusType.DEPLOYING,-1,_loc9_,_loc12_,_loc8_,_loc11_,_loc7_);
         var _loc6_:UnitData = new UnitData(_loc3_,_loc5_,_loc4_,false);
         warBuilding.componentManager.add(warBuilding.data = _loc6_);
         warBuilding.componentManager.add(warBuilding.viewManager = new UnitViewManager(warBuilding,_loc3_,_loc5_,_loc4_,null,(womRoot.unitFactory as DefaultUnitFactory).gameRootHolder));
         warBuilding.componentManager.add(warBuilding.position = new Position(new Point3(param1,param2,0)));
         warBuilding.componentManager.add(new IsoUnitProjection(new Point3(_loc4_.animationSortPoint.x,_loc4_.animationSortPoint.y)));
         warBuilding.componentManager.add(warBuilding.bounds = new ParentRenderBounds());
         if(isAcidTower)
         {
            warBuilding.componentManager.add(warBuilding.attack = new AcidTowerAttackManager(8));
         }
         else
         {
            warBuilding.componentManager.add(warBuilding.attack = new SiegeTowerAttackManager(8));
         }
         warBuilding.componentManager.add(warBuilding.hit = new SplashHit());
         warBuilding.componentManager.add(warBuilding.underAttack = new UnderAttackSiegeTower(womRoot.battleManager));
         warBuilding.data.healAvailable = false;
         warBuilding.data.buffAvailable = false;
         womRoot.addChild(warBuilding);
         warBuilding.init();
         womRoot.layers[3].add(warBuilding);
         var _loc10_:SiegeTowerAttackCluster = new SiegeTowerAttackCluster(womRoot,womRoot.battleManager,param1,param2);
         warBuilding.data.cluster = _loc10_;
         _loc10_.addUnit(warBuilding);
         womRoot.battleManager.battleFieldControl.clusters.push(_loc10_);
         CuckooNotifier.getInstance().unitDeployedDTO(new DeployUnitCircleInfoDTO(FpsSync.frameNum,new Point3(param1,param2),1,new <UnitTypeAmountDTO>[new UnitTypeAmountDTO(_loc9_,1)],getTimer() - womRoot.attackInfo.attackStartTime));
         womRoot.eventDispatcher.dispatchEvent(new CombatEventItemsEvent("itemDeployed",_loc9_));
      }
   }
}

