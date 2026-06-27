package wom.model.component
{
   import flash.events.IEventDispatcher;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import peak.config.DocumentConfiguration;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.attribute.Position;
   import peak.cuckoo.game.attribute.projection.BaseProjection;
   import peak.cuckoo.game.attribute.projection.IsoProjection;
   import peak.cuckoo.game.attribute.view.AssetView;
   import peak.cuckoo.game.dto.Point3;
   import peak.resource.atlas.starling.StarlingAtlasReference;
   import wom.Environment;
   import wom.controller.command.mobile.MobilePreSelectCommand;
   import wom.controller.event.WorkerUpdateEvent;
   import wom.controller.event.mobile.MobileCanvasOptionsPanelEvent;
   import wom.controller.event.mobile.MobileConstructableOptionsEvent;
   import wom.controller.event.tutorial.TutorialEvent;
   import wom.controller.event.tutorial.TutorialTriggerEvent;
   import wom.controller.event.ui.PopUpWindowEvent;
   import wom.controller.event.ui.ResourceBarAnimationEvent;
   import wom.model.component.attribute.ProjectedPosition;
   import wom.model.component.attribute.data.GuillotineData;
   import wom.model.component.attribute.data.WorkerData;
   import wom.model.component.attribute.data.WorkerStatus;
   import wom.model.component.attribute.grid.CityGrid;
   import wom.model.component.attribute.view.WomFilters;
   import wom.model.component.attribute.viewManager.BuildingViewManager;
   import wom.model.component.behavior.building.BuildingRepair;
   import wom.model.component.behavior.building.BuildingUpgrade;
   import wom.model.component.behavior.building.CombineBuildingChildManager;
   import wom.model.component.behavior.building.UnitRecruit;
   import wom.model.component.behavior.mouse.follow.BaseMouseFollow;
   import wom.model.component.behavior.mouse.follow.ConstructableMouseFollow;
   import wom.model.component.behavior.unit.Speak;
   import wom.model.component.behavior.unit.Wander;
   import wom.model.component.entity.Grid;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.component.entity.gamesprite.Decoration;
   import wom.model.component.entity.gamesprite.Unit;
   import wom.model.component.enum.CanvasMode;
   import wom.model.component.factory.ConstructableFactory;
   import wom.model.component.factory.DefaultUnitFactory;
   import wom.model.component.factory.UnitFactory;
   import wom.model.component.operations.Units;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.domain.domaininfoobject.DecorationTypeDIO;
   import wom.model.domain.domaininfoobject.StaffDIO;
   import wom.model.dto.PartInfoDTO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.DefaultVisitInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.VisitInfo;
   import wom.model.game.WomGameRootHolder;
   import wom.model.game.attack.GameModeType;
   import wom.model.game.beast.BeastCageTypeDIO;
   import wom.model.game.beast.BeastInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.building.BuildingTypeInfo;
   import wom.model.game.building.DecorationInfo;
   import wom.model.game.building.DecorationVariationInfo;
   import wom.model.game.building.ExpandSignTypeDIO;
   import wom.model.game.defense.NPCAttackDirection;
   import wom.model.game.helper.RowColumnPair;
   import wom.model.game.hiring.HiringInfo;
   import wom.model.game.hiring.HiringPauseReasonType;
   import wom.model.game.inventory.InventoryItemCategory;
   import wom.model.game.inventory.InventoryItemDTO;
   import wom.model.game.job.BuildingRepairJob;
   import wom.model.game.job.BuildingUpgradeJob;
   import wom.model.game.job.BuildingUpgradeJobType;
   import wom.model.game.job.UnitRecruitJob;
   import wom.model.game.job.UnitTrainJob;
   import wom.model.game.resource.ResourceType;
   import wom.model.game.speech.SpeechType;
   import wom.model.game.store.EventInventoryItemInfo;
   import wom.model.game.unit.UnitInfo;
   import wom.model.game.unit.UnitStatusType;
   import wom.view.ui.MobileCanvasOptionsPanel;
   
   public class DefaultCoreManager implements CoreManager
   {
      
      [Inject]
      public var gameRootHolder:WomGameRootHolder;
      
      [Inject]
      public var constructableFactory:ConstructableFactory;
      
      [Inject]
      public var unitFactory:UnitFactory;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var eventDispatcher:IEventDispatcher;
      
      [Inject]
      public var cityInfo:CityStatusInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var visitInfo:VisitInfo;
      
      [Inject]
      public var documentConfiguration:DocumentConfiguration;
      
      private var buildingsPendingAsset:Dictionary = new Dictionary();
      
      public function DefaultCoreManager()
      {
         super();
      }
      
      public static function getBuildingProjectedMiddlePoint(param1:Building) : Point3
      {
         return new Point3(param1.position.projected.x + param1.bounds.width / 2,param1.position.projected.y + param1.bounds.height / -2);
      }
      
      [PostConstruct]
      public function postConstruct() : void
      {
      }
      
      public function setFactories() : void
      {
         gameRootHolder.gameRoot.unitFactory = unitFactory;
         unitFactory.setGameRootHolder(gameRootHolder);
      }
      
      public function addBuildings(param1:Vector.<BuildingInfo>, param2:Vector.<BuildingUpgradeJob>, param3:Vector.<BuildingRepairJob>) : void
      {
         var _loc7_:int = 0;
         var _loc6_:BuildingUpgradeJob = null;
         var _loc5_:BuildingRepairJob = null;
         for each(var _loc4_ in param1)
         {
            _loc6_ = null;
            _loc5_ = null;
            _loc7_ = 0;
            while(_loc7_ < param2.length)
            {
               if(param2[_loc7_].instanceId == _loc4_.instanceId)
               {
                  _loc6_ = param2[_loc7_];
               }
               _loc7_++;
            }
            _loc7_ = 0;
            while(_loc7_ < param3.length)
            {
               if(param3[_loc7_].instanceId == _loc4_.instanceId)
               {
                  _loc5_ = param3[_loc7_];
               }
               _loc7_++;
            }
            addBuilding(_loc4_,_loc6_,_loc5_,true,_loc4_.instanceId in cityInfo.interruptedConstructionJobs);
         }
      }
      
      public function addDecorations(param1:Vector.<DecorationInfo>) : void
      {
         for each(var _loc2_ in param1)
         {
            addDecoration(_loc2_);
         }
      }
      
      public function addBuilding(param1:BuildingInfo, param2:BuildingUpgradeJob = null, param3:BuildingRepairJob = null, param4:Boolean = false, param5:Boolean = false) : void
      {
         var _loc13_:int = 0;
         var _loc12_:int = 0;
         var _loc7_:int = 0;
         var _loc11_:Unit = null;
         var _loc8_:WorkerStatus = null;
         var _loc10_:BuildingTypeDIO = domainInfo.getBuilding(param1.buildingTypeId);
         var _loc6_:Building = constructableFactory.createBuilding(param1,_loc10_,null,param2,param3);
         gameRootHolder.gameRoot.addChild(_loc6_);
         gameRootHolder.gameRoot.buildings[param1.instanceId] = _loc6_;
         gameRootHolder.gameRoot.componentManager["CityGrid"].markBuilding(param1.position.x,param1.position.y,_loc6_.data);
         if(param4)
         {
            if(param2 != null || param5)
            {
               unitFactory.assignAlreadyWorkingWorker(_loc6_ as Building);
            }
         }
         else
         {
            _loc13_ = param1.position.x;
            _loc12_ = param1.position.y;
            _loc7_ = _loc10_.baseSize;
            _loc11_ = gameRootHolder.gameRoot.findNearestWorker(_loc13_ + _loc7_,_loc12_ + _loc7_);
            _loc8_ = _loc11_.componentManager["WorkerStatus"] as WorkerStatus;
            _loc8_.stopWorking();
            _loc8_.busy = true;
            _loc8_.attendingCoordinates(_loc13_,_loc12_);
            _loc8_.walkAndWork(_loc13_,_loc12_,_loc7_);
            (_loc11_.componentManager["Speak"] as Speak).speak(SpeechType.WORKER_CONSTRUCTION_START);
         }
         if("BuildingViewManager" in _loc6_.componentManager)
         {
            _loc6_.viewManager.init();
         }
         _loc6_.init();
         for each(var _loc9_ in _loc6_.children)
         {
            _loc9_.init();
         }
         if(gameRootHolder.gameRoot.canvasMode == CanvasMode.BUILD)
         {
            _loc6_.filterManager.addFilter(WomFilters.MOVE_FILTER);
            _loc6_.viewManager.manageBuildingFloor(true);
         }
      }
      
      public function addDecoration(param1:DecorationInfo) : void
      {
         var _loc3_:DecorationTypeDIO = domainInfo.getDecoration(param1.decorationTypeId);
         var _loc4_:Decoration = constructableFactory.createDecoration(param1,_loc3_);
         gameRootHolder.gameRoot.addChild(_loc4_);
         gameRootHolder.gameRoot.decorations[param1.instanceId] = _loc4_;
         gameRootHolder.gameRoot.componentManager["CityGrid"].markConstructable(param1.position.x,param1.position.y,_loc4_.data.dio.baseSize,_loc4_);
         _loc4_.viewManager.init();
         _loc4_.init();
         for each(var _loc2_ in _loc4_.children)
         {
            _loc2_.init();
         }
         if(gameRootHolder.gameRoot.canvasMode == CanvasMode.BUILD)
         {
            _loc4_.filterManager.addFilter(WomFilters.MOVE_FILTER);
            _loc4_.viewManager.manageBuildingFloor(true);
         }
      }
      
      public function addGrids(param1:RowColumnPair) : void
      {
         var _loc10_:int = 0;
         var _loc3_:GameSprite = null;
         if(!gameRootHolder.gameRoot.cityGrid)
         {
            gameRootHolder.gameRoot.componentManager.add(gameRootHolder.gameRoot.cityGrid = new CityGrid(param1));
            gameRootHolder.gameRoot.cityGrid.init();
            gameRootHolder.gameRoot.weightGrid.dimensionsLoaded();
         }
         else
         {
            gameRootHolder.gameRoot.cityGrid.update(param1);
         }
         if(gameRootHolder.gameRoot.grid)
         {
            gameRootHolder.gameRoot.layers[gameRootHolder.gameRoot.grid.view.layerId].remove(gameRootHolder.gameRoot.grid);
            gameRootHolder.gameRoot.destroyChild(gameRootHolder.gameRoot.grid);
         }
         gameRootHolder.gameRoot.addChild(gameRootHolder.gameRoot.grid = new Grid(param1));
         gameRootHolder.gameRoot.grid.init();
         var _loc9_:int = param1.numberOfRows;
         var _loc5_:int = param1.numberOfColumns;
         var _loc15_:IsoProjection = gameRootHolder.gameRoot.projection as IsoProjection;
         _loc10_ = gameRootHolder.gameRoot.boundAssets.length - 1;
         while(_loc10_ >= 0)
         {
            _loc3_ = gameRootHolder.gameRoot.boundAssets[_loc10_];
            gameRootHolder.gameRoot.layers[_loc3_.view.layerId].remove(_loc3_);
            gameRootHolder.gameRoot.destroyChild(_loc3_);
            _loc10_--;
         }
         gameRootHolder.gameRoot.boundAssets.length = 0;
         gameRootHolder.gameRoot.cityGrid.projectedBoundLeft = new Point((_loc9_ + _loc5_) * _loc15_.pitchX / -4,(_loc9_ - _loc5_) * _loc15_.pitchY / 4);
         gameRootHolder.gameRoot.cityGrid.projectedBoundBottom = new Point((_loc9_ - _loc5_) * _loc15_.pitchX / -4,(_loc9_ + _loc5_) * _loc15_.pitchY / 4);
         gameRootHolder.gameRoot.cityGrid.projectedBoundRight = new Point((_loc9_ + _loc5_) * _loc15_.pitchX / 4,(_loc9_ - _loc5_) * _loc15_.pitchY / -4);
         gameRootHolder.gameRoot.cityGrid.projectedBoundTop = new Point((_loc9_ - _loc5_) * _loc15_.pitchX / 4,(_loc9_ + _loc5_) * _loc15_.pitchY / -4);
         var _loc8_:Matrix = new Matrix();
         var _loc6_:GameSprite = new GameSprite();
         _loc6_.componentManager.add(_loc6_.view = new AssetView(1,"BoundSideBottom",true));
         _loc6_.componentManager.add(_loc6_.position = new ProjectedPosition());
         _loc6_.componentManager.add(new BaseProjection());
         _loc6_.position.projected.x = gameRootHolder.gameRoot.cityGrid.projectedBoundLeft.x + 200;
         _loc6_.position.projected.y = gameRootHolder.gameRoot.cityGrid.projectedBoundLeft.y - 188;
         _loc6_.position.projected.z = 10;
         gameRootHolder.gameRoot.addChild(_loc6_);
         _loc6_.init();
         gameRootHolder.gameRoot.layers[_loc6_.view.layerId].add(_loc6_);
         _loc8_.identity();
         _loc8_.scale(1,-1);
         _loc8_.rotate(2.035);
         _loc6_.view.applyMatrix(_loc8_);
         gameRootHolder.gameRoot.boundAssets.push(_loc6_);
         var _loc13_:GameSprite = new GameSprite();
         _loc13_.componentManager.add(_loc13_.view = new AssetView(1,"BoundSideTop",true));
         _loc13_.componentManager.add(_loc13_.position = new ProjectedPosition());
         _loc13_.componentManager.add(new BaseProjection());
         _loc13_.position.projected.x = gameRootHolder.gameRoot.cityGrid.projectedBoundLeft.x + 240;
         _loc13_.position.projected.y = gameRootHolder.gameRoot.cityGrid.projectedBoundLeft.y - 565;
         _loc13_.position.projected.z = 10;
         gameRootHolder.gameRoot.addChild(_loc13_);
         _loc13_.init();
         gameRootHolder.gameRoot.layers[_loc13_.view.layerId].add(_loc13_);
         _loc8_.identity();
         _loc8_.scale(1,-1);
         _loc8_.rotate(-2.035);
         _loc13_.view.applyMatrix(_loc8_);
         gameRootHolder.gameRoot.boundAssets.push(_loc13_);
         var _loc7_:GameSprite = new GameSprite();
         _loc7_.componentManager.add(_loc7_.view = new AssetView(1,"BoundTopRight",true));
         _loc7_.componentManager.add(_loc7_.position = new ProjectedPosition());
         _loc7_.componentManager.add(new BaseProjection());
         _loc7_.position.projected.x = gameRootHolder.gameRoot.cityGrid.projectedBoundBottom.x - 280;
         _loc7_.position.projected.y = gameRootHolder.gameRoot.cityGrid.projectedBoundBottom.y - 337;
         _loc7_.position.projected.z = 0;
         gameRootHolder.gameRoot.addChild(_loc7_);
         _loc7_.init();
         gameRootHolder.gameRoot.layers[_loc7_.view.layerId].add(_loc7_);
         _loc8_.identity();
         _loc8_.rotate(2.035);
         _loc7_.view.applyMatrix(_loc8_);
         gameRootHolder.gameRoot.boundAssets.push(_loc7_);
         var _loc4_:GameSprite = new GameSprite();
         _loc4_.componentManager.add(_loc4_.view = new AssetView(1,"BoundTopLeft",true));
         _loc4_.componentManager.add(_loc4_.position = new ProjectedPosition());
         _loc4_.componentManager.add(new BaseProjection());
         _loc4_.position.projected.x = gameRootHolder.gameRoot.cityGrid.projectedBoundBottom.x + 205;
         _loc4_.position.projected.y = gameRootHolder.gameRoot.cityGrid.projectedBoundBottom.y - 352;
         _loc4_.position.projected.z = 0;
         gameRootHolder.gameRoot.addChild(_loc4_);
         _loc4_.init();
         gameRootHolder.gameRoot.layers[_loc4_.view.layerId].add(_loc4_);
         _loc8_.identity();
         _loc8_.rotate(-2.035);
         _loc4_.view.applyMatrix(_loc8_);
         gameRootHolder.gameRoot.boundAssets.push(_loc4_);
         var _loc11_:GameSprite = new GameSprite();
         _loc11_.componentManager.add(_loc11_.view = new AssetView(1,"BoundSideBottom",true));
         _loc11_.componentManager.add(_loc11_.position = new ProjectedPosition());
         _loc11_.componentManager.add(new BaseProjection());
         _loc11_.position.projected.x = gameRootHolder.gameRoot.cityGrid.projectedBoundRight.x - 297;
         _loc11_.position.projected.y = gameRootHolder.gameRoot.cityGrid.projectedBoundRight.y - 187;
         _loc11_.position.projected.z = 10;
         gameRootHolder.gameRoot.addChild(_loc11_);
         _loc11_.init();
         gameRootHolder.gameRoot.layers[_loc11_.view.layerId].add(_loc11_);
         _loc8_.identity();
         _loc8_.rotate(3.141592653589793 - 2.035);
         _loc11_.view.applyMatrix(_loc8_);
         gameRootHolder.gameRoot.boundAssets.push(_loc11_);
         var _loc14_:GameSprite = new GameSprite();
         _loc14_.componentManager.add(_loc14_.view = new AssetView(1,"BoundSideTop",true));
         _loc14_.componentManager.add(_loc14_.position = new ProjectedPosition());
         _loc14_.componentManager.add(new BaseProjection());
         _loc14_.position.projected.x = gameRootHolder.gameRoot.cityGrid.projectedBoundRight.x - 320;
         _loc14_.position.projected.y = gameRootHolder.gameRoot.cityGrid.projectedBoundRight.y - 565;
         _loc14_.position.projected.z = 10;
         gameRootHolder.gameRoot.addChild(_loc14_);
         _loc14_.init();
         gameRootHolder.gameRoot.layers[_loc14_.view.layerId].add(_loc14_);
         _loc8_.identity();
         _loc8_.rotate(3.141592653589793 + 2.035);
         _loc14_.view.applyMatrix(_loc8_);
         gameRootHolder.gameRoot.boundAssets.push(_loc14_);
         var _loc2_:GameSprite = new GameSprite();
         _loc2_.componentManager.add(_loc2_.view = new AssetView(1,"BoundTopRight",true));
         _loc2_.componentManager.add(_loc2_.position = new ProjectedPosition());
         _loc2_.componentManager.add(new BaseProjection());
         _loc2_.position.projected.x = gameRootHolder.gameRoot.cityGrid.projectedBoundTop.x + 191;
         _loc2_.position.projected.y = gameRootHolder.gameRoot.cityGrid.projectedBoundTop.y - 191;
         _loc2_.position.projected.z = 0;
         gameRootHolder.gameRoot.addChild(_loc2_);
         _loc2_.init();
         gameRootHolder.gameRoot.layers[_loc2_.view.layerId].add(_loc2_);
         _loc8_.identity();
         _loc8_.rotate(3.141592653589793 + 2.035);
         _loc2_.view.applyMatrix(_loc8_);
         gameRootHolder.gameRoot.boundAssets.push(_loc2_);
         var _loc12_:GameSprite = new GameSprite();
         _loc12_.componentManager.add(_loc12_.view = new AssetView(1,"BoundTopLeft",true));
         _loc12_.componentManager.add(_loc12_.position = new ProjectedPosition());
         _loc12_.componentManager.add(new BaseProjection());
         _loc12_.position.projected.x = gameRootHolder.gameRoot.cityGrid.projectedBoundTop.x - 278;
         _loc12_.position.projected.y = gameRootHolder.gameRoot.cityGrid.projectedBoundTop.y - 184;
         _loc12_.position.projected.z = 0;
         gameRootHolder.gameRoot.addChild(_loc12_);
         _loc12_.init();
         gameRootHolder.gameRoot.layers[_loc12_.view.layerId].add(_loc12_);
         _loc8_.identity();
         _loc8_.rotate(3.141592653589793 - 2.035);
         _loc12_.view.applyMatrix(_loc8_);
         gameRootHolder.gameRoot.boundAssets.push(_loc12_);
      }
      
      public function updateGrids(param1:RowColumnPair) : void
      {
         addGrids(param1);
         buildCityExpansionSigns();
         buildBeastCage();
      }
      
      public function addBackground() : void
      {
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:GameSprite = null;
         var _loc3_:String = "GrassTileM";
         var _loc4_:StarlingAtlasReference = Environment.gpu.atlasManager.references[_loc3_];
         _loc5_ = -2000;
         while(_loc5_ < 4000 / 2)
         {
            _loc2_ = -1000;
            while(_loc2_ < 2000 / 2)
            {
               _loc1_ = new GameSprite();
               _loc1_.componentManager.add(_loc1_.view = new AssetView(0,_loc3_));
               _loc1_.componentManager.add(new BaseProjection());
               _loc1_.componentManager.add(_loc1_.position = new Position(new Point3()));
               _loc1_.position.point.x = _loc5_;
               _loc1_.position.point.y = _loc2_;
               gameRootHolder.gameRoot.addChild(_loc1_);
               gameRootHolder.gameRoot.layers[0].add(_loc1_);
               _loc1_.init();
               _loc1_.position.projected.z = 100;
               _loc2_ += _loc4_.height;
            }
            _loc5_ += _loc4_.width;
         }
      }
      
      public function startBuild(param1:int, param2:Boolean, param3:Boolean = false, param4:Boolean = true) : void
      {
         var _loc5_:Building = null;
         var _loc9_:MobileCanvasOptionsPanel = null;
         var _loc6_:Point = null;
         var _loc8_:Point3 = null;
         var _loc7_:Dictionary = null;
         if(gameRootHolder.gameRoot.canvasMode == CanvasMode.NORMAL)
         {
            gameRootHolder.gameRoot.canvasMode = CanvasMode.BUILD;
            gameRootHolder.gameRoot.multiBuildSoundPlayed = false;
            eventDispatcher.dispatchEvent(new PopUpWindowEvent("delayPopUps",null));
            _loc5_ = constructableFactory.createBuildingSilhouette(domainInfo.getBuilding(param1),cityInfo.buildingTypes[param1]);
            gameRootHolder.gameRoot.addChild(_loc5_);
            gameRootHolder.gameRoot.movingConstructable = _loc5_;
            gameRootHolder.gameRoot.buildByGold = param2;
            gameRootHolder.gameRoot.completeResources = param3;
            _loc5_.init();
            gameRootHolder.gameRoot.manageConstructableFloorWithRenderings(true);
            gameRootHolder.gameRoot.grid.addView();
            _loc5_.viewManager.manageBuildingFloor(true);
            _loc5_.interactive = true;
            _loc5_.viewManager.drawMobileMoveArrows();
            eventDispatcher.dispatchEvent(new MobileConstructableOptionsEvent("mobileConstructableOptionsClose"));
            _loc9_ = new MobileCanvasOptionsPanel(param4);
            eventDispatcher.dispatchEvent(new MobileCanvasOptionsPanelEvent("showBuilidingOptionsPanel",gameRootHolder.gameRoot.mobileOptionsPanel = _loc9_));
            _loc5_.bounds.update();
            _loc6_ = gameRootHolder.gameRoot.cityGrid.getAppropriatePositionForNewConstruct(_loc5_.data.buildingTypeDIO.baseSize);
            _loc8_ = new Point3(_loc6_.x,_loc6_.y,0);
            (_loc5_.componentManager["MouseFollow"] as ConstructableMouseFollow).updateState(_loc8_);
            (_loc5_.componentManager["MouseFollow"] as BaseMouseFollow).disable();
            gameRootHolder.gameRoot.viewport.centerTo(_loc5_.position.projected.x,_loc5_.position.projected.y);
            if(!param4)
            {
               if(param1 == 31)
               {
                  gameRootHolder.gameRoot.screenPanning.addPoint(new Point3(_loc5_.position.projected.x + 250,_loc5_.position.projected.y - 150));
               }
               else if(param1 == 20)
               {
                  gameRootHolder.gameRoot.screenPanning.addPoint(new Point3(_loc5_.position.projected.x - 75,_loc5_.position.projected.y - 160));
               }
            }
            _loc7_ = new Dictionary();
            _loc7_["buildingTypeId"] = param1;
            eventDispatcher.dispatchEvent(new TutorialTriggerEvent("startBuild",_loc7_));
         }
      }
      
      public function startBuildDecoration(param1:DecorationVariationInfo, param2:Boolean = false) : void
      {
         var _loc3_:Decoration = null;
         var _loc4_:Point = null;
         var _loc5_:Point3 = null;
         if(gameRootHolder.gameRoot.canvasMode == CanvasMode.NORMAL)
         {
            gameRootHolder.gameRoot.canvasMode = CanvasMode.BUILD;
            gameRootHolder.gameRoot.multiBuildSoundPlayed = false;
            eventDispatcher.dispatchEvent(new PopUpWindowEvent("delayPopUps",null));
            _loc3_ = constructableFactory.createDecorationSilhouette(param1,param2);
            gameRootHolder.gameRoot.addChild(_loc3_);
            gameRootHolder.gameRoot.movingConstructable = _loc3_;
            _loc3_.init();
            gameRootHolder.gameRoot.manageConstructableFloorWithRenderings(true);
            gameRootHolder.gameRoot.grid.addView();
            _loc3_.viewManager.manageBuildingFloor(true);
            _loc3_.interactive = true;
            _loc3_.viewManager.drawMobileMoveArrows();
            eventDispatcher.dispatchEvent(new MobileConstructableOptionsEvent("mobileConstructableOptionsClose"));
            eventDispatcher.dispatchEvent(new MobileCanvasOptionsPanelEvent("showBuilidingOptionsPanel",gameRootHolder.gameRoot.mobileOptionsPanel = new MobileCanvasOptionsPanel()));
            _loc3_.bounds.update();
            _loc4_ = gameRootHolder.gameRoot.cityGrid.getAppropriatePositionForNewConstruct(_loc3_.data.dio.baseSize);
            _loc5_ = new Point3(_loc4_.x,_loc4_.y,0);
            (_loc3_.componentManager["MouseFollow"] as ConstructableMouseFollow).updateState(_loc5_);
            (_loc3_.componentManager["MouseFollow"] as BaseMouseFollow).disable();
            gameRootHolder.gameRoot.viewport.centerTo(_loc3_.position.projected.x,_loc3_.position.projected.y);
         }
      }
      
      public function startMove(param1:int) : void
      {
         gameRootHolder.gameRoot.startMove(param1);
      }
      
      public function upgradeFinished(param1:int) : void
      {
         var _loc2_:Building = gameRootHolder.gameRoot.buildings[param1];
         if(_loc2_)
         {
            if("BuildingUpgrade" in _loc2_.componentManager)
            {
               (_loc2_.componentManager["BuildingUpgrade"] as BuildingUpgrade).destroy();
            }
            _loc2_.viewManager.manageMainVisuals();
            _loc2_.viewManager.manageScaffolds();
            releaseWorker(param1);
            if(_loc2_.data.buildingTypeDIO.kind.id == 11 && !_loc2_.data.buildingInfo.incomplete)
            {
               _loc2_.viewManager.clearIndicator();
            }
         }
      }
      
      public function releaseWorker(param1:int) : void
      {
         var _loc4_:WorkerStatus = null;
         var _loc2_:Building = gameRootHolder.gameRoot.buildings[param1];
         if(_loc2_)
         {
            for each(var _loc3_ in gameRootHolder.gameRoot.workers)
            {
               _loc4_ = _loc3_.componentManager["WorkerStatus"] as WorkerStatus;
               if(_loc4_.attendingX == _loc2_.position.point.x && _loc4_.attendingY == _loc2_.position.point.y)
               {
                  _loc4_.stopWorking();
               }
            }
         }
      }
      
      public function fortificationUpgradeFinished(param1:int, param2:int) : void
      {
         var _loc3_:Building = gameRootHolder.gameRoot.buildings[param1];
         if(_loc3_)
         {
            if("BuildingUpgrade" in _loc3_.componentManager)
            {
               (_loc3_.componentManager["BuildingUpgrade"] as BuildingUpgrade).destroy();
            }
            _loc3_.data.calculateStats();
            _loc3_.viewManager.manageFortifications();
            releaseWorker(param1);
         }
      }
      
      public function startUpgrade(param1:int, param2:BuildingUpgradeJob) : void
      {
         var _loc3_:BuildingUpgrade = null;
         var _loc7_:Boolean = false;
         var _loc10_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:WorkerStatus = null;
         var _loc6_:int = 0;
         var _loc4_:Building = gameRootHolder.gameRoot.buildings[param1];
         if(_loc4_)
         {
            _loc3_ = new BuildingUpgrade(param2);
            _loc4_.componentManager.add(_loc3_);
            _loc3_.init();
            _loc3_.enable();
            _loc4_.viewManager.clearIndicator();
            _loc7_ = true;
            _loc10_ = _loc4_.position.point.x;
            _loc8_ = _loc4_.position.point.y;
            for each(var _loc5_ in gameRootHolder.gameRoot.workers)
            {
               _loc9_ = _loc5_.componentManager["WorkerStatus"] as WorkerStatus;
               if(_loc9_.attendingX == _loc10_ && _loc9_.attendingY == _loc8_)
               {
                  _loc7_ = false;
                  break;
               }
            }
            if(_loc7_)
            {
               _loc6_ = _loc4_.data.buildingTypeDIO.baseSize;
               _loc5_ = gameRootHolder.gameRoot.findNearestWorker(_loc10_ + _loc6_,_loc8_ + _loc6_);
               _loc9_ = _loc5_.componentManager["WorkerStatus"] as WorkerStatus;
               _loc9_.stopWorking();
               _loc5_.movement.clearWaypoint();
               _loc9_.busy = true;
               _loc9_.attendingCoordinates(_loc10_,_loc8_);
               _loc9_.walkAndWork(_loc10_,_loc8_,_loc6_);
               (_loc5_.componentManager["Speak"] as Speak).speak(param2.type == BuildingUpgradeJobType.UPGRADE ? SpeechType.WORKER_UPGRADE_START : SpeechType.WORKER_FORTIFY_START);
            }
         }
      }
      
      public function startRecruitment(param1:int, param2:UnitRecruitJob) : void
      {
         var _loc4_:UnitRecruit = null;
         var _loc3_:Building = gameRootHolder.gameRoot.buildings[param1];
         if(_loc3_)
         {
            _loc4_ = new UnitRecruit(param2);
            _loc3_.componentManager.add(_loc4_);
            _loc4_.init();
            _loc4_.enable();
         }
      }
      
      public function moveBuilding(param1:int, param2:Point, param3:int, param4:int) : void
      {
         var _loc10_:WorkerStatus = null;
         var _loc8_:int = 0;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc9_:Building = gameRootHolder.gameRoot.buildings[param1];
         (gameRootHolder.gameRoot.componentManager["CityGrid"] as CityGrid).unmarkBuilding(_loc9_.position.point.x,_loc9_.position.point.y,_loc9_.data);
         _loc9_.position.move(param2.x,param2.y,0);
         (gameRootHolder.gameRoot.componentManager["CityGrid"] as CityGrid).markBuilding(_loc9_.position.point.x,_loc9_.position.point.y,_loc9_.data);
         for each(var _loc7_ in gameRootHolder.gameRoot.workers)
         {
            _loc10_ = _loc7_.componentManager["WorkerStatus"] as WorkerStatus;
            if(_loc10_.attendingX == param3 && _loc10_.attendingY == param4 && _loc10_.busy)
            {
               _loc10_.attendingCoordinates(_loc9_.position.point.x,_loc9_.position.point.y);
               if(_loc7_.movement.enabled)
               {
                  _loc8_ = _loc9_.data.buildingTypeDIO.baseSize;
                  _loc10_.walkAndWork(_loc9_.position.point.x,_loc9_.position.point.y,_loc8_);
               }
               else
               {
                  _loc5_ = _loc7_.position.point.x - param3;
                  _loc6_ = _loc7_.position.point.y - param4;
                  _loc7_.position.move(_loc9_.position.point.x + _loc5_,_loc9_.position.point.y + _loc6_,0);
               }
            }
         }
      }
      
      public function activateFinished(param1:int) : void
      {
         var _loc2_:Building = gameRootHolder.gameRoot.buildings[param1];
         if(_loc2_)
         {
            _loc2_.viewManager.manageMainVisuals();
            _loc2_.viewManager.manageScaffolds();
            _loc2_.viewManager.clearIndicator();
         }
      }
      
      public function upgradeCancelled(param1:int) : void
      {
         var _loc2_:Building = gameRootHolder.gameRoot.buildings[param1];
         if(_loc2_)
         {
            if("BuildingUpgrade" in _loc2_.componentManager)
            {
               (_loc2_.componentManager["BuildingUpgrade"] as BuildingUpgrade).destroy();
            }
            releaseWorker(param1);
         }
      }
      
      public function cancelRecruitment(param1:int) : void
      {
         var _loc2_:Building = gameRootHolder.gameRoot.buildings[param1];
         if(_loc2_ && "UnitRecruit" in _loc2_.componentManager)
         {
            (_loc2_.componentManager["UnitRecruit"] as UnitRecruit).destroy();
         }
      }
      
      public function removeBuilding(param1:int) : void
      {
         var _loc2_:Building = gameRootHolder.gameRoot.buildings[param1];
         if(_loc2_)
         {
            (gameRootHolder.gameRoot.componentManager["CityGrid"] as CityGrid).unmarkBuilding(_loc2_.position.point.x,_loc2_.position.point.y,_loc2_.data);
            gameRootHolder.gameRoot.layers[3].remove(_loc2_);
            gameRootHolder.gameRoot.destroyChild(_loc2_);
            delete gameRootHolder.gameRoot.buildings[param1];
         }
      }
      
      public function removeDecoration(param1:int) : void
      {
         var _loc2_:Decoration = gameRootHolder.gameRoot.decorations[param1];
         if(_loc2_)
         {
            (gameRootHolder.gameRoot.componentManager["CityGrid"] as CityGrid).unmarkConstructable(_loc2_.position.point.x,_loc2_.position.point.y,_loc2_.data.dio.baseSize);
            gameRootHolder.gameRoot.layers[3].remove(_loc2_);
            gameRootHolder.gameRoot.destroyChild(_loc2_);
            delete gameRootHolder.gameRoot.decorations[param1];
         }
      }
      
      public function notifyHealthPointChangeOfABuilding(param1:int) : void
      {
         var _loc2_:Building = gameRootHolder.gameRoot.buildings[param1];
         if(_loc2_)
         {
            _loc2_.data.notifyHealthPointChange();
         }
      }
      
      public function setWorkerCount(param1:int) : void
      {
         unitFactory.setWorkerCount(param1);
         eventDispatcher.dispatchEvent(new WorkerUpdateEvent("updateCount"));
      }
      
      public function startRepair(param1:int, param2:BuildingRepairJob) : void
      {
         var _loc4_:BuildingRepair = null;
         var _loc3_:Building = gameRootHolder.gameRoot.buildings[param1];
         if(_loc3_)
         {
            _loc4_ = new BuildingRepair(param2);
            _loc3_.componentManager.add(_loc4_);
            _loc4_.init();
            _loc4_.enable();
         }
      }
      
      public function endRepair(param1:int) : void
      {
         var _loc2_:Building = gameRootHolder.gameRoot.buildings[param1];
         if(_loc2_ && "BuildingRepair" in _loc2_.componentManager)
         {
            (_loc2_.componentManager["BuildingRepair"] as BuildingRepair).destroy();
         }
      }
      
      public function manageBuildingBoundaryEnvironment(param1:int) : void
      {
         var _loc2_:Building = gameRootHolder.gameRoot.buildings[param1];
         _loc2_.viewManager.manageFortifications();
         _loc2_.viewManager.manageScaffolds();
         _loc2_.viewManager.manageSmokes();
      }
      
      public function assignUnitToBarracks(param1:UnitInfo) : void
      {
         var _loc3_:Building = null;
         var _loc2_:Unit = null;
         if(gameRootHolder.gameRoot.units[param1.instanceId])
         {
            _loc3_ = gameRootHolder.gameRoot.buildings[param1.buildingId];
            _loc2_ = gameRootHolder.gameRoot.units[param1.instanceId];
            if("Wander" in _loc2_.componentManager)
            {
               ((_loc2_.componentManager["Wander"] as Wander).keepingBuilding.componentManager["CombineBuildingChildManager"] as CombineBuildingChildManager).removeUnit(_loc2_);
               (_loc3_.componentManager["CombineBuildingChildManager"] as CombineBuildingChildManager).addUnit(_loc2_,true);
            }
            else
            {
               (_loc3_.componentManager["CombineBuildingChildManager"] as CombineBuildingChildManager).addUnit(_loc2_);
            }
         }
         else
         {
            unitFactory.addUnitToBarracks(param1,cityInfo.unitTypes[param1.typeId]);
         }
      }
      
      public function setUnits(param1:Vector.<UnitInfo>) : void
      {
         for each(var _loc2_ in param1)
         {
            if(_loc2_.status == UnitStatusType.IN_BARRACKS || _loc2_.status == UnitStatusType.IN_ALLIANCE_BARRACKS)
            {
               unitFactory.addUnitToBarracks(_loc2_,cityInfo.unitTypes[_loc2_.typeId]);
            }
         }
      }
      
      public function setBeast(param1:BeastInfo) : void
      {
         if(param1)
         {
            unitFactory.addBeastToCave(param1);
         }
      }
      
      public function hireUnitFromHiringQuartersToBarracks(param1:UnitInfo, param2:int) : void
      {
         if(param2 == -1)
         {
            for each(var _loc3_ in cityInfo.buildings)
            {
               if(_loc3_.buildingTypeId == 21)
               {
                  param2 = _loc3_.instanceId;
                  break;
               }
            }
         }
         if(param2 == -1)
         {
            for each(_loc3_ in cityInfo.buildings)
            {
               if(_loc3_.buildingTypeId == 20)
               {
                  param2 = _loc3_.instanceId;
                  break;
               }
            }
         }
         if(param2 == -1)
         {
            for each(_loc3_ in cityInfo.buildings)
            {
               if(_loc3_.buildingTypeId == 10)
               {
                  param2 = _loc3_.instanceId;
                  break;
               }
            }
         }
         unitFactory.addHiredUnitToBarracks(param1,cityInfo.unitTypes[param1.typeId],param2);
      }
      
      public function executeUnitInWatchPost(param1:UnitInfo) : void
      {
         var exeBuilding:Building;
         var building:Building;
         var sx:int;
         var sy:int;
         var unit:Unit;
         var unitInfo:UnitInfo = param1;
         var watchPost:Building = gameRootHolder.gameRoot.buildings[unitInfo.buildingId];
         for each(building in gameRootHolder.gameRoot.buildings)
         {
            if(building.data.buildingInfo.buildingTypeId == 27)
            {
               exeBuilding = building;
               break;
            }
         }
         if(!exeBuilding)
         {
            return;
         }
         sx = watchPost.position.point.x + 6;
         sy = watchPost.position.point.y + watchPost.data.buildingTypeDIO.baseSize;
         unit = unitFactory.addUnitToCanvas(unitInfo,cityInfo.unitTypes[unitInfo.typeId],sx,sy - watchPost.data.buildingTypeDIO.baseSize / 2);
         exeBuilding.viewManager.animation.startAnimation();
         unit.movement.addWaypoint(new Point3(sx,sy,0));
         unit.movement.movementFinished.addFunctionOnce(function(param1:Unit):void
         {
            Units.arrivedWatchPostDoor(param1,exeBuilding,gameRootHolder.gameRoot);
         });
      }
      
      public function notifyBeastModelChange(param1:BeastInfo) : void
      {
         var _loc2_:Unit = gameRootHolder.gameRoot.units[param1.instanceId];
         _loc2_.data.info = param1;
         _loc2_.viewManager.manageAll();
         _loc2_.init();
      }
      
      public function sendBeastToBeastCave(param1:BeastInfo) : void
      {
         var buildingInstanceId:int;
         var beastKeeper:Building;
         var beastCave:Building;
         var building:Building;
         var beast:Unit;
         var sx:int;
         var sy:int;
         var cbcm:CombineBuildingChildManager;
         var beastInfo:BeastInfo = param1;
         for each(building in gameRootHolder.gameRoot.buildings)
         {
            if(building.data.buildingTypeDIO.id == 29)
            {
               buildingInstanceId = building.data.buildingInfo.instanceId;
               beastCave = gameRootHolder.gameRoot.buildings[building.data.buildingInfo.instanceId];
            }
            if(building.data.buildingTypeDIO.id == 30)
            {
               beastKeeper = gameRootHolder.gameRoot.buildings[building.data.buildingInfo.instanceId];
            }
         }
         beast = gameRootHolder.gameRoot.units[beastInfo.instanceId];
         if(!beast)
         {
            sx = beastKeeper.position.point.x + 10;
            sy = beastKeeper.position.point.y + 15;
            beast = unitFactory.addBeastToCanvas(beastInfo,sx,sy);
         }
         cbcm = beastCave.componentManager["CombineBuildingChildManager"] as CombineBuildingChildManager;
         if("Wander" in beast.componentManager)
         {
            beast.aboutToBeKicked = false;
            beast.movement.clearWaypoint();
            (beast.componentManager["Wander"] as Wander).enable();
         }
         else
         {
            beast.movement.clearWaypoint();
            beast.movement.addWaypoint(new Point3(cbcm.gateCoord.x + beastCave.position.point.x,cbcm.gateCoord.y + beastCave.position.point.y,0));
            beast.movement.movementFinished.addFunctionOnce(function(param1:Unit):void
            {
               cbcm.addUnit(param1,true);
            });
         }
      }
      
      public function sendBeastToBeastKeeper(param1:BeastInfo) : void
      {
         var buildingInstanceId:int;
         var building:Building;
         var beast:Unit;
         var cbcm:CombineBuildingChildManager;
         var beastKeeper:Building;
         var beastInfo:BeastInfo = param1;
         for each(building in gameRootHolder.gameRoot.buildings)
         {
            if(building.data.buildingTypeDIO.id == 30)
            {
               buildingInstanceId = building.data.buildingInfo.instanceId;
               break;
            }
         }
         beast = gameRootHolder.gameRoot.units[beastInfo.instanceId];
         if("Wander" in beast.componentManager)
         {
            cbcm = (beast.componentManager["Wander"] as Wander).keepingBuilding.componentManager["CombineBuildingChildManager"] as CombineBuildingChildManager;
            (beast.componentManager["Wander"] as Wander).byeBye(cbcm,buildingInstanceId);
         }
         else
         {
            beastKeeper = gameRootHolder.gameRoot.buildings[buildingInstanceId];
            beast.movement.clearWaypoint();
            beast.movement.moveToPoint(new Point3(beastKeeper.position.point.x + beastKeeper.data.buildingTypeDIO.baseSize / 2,beastKeeper.position.point.y,0));
            beast.movement.movementFinished.addFunctionOnce(function(param1:Unit):void
            {
               Units.arrivedToBeastKeeper(param1,gameRootHolder.gameRoot);
            });
         }
      }
      
      public function executeUnitInBarracks(param1:int) : void
      {
         var buildingInstanceId:int;
         var building:Building;
         var unit:Unit;
         var cbcm:CombineBuildingChildManager;
         var build:Building;
         var unitInstanceId:int = param1;
         for each(building in gameRootHolder.gameRoot.buildings)
         {
            if(building.data.buildingTypeDIO.id == 27)
            {
               buildingInstanceId = building.data.buildingInfo.instanceId;
               break;
            }
         }
         (gameRootHolder.gameRoot.buildings[buildingInstanceId].componentManager["GuillotineData"] as GuillotineData).addUnit();
         unit = gameRootHolder.gameRoot.units[unitInstanceId];
         if("Wander" in unit.componentManager)
         {
            cbcm = (unit.componentManager["Wander"] as Wander).keepingBuilding.componentManager["CombineBuildingChildManager"] as CombineBuildingChildManager;
            (unit.componentManager["Wander"] as Wander).byeBye(cbcm,buildingInstanceId);
         }
         else
         {
            build = gameRootHolder.gameRoot.buildings[buildingInstanceId];
            unit.movement.moveToPoint(new Point3(build.position.point.x + build.data.buildingTypeDIO.baseSize / 2,build.position.point.y,0));
            unit.movement.movementFinished.addFunctionOnce(function(param1:Unit):void
            {
               Units.arrivedToExecution(param1,build,gameRootHolder.gameRoot);
            });
         }
         delete gameRootHolder.gameRoot.units[unit.data.info.instanceId];
      }
      
      public function transferUnitInBarracks(param1:int) : void
      {
         var building:Building;
         var unit:Unit;
         var cbcm:CombineBuildingChildManager;
         var build:Building;
         var unitInstanceId:int = param1;
         var buildingInstanceId:int = -1;
         var cityCenterId:int = -1;
         for each(building in gameRootHolder.gameRoot.buildings)
         {
            if(building.data.buildingTypeDIO.id == 42)
            {
               buildingInstanceId = building.data.buildingInfo.instanceId;
            }
            if(building.data.buildingTypeDIO.id == 10)
            {
               cityCenterId = building.data.buildingInfo.instanceId;
            }
         }
         if(buildingInstanceId == -1)
         {
            buildingInstanceId = cityCenterId;
         }
         unit = gameRootHolder.gameRoot.units[unitInstanceId];
         if("Wander" in unit.componentManager)
         {
            cbcm = (unit.componentManager["Wander"] as Wander).keepingBuilding.componentManager["CombineBuildingChildManager"] as CombineBuildingChildManager;
            (unit.componentManager["Wander"] as Wander).byeBye(cbcm,buildingInstanceId);
         }
         else
         {
            build = gameRootHolder.gameRoot.buildings[buildingInstanceId];
            unit.movement.moveToPoint(new Point3(build.position.point.x + build.data.buildingTypeDIO.baseSize / 2,build.position.point.y,0));
            unit.movement.movementFinished.addFunctionOnce(function(param1:Unit):void
            {
               Units.removeUponArrival(param1,gameRootHolder.gameRoot);
            });
         }
         delete gameRootHolder.gameRoot.units[unit.data.info.instanceId];
      }
      
      public function killUnitForBeast(param1:int, param2:int) : void
      {
         var cbcm:CombineBuildingChildManager;
         var build:Building;
         var unitInstanceId:int = param1;
         var targetBuildingInstanceId:int = param2;
         var unit:Unit = gameRootHolder.gameRoot.units[unitInstanceId];
         if("Wander" in unit.componentManager)
         {
            cbcm = (unit.componentManager["Wander"] as Wander).keepingBuilding.componentManager["CombineBuildingChildManager"] as CombineBuildingChildManager;
            (unit.componentManager["Wander"] as Wander).byeBye(cbcm,targetBuildingInstanceId);
         }
         else
         {
            build = gameRootHolder.gameRoot.buildings[targetBuildingInstanceId];
            unit.movement.moveToPoint(new Point3(build.position.point.x,build.position.point.y,0));
            unit.movement.movementFinished.addFunctionOnce(function(param1:Unit):void
            {
               Units.arrivedToBeast(param1,build,gameRootHolder.gameRoot);
            });
         }
         delete gameRootHolder.gameRoot.units[unit.data.info.instanceId];
      }
      
      public function deployUnitToWatchPostFromBarracks(param1:int, param2:int) : void
      {
         var cbcm:CombineBuildingChildManager;
         var build:Building;
         var x:int;
         var y:int;
         var unitInstanceId:int = param1;
         var watchPostInstanceId:int = param2;
         var unit:Unit = gameRootHolder.gameRoot.units[unitInstanceId];
         if("Wander" in unit.componentManager)
         {
            cbcm = (unit.componentManager["Wander"] as Wander).keepingBuilding.componentManager["CombineBuildingChildManager"] as CombineBuildingChildManager;
            (unit.componentManager["Wander"] as Wander).byeBye(cbcm,watchPostInstanceId);
         }
         else
         {
            build = gameRootHolder.gameRoot.buildings[watchPostInstanceId];
            x = build.position.point.x + 6;
            y = build.position.point.y + build.data.buildingTypeDIO.baseSize;
            unit.movement.moveToPoint(new Point3(x,y,0));
            unit.movement.movementFinished.addFunctionOnce(function(param1:Unit):void
            {
               Units.moveWatchPostFromWalk(param1.movement,build,x,y,param1,gameRootHolder.gameRoot);
            });
         }
         delete gameRootHolder.gameRoot.units[unit.data.info.instanceId];
      }
      
      public function deployUnitToWatchPostFromStore(param1:UnitInfo, param2:int) : void
      {
         var startbuilding:Building;
         var buildingTemp:Building;
         var buildingTemp2:Building;
         var startBuildingBaseSize:int;
         var sx:int;
         var sy:int;
         var newUnit:Unit;
         var targetbuild:Building;
         var tx:int;
         var ty:int;
         var unitInfo:UnitInfo = param1;
         var instanceId:int = param2;
         for each(buildingTemp in gameRootHolder.gameRoot.buildings)
         {
            if(buildingTemp.data.buildingTypeDIO.id == 20)
            {
               startbuilding = buildingTemp;
               break;
            }
         }
         if(startbuilding == null)
         {
            for each(buildingTemp2 in gameRootHolder.gameRoot.buildings)
            {
               if(buildingTemp2.data.buildingTypeDIO.id == 10)
               {
                  startbuilding = buildingTemp2;
                  break;
               }
            }
         }
         startBuildingBaseSize = startbuilding.data.buildingTypeDIO.baseSize;
         sx = startbuilding.position.point.x + startBuildingBaseSize;
         sy = startbuilding.position.point.y + startBuildingBaseSize;
         newUnit = unitFactory.addUnitToCanvas(unitInfo,cityInfo.unitTypes[unitInfo.typeId],sx,sy);
         targetbuild = gameRootHolder.gameRoot.buildings[instanceId];
         tx = targetbuild.position.point.x + 6;
         ty = targetbuild.position.point.y + targetbuild.data.buildingTypeDIO.baseSize;
         newUnit.movement.moveToPoint(new Point3(tx,ty,0));
         newUnit.movement.movementFinished.addFunctionOnce(function(param1:Unit):void
         {
            Units.moveWatchPostFromWalk(param1.movement,targetbuild,tx,ty,param1,gameRootHolder.gameRoot);
         });
      }
      
      public function startBattle() : void
      {
         gameRootHolder.gameRoot.startBattle();
         destroyAllDoodads();
      }
      
      public function setDeployDiameter(param1:int, param2:int) : void
      {
         gameRootHolder.gameRoot.battleManager.setDeployDiameter(param1,param2);
      }
      
      public function moveBuildingByPlanner(param1:int, param2:Point) : void
      {
         var _loc11_:WorkerStatus = null;
         var _loc7_:int = 0;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc8_:Building = gameRootHolder.gameRoot.buildings[param1];
         (gameRootHolder.gameRoot.componentManager["CityGrid"] as CityGrid).unmarkBuilding(_loc8_.position.point.x,_loc8_.position.point.y,_loc8_.data);
         var _loc10_:int = _loc8_.position.point.x;
         var _loc9_:int = _loc8_.position.point.y;
         _loc8_.position.move(param2.x,param2.y,0);
         gameRootHolder.gameRoot.cityGrid.markBuilding(param2.x,param2.y,_loc8_.data);
         _loc8_.init();
         for each(var _loc3_ in _loc8_.children)
         {
            _loc3_.init();
         }
         for each(var _loc6_ in gameRootHolder.gameRoot.workers)
         {
            _loc11_ = _loc6_.componentManager["WorkerStatus"] as WorkerStatus;
            if(_loc11_.attendingX == _loc10_ && _loc11_.attendingY == _loc9_ && _loc11_.busy)
            {
               _loc11_.attendingCoordinates(_loc8_.position.point.x,_loc8_.position.point.y);
               if(_loc6_.movement.enabled)
               {
                  _loc7_ = _loc8_.data.buildingTypeDIO.baseSize;
                  _loc11_.walkAndWork(_loc8_.position.point.x,_loc8_.position.point.y,_loc7_);
               }
               else
               {
                  _loc4_ = _loc6_.position.point.x - _loc10_;
                  _loc5_ = _loc6_.position.point.y - _loc9_;
                  _loc6_.position.move(_loc8_.position.point.x + _loc4_,_loc8_.position.point.y + _loc5_,0);
               }
            }
         }
      }
      
      public function moveDecorationByPlanner(param1:int, param2:Point) : void
      {
         var _loc4_:Decoration = gameRootHolder.gameRoot.decorations[param1];
         (gameRootHolder.gameRoot.componentManager["CityGrid"] as CityGrid).unmarkConstructable(_loc4_.position.point.x,_loc4_.position.point.y,_loc4_.data.dio.baseSize);
         _loc4_.position.move(param2.x,param2.y,0);
         gameRootHolder.gameRoot.cityGrid.markConstructable(param2.x,param2.y,_loc4_.data.dio.baseSize,_loc4_.data.owner);
         _loc4_.init();
         for each(var _loc3_ in _loc4_.children)
         {
            _loc3_.init();
         }
      }
      
      public function harvest(param1:int, param2:Number) : void
      {
         var _loc6_:ResourceType = null;
         var _loc5_:int = 0;
         var _loc4_:Building = gameRootHolder.gameRoot.buildings[param1];
         var _loc3_:BuildingTypeDIO = domainInfo.getBuilding(_loc4_.data.buildingInfo.buildingTypeId);
         if(_loc3_.kind.id == 11)
         {
            _loc6_ = _loc3_.buildingSpecificInfo[BuildingSpecificInfoType.PRODUCED_RESOURCE.id] as ResourceType;
            _loc5_ = 0;
            switch(_loc6_.id)
            {
               case ResourceType.LUMBER.id:
                  _loc5_ = 7;
                  break;
               case ResourceType.STONE.id:
                  _loc5_ = 8;
                  break;
               case ResourceType.MIGHT.id:
                  _loc5_ = 9;
                  break;
               case ResourceType.IRON.id:
                  _loc5_ = 10;
            }
            gameRootHolder.gameRoot.displayFloatingText(getBuildingProjectedMiddlePoint(_loc4_),_loc5_,"" + param2);
            eventDispatcher.dispatchEvent(new ResourceBarAnimationEvent("startAnimation",_loc6_,param2));
         }
      }
      
      public function raiseRP(param1:int) : void
      {
         var _loc2_:Building = gameRootHolder.gameRoot.buildings[param1];
         gameRootHolder.gameRoot.displayFloatingText(getBuildingProjectedMiddlePoint(_loc2_),12,"","RP");
      }
      
      public function lootResource(param1:int, param2:ResourceType, param3:int) : void
      {
         var _loc4_:Building = gameRootHolder.gameRoot.buildings[param1];
         var _loc5_:int = 0;
         switch(param2.id)
         {
            case ResourceType.LUMBER.id:
               _loc5_ = 3;
               break;
            case ResourceType.STONE.id:
               _loc5_ = 4;
               break;
            case ResourceType.MIGHT.id:
               _loc5_ = 5;
               break;
            case ResourceType.IRON.id:
               _loc5_ = 6;
         }
         gameRootHolder.gameRoot.displayFloatingText(getBuildingProjectedMiddlePoint(_loc4_),_loc5_,"" + param3,null,_loc4_.data.lootTextStacker);
      }
      
      public function lootPart(param1:int, param2:int) : void
      {
         var _loc3_:Building = gameRootHolder.gameRoot.buildings[param1];
         gameRootHolder.gameRoot.displayFloatingText(getBuildingProjectedMiddlePoint(_loc3_),13,"+1","CollectedPart");
      }
      
      public function handleCatapultAction(param1:int, param2:int) : void
      {
         gameRootHolder.gameRoot.battleManager.handleCatapultDeployment(param1,param2);
      }
      
      public function recalculateAllUnitStats() : void
      {
         for each(var _loc1_ in gameRootHolder.gameRoot.units)
         {
            _loc1_.data.calculateStats();
         }
      }
      
      public function manageResourceProducerAnimations() : void
      {
         var _loc4_:Number = NaN;
         var _loc7_:int = 0;
         var _loc3_:Number = NaN;
         var _loc6_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc5_:Number = NaN;
         if(userInfo.gameMode != GameModeType.NORMAL)
         {
            return;
         }
         for each(var _loc1_ in gameRootHolder.gameRoot.buildings)
         {
            if(_loc1_.data.buildingTypeDIO.kind.id == 11)
            {
               _loc4_ = Number(_loc1_.data.buildingInfo.buildingSpecificInfo[BuildingSpecificInfoType.UNHARVESTED_RESOURCE.id]);
               _loc7_ = _loc1_.data.buildingInfo.level == 0 ? 0 : _loc1_.data.buildingInfo.level - 1;
               _loc3_ = Number(_loc1_.data.buildingTypeDIO.buildingSpecificInfo[BuildingSpecificInfoType.STORAGE_CAPACITIES_PER_LEVEL.id][_loc7_]);
               _loc6_ = _loc1_.data.buildingTypeDIO.isHealthy(_loc1_.data.buildingInfo.level,_loc1_.data.buildingInfo.healthPoint);
               _loc2_ = _loc4_ < _loc3_ && _loc6_ && !("BuildingUpgrade" in _loc1_.componentManager || "BuildingRepair" in _loc1_.componentManager);
               if(_loc2_)
               {
                  _loc1_.viewManager.startAnimation();
                  _loc5_ = Number(MobilePreSelectCommand.RESOURCE_PRODUCER_ONE_TAP_BARRIERS[_loc7_]);
                  if(_loc4_ > _loc5_)
                  {
                     _loc1_.viewManager.drawIndicator((_loc1_.data.buildingTypeDIO.buildingSpecificInfo[BuildingSpecificInfoType.PRODUCED_RESOURCE.id] as ResourceType).name + "Full");
                  }
                  else
                  {
                     _loc1_.viewManager.clearIndicator();
                  }
               }
               else
               {
                  if(!("BuildingUpgrade" in _loc1_.componentManager || "BuildingRepair" in _loc1_.componentManager))
                  {
                     if(_loc6_)
                     {
                        _loc1_.viewManager.drawIndicator((_loc1_.data.buildingTypeDIO.buildingSpecificInfo[BuildingSpecificInfoType.PRODUCED_RESOURCE.id] as ResourceType).name + "Full");
                     }
                     else
                     {
                        _loc1_.viewManager.clearIndicator();
                     }
                  }
                  _loc1_.viewManager.stopAnimation();
               }
            }
         }
         manageIncompleteBuildingIndicators();
      }
      
      public function manageTrainingChamberAnimations() : void
      {
         var _loc3_:Boolean = false;
         for each(var _loc1_ in gameRootHolder.gameRoot.buildings)
         {
            if(_loc1_.data.buildingTypeDIO.id == 18)
            {
               _loc3_ = false;
               for each(var _loc2_ in cityInfo.unitTrainJobs)
               {
                  if(_loc2_.instanceId == _loc1_.data.buildingInfo.instanceId)
                  {
                     _loc3_ = true;
                     break;
                  }
               }
               if(_loc3_)
               {
                  _loc1_.viewManager.startAnimation();
               }
               else
               {
                  _loc1_.viewManager.stopAnimation();
               }
            }
         }
      }
      
      public function manageTrainingChamberIndicators() : void
      {
         var _loc3_:Boolean = false;
         for each(var _loc1_ in gameRootHolder.gameRoot.buildings)
         {
            if(_loc1_.data.buildingTypeDIO.id == 18 && !("BuildingRepair" in _loc1_.componentManager || "BuildingUpgrade" in _loc1_.componentManager))
            {
               _loc3_ = false;
               for each(var _loc2_ in cityInfo.unitTrainJobs)
               {
                  if(_loc2_.instanceId == _loc1_.data.buildingInfo.instanceId)
                  {
                     if(_loc2_.jobCreationTime + _loc2_.durationRemaining - new Date().getTime() < 300000)
                     {
                        _loc1_.viewManager.drawIndicator("SpeedupIcon");
                     }
                     _loc3_ = true;
                     break;
                  }
               }
               if(!_loc3_)
               {
                  _loc1_.viewManager.clearIndicator();
               }
            }
         }
      }
      
      public function manageRecruitmentChamberIndicator() : void
      {
         for each(var _loc1_ in gameRootHolder.gameRoot.buildings)
         {
            if(_loc1_.data.buildingTypeDIO.id == 17 && !("BuildingRepair" in _loc1_.componentManager || "BuildingUpgrade" in _loc1_.componentManager))
            {
               if(cityInfo.activeRecruitJob && cityInfo.activeRecruitJob.jobCreationTime + cityInfo.activeRecruitJob.durationRemaining - new Date().getTime() < 300000)
               {
                  _loc1_.viewManager.drawIndicator("SpeedupIcon");
               }
               else
               {
                  _loc1_.viewManager.clearIndicator();
               }
            }
         }
      }
      
      public function manageHiringQuartersAnimations() : void
      {
         var _loc3_:Boolean = false;
         for each(var _loc2_ in cityInfo.hiringInfoDictionary)
         {
            var _loc1_:Building = gameRootHolder.gameRoot.buildings[_loc2_.hiringBuildingInstanceId];
            if(_loc1_)
            {
               if(_loc2_.activeHiring && !_loc2_.isHiringPaused)
               {
                  _loc3_ = true;
                  _loc1_.viewManager.startAnimation();
               }
               else
               {
                  _loc1_.viewManager.stopAnimation();
               }
            }
         }
         for each(_loc1_ in gameRootHolder.gameRoot.buildings)
         {
            if(_loc1_.data.buildingTypeDIO.id == 21)
            {
               if(_loc3_)
               {
                  _loc1_.viewManager.startAnimation();
               }
               else
               {
                  _loc1_.viewManager.stopAnimation();
               }
               break;
            }
         }
      }
      
      public function manageBlacksmithAnimation() : void
      {
         var _loc4_:* = undefined;
         var _loc2_:Boolean = false;
         var _loc5_:BuildingViewManager = null;
         for each(var _loc3_ in cityInfo.buildings)
         {
            if(_loc3_.buildingTypeId == 44)
            {
               _loc4_ = _loc3_.buildingSpecificInfo[BuildingSpecificInfoType.EVENT_ITEM_INVENTORY.id];
               _loc2_ = false;
               for each(var _loc1_ in _loc4_)
               {
                  if(_loc1_.getRemainingDuration() > 0)
                  {
                     _loc2_ = true;
                     break;
                  }
               }
               _loc5_ = (gameRootHolder.gameRoot.buildings[_loc3_.instanceId] as Building).viewManager;
               _loc2_ ? _loc5_.startAnimation() : _loc5_.stopAnimation();
               return;
            }
         }
      }
      
      public function manageCityCenterIndicatorStatus() : void
      {
         for each(var _loc1_ in gameRootHolder.gameRoot.buildings)
         {
            if(_loc1_.data.buildingInfo.buildingTypeId == 10)
            {
               if(!_loc1_.data.buildingInfo.incomplete && _loc1_.data.buildingTypeDIO.isHealthy(_loc1_.data.buildingInfo.level,_loc1_.data.buildingInfo.healthPoint))
               {
                  if(getTimer() - cityInfo.goldCapacity.updatedTimer >= cityInfo.goldCapacity.remainingTime)
                  {
                     _loc1_.viewManager.drawIndicator("GoldFull");
                  }
                  else
                  {
                     _loc1_.viewManager.clearIndicator();
                  }
               }
            }
         }
      }
      
      public function manageMercenaryBarracksNotEnoughSpaceIndicator() : void
      {
         var _loc1_:Boolean = false;
         for each(var _loc3_ in cityInfo.hiringInfoDictionary)
         {
            if(_loc3_.isHiringPaused && _loc3_.pauseReason == HiringPauseReasonType.BARRACKS_CAPACITY_FULL)
            {
               if(!_loc1_)
               {
                  _loc1_ = _loc3_.isHiringPaused;
               }
            }
         }
         for each(var _loc2_ in gameRootHolder.gameRoot.buildings)
         {
            if(_loc2_.data.buildingInfo.buildingTypeId == 19 && !("BuildingUpgrade" in _loc2_.componentManager || "BuildingRepair" in _loc2_.componentManager))
            {
               if(_loc1_)
               {
                  _loc2_.viewManager.drawIndicator("BarracksFull");
               }
               else
               {
                  _loc2_.viewManager.clearIndicator();
               }
            }
         }
      }
      
      public function manageIncompleteBuildingIndicators() : void
      {
         var _loc4_:BuildingInfo = null;
         var _loc8_:BuildingTypeDIO = null;
         var _loc1_:int = 0;
         var _loc6_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc10_:* = undefined;
         var _loc9_:Boolean = false;
         var _loc5_:PartInfoDTO = null;
         var _loc7_:Boolean = false;
         if(userInfo.gameMode != GameModeType.NORMAL)
         {
            return;
         }
         for each(var _loc2_ in gameRootHolder.gameRoot.buildings)
         {
            _loc4_ = _loc2_.data.buildingInfo;
            if(_loc4_.incomplete && !("BuildingUpgrade" in _loc2_.componentManager || "BuildingRepair" in _loc2_.componentManager))
            {
               _loc8_ = _loc2_.data.buildingTypeDIO;
               if(_loc8_.isHealthy(_loc4_.level,_loc4_.healthPoint))
               {
                  if(_loc4_.buildingTypeId == 10)
                  {
                     _loc1_ = int(_loc4_.staffs != null ? _loc4_.staffs.length : 0);
                     _loc6_ = int((_loc8_.buildingSpecificInfo[BuildingSpecificInfoType.STAFF_PREREQUISITES_PER_LEVEL.id][_loc4_.level >= _loc8_.maxLevels ? _loc8_.maxLevels - 1 : _loc4_.level] as Vector.<StaffDIO>).length);
                     if(_loc1_ == _loc6_)
                     {
                        _loc2_.viewManager.drawIndicator("FinishBuildingIcon");
                     }
                     else
                     {
                        _loc2_.viewManager.clearIndicator();
                     }
                  }
                  else
                  {
                     _loc11_ = 0;
                     _loc12_ = 0;
                     while(_loc12_ < cityInfo.buildings.length)
                     {
                        if(cityInfo.buildings[_loc12_].buildingTypeId == _loc4_.buildingTypeId)
                        {
                           if(!cityInfo.buildings[_loc12_].incomplete)
                           {
                              _loc11_++;
                           }
                        }
                        _loc12_++;
                     }
                     _loc10_ = _loc8_.buildingSpecificInfo[BuildingSpecificInfoType.PART_REQUIREMENTS_PER_LEVEL.id][_loc11_];
                     _loc9_ = true;
                     _loc12_ = 0;
                     while(_loc12_ < _loc10_.length)
                     {
                        _loc5_ = _loc10_[_loc12_];
                        _loc7_ = false;
                        for each(var _loc3_ in userInfo.items)
                        {
                           if(_loc3_.category == InventoryItemCategory.PARTS && _loc3_.id == _loc5_.id)
                           {
                              _loc7_ = true;
                              if(_loc9_)
                              {
                                 _loc9_ = _loc5_.amount <= _loc3_.amount;
                              }
                           }
                        }
                        if(!_loc7_)
                        {
                           _loc9_ = false;
                           break;
                        }
                        _loc12_++;
                     }
                     if(_loc9_)
                     {
                        _loc2_.viewManager.drawIndicator("FinishBuildingIcon");
                     }
                     else
                     {
                        _loc2_.viewManager.clearIndicator();
                     }
                  }
               }
               else
               {
                  _loc2_.viewManager.clearIndicator();
               }
            }
         }
      }
      
      public function manageStockpileAnimations() : void
      {
         var _loc2_:Number = 0;
         for each(var _loc3_ in ResourceType.resourceTypes)
         {
            _loc2_ += cityInfo.resourceAmounts[_loc3_.id];
         }
         for each(var _loc1_ in gameRootHolder.gameRoot.buildings)
         {
            if(_loc1_.data.buildingTypeDIO.kind.id == 12)
            {
               _loc1_.viewManager.setAnimationFrameFromPercentage(_loc2_ / cityInfo.totalResourceCapacity);
            }
         }
      }
      
      public function stopResourceAnimation(param1:int) : void
      {
         var _loc2_:Building = gameRootHolder.gameRoot.buildings[param1];
         if(_loc2_)
         {
            _loc2_.viewManager.stopAnimation();
            _loc2_.viewManager.drawIndicator((_loc2_.data.buildingTypeDIO.buildingSpecificInfo[BuildingSpecificInfoType.PRODUCED_RESOURCE.id] as ResourceType).name + "Full");
         }
      }
      
      public function drawIndicator(param1:int, param2:String) : void
      {
         var _loc3_:Building = gameRootHolder.gameRoot.buildings[param1];
         if(_loc3_)
         {
            _loc3_.viewManager.drawIndicator(param2);
         }
      }
      
      public function retreatBeast() : void
      {
         gameRootHolder.gameRoot.battleManager.retreatBeast();
      }
      
      public function displayBuildingDamage(param1:int, param2:int) : void
      {
         var _loc3_:Building = gameRootHolder.gameRoot.buildings[param1];
         gameRootHolder.gameRoot.displayFloatingText(getBuildingProjectedMiddlePoint(_loc3_),1,"" + param2,null,_loc3_.data.damageTextStacker);
      }
      
      public function determineHelpableStatusOfBuildings() : void
      {
         var _loc10_:int = 0;
         var _loc12_:int = 0;
         var _loc16_:Number = NaN;
         var _loc7_:String = null;
         var _loc11_:Number = NaN;
         var _loc18_:int = 0;
         var _loc9_:Number = NaN;
         if(visitInfo.landlord.gameId in userInfo.helpCountDictionary && userInfo.helpCountDictionary[visitInfo.landlord.gameId] >= 4)
         {
            return;
         }
         if(!(visitInfo.landlord.isNpc && visitInfo.landlord.npcId == "NPC_5") && userInfo.helpedUserCounts >= DefaultVisitInfo.MAX_VISIT_LIMIT && !(visitInfo.landlord.gameId in userInfo.helpCountDictionary && userInfo.helpCountDictionary[visitInfo.landlord.gameId] > 0))
         {
            return;
         }
         var _loc17_:int = 4 - userInfo.helpCountDictionary[visitInfo.landlord.gameId];
         var _loc6_:Dictionary = new Dictionary();
         for each(var _loc8_ in cityInfo.buildingRepairJobs)
         {
            if(!(visitInfo.landlord.gameId in userInfo.helpedBuildingsDictionary && _loc8_.instanceId in userInfo.helpedBuildingsDictionary[visitInfo.landlord.gameId]))
            {
               _loc6_[_loc8_.instanceId] = _loc8_.jobCreationTime + _loc8_.durationRemaining - new Date().getTime();
            }
         }
         for each(var _loc1_ in cityInfo.buildingUpgradeJobs)
         {
            if(!(_loc1_.instanceId in _loc6_))
            {
               if(!(visitInfo.landlord.gameId in userInfo.helpedBuildingsDictionary && _loc1_.instanceId in userInfo.helpedBuildingsDictionary[visitInfo.landlord.gameId]))
               {
                  _loc6_[_loc1_.instanceId] = _loc1_.jobCreationTime + _loc1_.durationRemaining - new Date().getTime();
               }
            }
         }
         for each(var _loc14_ in cityInfo.unitTrainJobs)
         {
            if(!(_loc14_.instanceId in _loc6_))
            {
               if(!(visitInfo.landlord.gameId in userInfo.helpedBuildingsDictionary && _loc14_.instanceId in userInfo.helpedBuildingsDictionary[visitInfo.landlord.gameId]))
               {
                  var _loc2_:Building = gameRootHolder.gameRoot.buildings[_loc14_.instanceId];
                  if(_loc2_.data.buildingTypeDIO.isHealthy(_loc2_.data.buildingInfo.level,_loc2_.data.buildingInfo.healthPoint))
                  {
                     _loc6_[_loc14_.instanceId] = _loc14_.jobCreationTime + _loc14_.durationRemaining - new Date().getTime();
                  }
               }
            }
         }
         if(cityInfo.activeRecruitJob)
         {
            for each(var _loc13_ in cityInfo.buildings)
            {
               if(_loc13_.buildingTypeId == 17)
               {
                  if(!(_loc13_.instanceId in _loc6_))
                  {
                     _loc2_ = gameRootHolder.gameRoot.buildings[_loc13_.instanceId];
                     if(_loc2_.data.buildingTypeDIO.isHealthy(_loc2_.data.buildingInfo.level,_loc2_.data.buildingInfo.healthPoint))
                     {
                        if(!(visitInfo.landlord.gameId in userInfo.helpedBuildingsDictionary && _loc13_.instanceId in userInfo.helpedBuildingsDictionary[visitInfo.landlord.gameId]))
                        {
                           _loc6_[_loc13_.instanceId] = cityInfo.activeRecruitJob.jobCreationTime + cityInfo.activeRecruitJob.durationRemaining - new Date().getTime();
                        }
                     }
                  }
                  break;
               }
            }
         }
         var _loc5_:Vector.<int> = new Vector.<int>();
         _loc10_ = 0;
         while(_loc10_ < _loc17_)
         {
            _loc12_ = 0;
            _loc16_ = 0;
            _loc7_ = null;
            for(var _loc3_ in _loc6_)
            {
               _loc12_++;
               if(_loc6_[_loc3_] > _loc16_)
               {
                  _loc7_ = _loc3_;
                  _loc16_ = Number(_loc6_[_loc3_]);
               }
            }
            if(_loc12_ == 0)
            {
               break;
            }
            _loc5_.push(int(_loc7_));
            delete _loc6_[_loc7_];
            _loc10_++;
         }
         var _loc15_:Dictionary = new Dictionary();
         _loc10_ = int(_loc5_.length);
         while(_loc10_ < _loc17_)
         {
            _loc11_ = -Infinity;
            for each(_loc2_ in gameRootHolder.gameRoot.buildings)
            {
               if(_loc2_.data.buildingTypeDIO.kind.id == 11 && _loc2_.data.buildingTypeDIO.isHealthy(_loc2_.data.buildingInfo.level,_loc2_.data.buildingInfo.healthPoint) && !(_loc2_.data.buildingInfo.instanceId in _loc15_) && !("BuildingUpgrade" in _loc2_.componentManager) && !("BuildingRepair" in _loc2_.componentManager) && !_loc2_.data.buildingInfo.incomplete && !(visitInfo.landlord.gameId in userInfo.helpedBuildingsDictionary && _loc2_.data.buildingInfo.instanceId in userInfo.helpedBuildingsDictionary[visitInfo.landlord.gameId]))
               {
                  _loc9_ = (cityInfo.totalResourceCapacity >> 2) - (cityInfo.resourceAmounts[(_loc2_.data.buildingTypeDIO.buildingSpecificInfo[BuildingSpecificInfoType.PRODUCED_RESOURCE.id] as ResourceType).id] + _loc2_.data.buildingInfo.buildingSpecificInfo[BuildingSpecificInfoType.UNHARVESTED_RESOURCE.id]);
                  if(_loc9_ > _loc11_)
                  {
                     _loc11_ = _loc9_;
                     _loc18_ = _loc2_.data.buildingInfo.instanceId;
                  }
               }
            }
            if(_loc11_ <= -Infinity)
            {
               break;
            }
            _loc5_.push(_loc18_);
            _loc15_[_loc18_] = true;
            _loc10_++;
         }
         for each(var _loc4_ in _loc5_)
         {
            _loc2_ = gameRootHolder.gameRoot.buildings[_loc4_];
            _loc2_.data.helpable = true;
            _loc2_.viewManager.drawIndicator("RPFull");
         }
      }
      
      public function removeHelpableStatusOfBuilding(param1:int) : void
      {
         var _loc2_:Building = null;
         if(param1 in gameRootHolder.gameRoot.buildings)
         {
            _loc2_ = gameRootHolder.gameRoot.buildings[param1];
            _loc2_.data.helpable = false;
            _loc2_.viewManager.clearIndicator();
         }
      }
      
      private function removeHelpableStatusOfAllBuildings() : void
      {
         for each(var _loc1_ in gameRootHolder.gameRoot.buildings)
         {
            _loc1_.data.helpable = false;
            _loc1_.viewManager.clearIndicator();
         }
      }
      
      public function getCenterOfCityPosition() : Point
      {
         return new Point(-gameRootHolder.gameRoot.viewport.rect.x,-gameRootHolder.gameRoot.viewport.rect.y);
      }
      
      public function getBuildingPositionByInstanceId(param1:int) : Point
      {
         var building:Building;
         var buildingInstanceId:int = param1;
         if(buildingInstanceId in gameRootHolder.gameRoot.buildings)
         {
            building = gameRootHolder.gameRoot.buildings[buildingInstanceId];
            building.bounds.update();
            if(!(buildingInstanceId in buildingsPendingAsset))
            {
               building.viewManager.mainVisual.assetLoaded.addFunctionOnce(function():void
               {
                  building.bounds.update();
                  eventDispatcher.dispatchEvent(new TutorialTriggerEvent("defaultActionTriggered"));
                  delete buildingsPendingAsset[buildingInstanceId];
               });
               buildingsPendingAsset[buildingInstanceId] = true;
            }
            return new Point(building.bounds.point.x,building.bounds.point.y);
         }
         return null;
      }
      
      public function getBuildingPositionByTypeId(param1:int) : Point
      {
         var _loc2_:Building = null;
         for(var _loc3_ in gameRootHolder.gameRoot.buildings)
         {
            _loc2_ = gameRootHolder.gameRoot.buildings[_loc3_];
            if(_loc2_.data.buildingTypeDIO.id == param1)
            {
               return getBuildingPositionByInstanceId(int(_loc3_));
            }
         }
         return null;
      }
      
      public function getBuildingProgressBarPosition(param1:int) : Point
      {
         var _loc2_:Building = null;
         if(param1 in gameRootHolder.gameRoot.buildings)
         {
            _loc2_ = gameRootHolder.gameRoot.buildings[param1];
            if(_loc2_.viewManager.upgradeProgressBar != null)
            {
               _loc2_.viewManager.upgradeProgressBar.bounds.update();
               return new Point(_loc2_.viewManager.upgradeProgressBar.bounds.point.x,_loc2_.viewManager.upgradeProgressBar.bounds.point.y);
            }
         }
         return null;
      }
      
      public function drawMobileTutorialArrowByTypeId(param1:int, param2:int = 0, param3:int = 0, param4:String = "TutorialArrowDownM") : void
      {
         var _loc5_:Building = getBuildingByTypeId(param1);
         if(_loc5_ != null)
         {
            _loc5_.viewManager.drawMobileTutorialArrow(param2,param3,param4);
         }
      }
      
      public function clearMobileTutorialArrowByTypeId(param1:int) : void
      {
         var _loc2_:Building = getBuildingByTypeId(param1);
         if(_loc2_ != null)
         {
            _loc2_.viewManager.clearMobileTutorialArrow();
         }
      }
      
      public function drawMobileTutorialArrowByInstanceId(param1:String, param2:int = 0, param3:int = 0, param4:String = "TutorialArrowDownM") : void
      {
         var _loc5_:Building = getBuildingByInstanceId(param1);
         if(_loc5_ != null)
         {
            _loc5_.viewManager.drawMobileTutorialArrow(param2,param3,param4);
         }
      }
      
      public function clearMobileTutorialArrowByInstanceId(param1:String) : void
      {
         var _loc2_:Building = getBuildingByInstanceId(param1);
         if(_loc2_ != null)
         {
            _loc2_.viewManager.clearMobileTutorialArrow();
         }
      }
      
      public function deployNPCUnits(param1:Number, param2:Number, param3:NPCAttackDirection) : void
      {
         gameRootHolder.gameRoot.battleManager.deployNPC(param1,param2,param3);
      }
      
      public function prepareNPCAttack() : void
      {
         for each(var _loc4_ in gameRootHolder.gameRoot.decorations)
         {
            gameRootHolder.gameRoot.cityGrid.unmarkConstructable(_loc4_.position.point.x,_loc4_.position.point.y,_loc4_.data.dio.baseSize);
         }
         for each(var _loc3_ in gameRootHolder.gameRoot.buildings)
         {
            _loc3_.viewManager.clearIndicator();
            if(_loc3_.data.buildingInfo.isTrap)
            {
               gameRootHolder.gameRoot.cityGrid.unmarkBuilding(_loc3_.position.point.x,_loc3_.position.point.y,_loc3_.data);
            }
         }
         for each(var _loc2_ in gameRootHolder.gameRoot.units)
         {
            if(_loc2_.aboutToBeKicked || !("Wander" in _loc2_.componentManager))
            {
               _loc2_.movement.movementFinished.dispatch(_loc2_);
            }
         }
         for each(var _loc1_ in gameRootHolder.gameRoot.children)
         {
            if(_loc1_ is Unit)
            {
               _loc2_ = _loc1_ as Unit;
               if(!(_loc2_.data is WorkerData))
               {
                  gameRootHolder.gameRoot.removeChild(_loc2_);
                  gameRootHolder.gameRoot.layers[3].remove(_loc2_);
                  _loc2_.componentManager.destroyAll();
                  delete gameRootHolder.gameRoot.units[_loc2_.data.info.instanceId];
               }
            }
         }
         gameRootHolder.gameRoot.removeCagedBeast();
      }
      
      public function notifyBeastHealthChange() : void
      {
         var _loc1_:Unit = gameRootHolder.gameRoot.units[cityInfo.beast.instanceId];
         if(_loc1_ && _loc1_.viewManager && _loc1_.viewManager.initialized)
         {
            _loc1_.viewManager.manageHealthProgressBar();
         }
      }
      
      public function changeBloodEffectSetting(param1:Boolean) : void
      {
         gameRootHolder.gameRoot.bloodDisabled = !param1;
      }
      
      public function closeBuildingTooltip() : void
      {
         gameRootHolder.gameRoot.closeBuildingTooltip();
      }
      
      public function panToCenter() : void
      {
         gameRootHolder.gameRoot.screenPanning.addPointToCenter();
      }
      
      public function getBuildingByInstanceId(param1:String) : Building
      {
         var _loc2_:Building = null;
         for(var _loc3_ in gameRootHolder.gameRoot.buildings)
         {
            if(_loc3_ == param1)
            {
               _loc2_ = gameRootHolder.gameRoot.buildings[_loc3_];
               _loc2_.bounds.update();
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getBuildingByTypeId(param1:int) : Building
      {
         var _loc2_:Building = null;
         for(var _loc3_ in gameRootHolder.gameRoot.buildings)
         {
            _loc2_ = gameRootHolder.gameRoot.buildings[_loc3_];
            if(_loc2_.data.buildingTypeDIO.id == param1)
            {
               _loc2_.bounds.update();
               return _loc2_;
            }
         }
         return null;
      }
      
      public function panToBuildingByTypeId(param1:int, param2:int = 0, param3:int = 0) : void
      {
         var _loc4_:Building = getBuildingByTypeId(param1);
         if(_loc4_ != null)
         {
            gameRootHolder.gameRoot.screenPanning.addPoint(new Point3(_loc4_.position.projected.x + param2,_loc4_.position.projected.y + param3));
         }
      }
      
      public function centerToBuildingByTypeId(param1:int, param2:int = 0, param3:int = 0) : void
      {
         var _loc4_:Building = getBuildingByTypeId(param1);
         if(_loc4_ != null)
         {
            gameRootHolder.gameRoot.viewport.centerTo(_loc4_.position.projected.x + param2,_loc4_.position.projected.y + param3);
         }
      }
      
      public function zoomIn() : void
      {
         gameRootHolder.gameRoot.render.zoomIn();
      }
      
      public function zoomOut() : void
      {
         gameRootHolder.gameRoot.render.zoomOut();
      }
      
      public function startSpying() : void
      {
         for each(var _loc1_ in gameRootHolder.gameRoot.buildings)
         {
            if(_loc1_.data.buildingInfo.isTrap)
            {
               _loc1_.componentManager.add(_loc1_.viewManager = new BuildingViewManager(_loc1_,_loc1_.data.buildingTypeDIO));
               _loc1_.viewManager.init();
               gameRootHolder.gameRoot.layers[3].add(_loc1_);
            }
         }
         removeHelpableStatusOfAllBuildings();
      }
      
      public function endSpying() : void
      {
         for each(var _loc1_ in gameRootHolder.gameRoot.buildings)
         {
            if(_loc1_.data.buildingInfo.isTrap)
            {
               _loc1_.viewManager.destroy();
            }
         }
      }
      
      public function addTerrain(param1:Array) : void
      {
         gameRootHolder.gameRoot.addTerrain(param1);
      }
      
      public function destroyAllDoodads() : void
      {
         gameRootHolder.gameRoot.destroyAllDoodads();
      }
      
      public function updateAllianceFlags() : void
      {
         for each(var _loc2_ in gameRootHolder.gameRoot.decorations)
         {
            if(_loc2_.data.dio.id == 115)
            {
               _loc2_.viewManager.manageMainVisual();
            }
         }
         for each(var _loc1_ in gameRootHolder.gameRoot.buildings)
         {
            if(_loc1_.data.buildingTypeDIO.id == 43)
            {
               _loc1_.viewManager.manageMainVisuals();
            }
         }
      }
      
      public function removeCityExpansionSigns() : void
      {
         for each(var _loc1_ in gameRootHolder.gameRoot.expandSigns)
         {
            (gameRootHolder.gameRoot.componentManager["CityGrid"] as CityGrid).unmarkBuilding(_loc1_.position.point.x,_loc1_.position.point.y,_loc1_.data);
            gameRootHolder.gameRoot.removeChild(_loc1_);
            gameRootHolder.gameRoot.layers[3].remove(_loc1_);
            gameRootHolder.gameRoot.destroyChild(_loc1_);
         }
         gameRootHolder.gameRoot.expandSigns = new Dictionary();
      }
      
      public function buildCityExpansionSigns() : void
      {
         var _loc9_:Rectangle = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc11_:Boolean = false;
         var _loc2_:int = 0;
         var _loc16_:int = 0;
         var _loc7_:int = 0;
         var _loc17_:int = 0;
         var _loc15_:int = 0;
         var _loc1_:Point = null;
         var _loc10_:BuildingInfo = null;
         var _loc5_:BuildingTypeInfo = null;
         var _loc14_:Building = null;
         removeCityExpansionSigns();
         if(!userInfo.mandatoryTutorialCompleted)
         {
            return;
         }
         if(cityInfo.dimensions.numberOfColumns >= 295)
         {
            return;
         }
         var _loc13_:int = 20;
         var _loc8_:Array = ["N","S","E","W"];
         var _loc12_:BuildingTypeDIO = new ExpandSignTypeDIO();
         var _loc6_:int = _loc12_.baseSize;
         _loc3_ = 0;
         while(_loc3_ < _loc8_.length)
         {
            _loc4_ = _loc8_[_loc3_];
            _loc11_ = false;
            _loc2_ = _loc4_ == "N" || _loc4_ == "S" ? cityInfo.dimensions.numberOfColumns >> 1 : cityInfo.dimensions.numberOfRows >> 1;
            _loc16_ = _loc4_ == "N" || _loc4_ == "S" ? cityInfo.dimensions.numberOfRows >> 1 : cityInfo.dimensions.numberOfColumns >> 1;
            _loc7_ = 0;
            while(_loc7_ < _loc2_)
            {
               _loc17_ = _loc4_ == "N" || _loc4_ == "S" ? _loc7_ - (_loc6_ >> 1) : (_loc16_ + _loc13_) * (_loc4_ == "E" ? 1 : -1) - (_loc6_ >> 1);
               _loc15_ = _loc4_ == "N" || _loc4_ == "S" ? (_loc16_ + _loc13_) * (_loc4_ == "N" ? 1 : -1) - (_loc6_ >> 1) : _loc7_ - (_loc6_ >> 1);
               _loc9_ = new Rectangle(_loc17_,_loc15_,_loc6_,_loc6_);
               _loc11_ = !gameRootHolder.gameRoot.cityGrid.checkCollision(_loc9_,100);
               if(!_loc11_)
               {
                  if(_loc4_ == "N" || _loc4_ == "S")
                  {
                     _loc9_.x = -_loc7_ - (_loc6_ >> 1);
                  }
                  else
                  {
                     _loc9_.y = -_loc7_ - (_loc6_ >> 1);
                  }
                  _loc11_ = !gameRootHolder.gameRoot.cityGrid.checkCollision(_loc9_,100);
               }
               if(_loc11_)
               {
                  break;
               }
               _loc7_++;
            }
            if(_loc11_)
            {
               _loc1_ = new Point(_loc9_.x,_loc9_.y);
               _loc10_ = new BuildingInfo(1,100001 + _loc3_,100001,-1,_loc1_);
               _loc5_ = new BuildingTypeInfo(100001,1,1);
               _loc14_ = constructableFactory.createBuilding(_loc10_,_loc12_,_loc5_,null,null);
               gameRootHolder.gameRoot.expandSigns[_loc3_] = _loc14_;
               gameRootHolder.gameRoot.addChild(_loc14_);
               _loc14_.init();
               gameRootHolder.gameRoot.cityGrid.markBuilding(_loc9_.x,_loc9_.y,_loc14_.data);
            }
            _loc3_++;
         }
      }
      
      public function buildBeastCage() : void
      {
         var _loc7_:Rectangle = null;
         var _loc13_:int = 0;
         gameRootHolder.gameRoot.removeCagedBeast();
         if(!userInfo.mandatoryTutorialCompleted)
         {
            return;
         }
         if(userInfo.tutorialsInfo.additionalInfo.beastCageStatus == 10)
         {
            return;
         }
         if(!cityInfo.dimensions)
         {
            return;
         }
         for each(var _loc10_ in cityInfo.buildings)
         {
            if(_loc10_.buildingTypeId == 29)
            {
               userInfo.tutorialsInfo.additionalInfo.beastCageStatus = 10;
               eventDispatcher.dispatchEvent(new TutorialEvent("saveTutorialsToServer"));
               return;
            }
         }
         var _loc5_:int = 18;
         var _loc14_:int = 10;
         var _loc11_:Boolean = false;
         var _loc6_:Array = [1,-1];
         _loc13_ = 0;
         while(_loc13_ < cityInfo.dimensions.numberOfColumns >> 1)
         {
            for each(var _loc16_ in _loc6_)
            {
               for each(var _loc15_ in _loc6_)
               {
                  _loc7_ = new Rectangle(_loc13_ * _loc16_ - _loc5_ / 2,_loc15_ * ((cityInfo.dimensions.numberOfRows >> 1) + _loc14_) + _loc5_ / 2 * (_loc15_ - 1),_loc5_,_loc5_);
                  _loc11_ = !gameRootHolder.gameRoot.cityGrid.checkCollision(_loc7_,100);
                  if(_loc11_)
                  {
                     break;
                  }
               }
               if(_loc11_)
               {
                  break;
               }
            }
            if(_loc11_)
            {
               break;
            }
            _loc13_++;
         }
         if(!_loc11_)
         {
            return;
         }
         var _loc1_:Point = new Point(_loc7_.x,_loc7_.y);
         var _loc4_:BuildingInfo = new BuildingInfo(1,100000,100000,-1,_loc1_);
         var _loc3_:BuildingTypeDIO = new BeastCageTypeDIO();
         var _loc9_:BuildingTypeInfo = new BuildingTypeInfo(100000,1,1);
         gameRootHolder.gameRoot.beastCage = constructableFactory.createBuilding(_loc4_,_loc3_,_loc9_,null,null);
         gameRootHolder.gameRoot.addChild(gameRootHolder.gameRoot.beastCage);
         gameRootHolder.gameRoot.beastCage.init();
         gameRootHolder.gameRoot.cityGrid.markBuilding(_loc7_.x,_loc7_.y,gameRootHolder.gameRoot.beastCage.data);
         var _loc8_:Array = [27,25,26];
         var _loc12_:int = int(_loc8_[int(Math.random() * 3)]);
         var _loc2_:UnitInfo = new BeastInfo(DefaultUnitFactory.generateUnitId(),UnitStatusType.IN_CAGE,_loc4_.instanceId,_loc12_,domainInfo.getBeast(_loc12_).healthPointsPerStage[2],0,6,false,3);
         gameRootHolder.gameRoot.cagedBeast = unitFactory.createUnit(_loc2_,null,0,0,0,false);
         (gameRootHolder.gameRoot.beastCage.componentManager["CombineBuildingChildManager"] as CombineBuildingChildManager).addUnit(gameRootHolder.gameRoot.cagedBeast);
         gameRootHolder.gameRoot.cagedBeast.init();
      }
      
      public function freeCagedBeast(param1:int) : void
      {
         userInfo.tutorialsInfo.additionalInfo.beastCageStatus = 10;
         eventDispatcher.dispatchEvent(new TutorialEvent("saveTutorialsToServer"));
         (gameRootHolder.gameRoot.cagedBeast.componentManager["Wander"] as Wander).byeBye(gameRootHolder.gameRoot.beastCage.componentManager["CombineBuildingChildManager"] as CombineBuildingChildManager,param1);
      }
      
      public function mobileConfirmCanvasOperation() : void
      {
         if(gameRootHolder.gameRoot.canvasMode == CanvasMode.MOVE)
         {
            gameRootHolder.gameRoot.finishMove();
         }
         else if(gameRootHolder.gameRoot.canvasMode == CanvasMode.BUILD)
         {
            gameRootHolder.gameRoot.finishBuild();
         }
         else if(gameRootHolder.gameRoot.canvasMode == CanvasMode.MOBILE_CATAPULT)
         {
            gameRootHolder.gameRoot.battleManager.deploy();
         }
         else if(gameRootHolder.gameRoot.canvasMode == CanvasMode.MOBILE_SIEGE_TOWER)
         {
            gameRootHolder.gameRoot.eventItemsManager.buildWarBuilding(0,0);
         }
      }
      
      public function mobileCancelCanvasOperation() : void
      {
         if(gameRootHolder.gameRoot.canvasMode == CanvasMode.MOVE)
         {
            gameRootHolder.gameRoot.cancelMove();
         }
         else if(gameRootHolder.gameRoot.canvasMode == CanvasMode.BUILD)
         {
            gameRootHolder.gameRoot.exitBuildMode();
         }
         else if(gameRootHolder.gameRoot.canvasMode == CanvasMode.MOBILE_CATAPULT)
         {
            setDeployDiameter(0,2);
         }
         else if(gameRootHolder.gameRoot.canvasMode == CanvasMode.MOBILE_SIEGE_TOWER)
         {
            gameRootHolder.gameRoot.eventItemsManager.cancelDeployWarBuilding();
         }
      }
      
      public function createFakeMobileDeployCircle(param1:Point) : void
      {
         if(gameRootHolder.gameRoot.battleManager)
         {
            gameRootHolder.gameRoot.battleManager.createNewDeployWave(param1,false,0);
         }
      }
   }
}

