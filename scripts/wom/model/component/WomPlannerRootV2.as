package wom.model.component
{
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.Layer;
   import peak.cuckoo.game.Root;
   import peak.cuckoo.game.attribute.Position;
   import peak.cuckoo.game.attribute.Viewport;
   import peak.cuckoo.game.attribute.view.AssetView;
   import peak.cuckoo.game.behavior.ScreenPan;
   import peak.cuckoo.game.behavior.StarlingTouchInteract;
   import peak.cuckoo.game.behavior.cull.ViewingFrustumCull;
   import peak.cuckoo.game.behavior.render.BaseRender;
   import peak.cuckoo.game.behavior.sort.ZSort;
   import peak.cuckoo.game.dto.Point3;
   import peak.resource.SoundPlayer;
   import peak.resource.atlas.starling.StarlingAtlasReference;
   import peak.signal.Signal0;
   import wom.model.component.attribute.data.PlannerBuildingData;
   import wom.model.component.attribute.data.PlannerConstructableData;
   import wom.model.component.attribute.data.PlannerDecorationData;
   import wom.model.component.attribute.grid.PlannerGrid;
   import wom.model.component.attribute.projection.PlannerProjection;
   import wom.model.component.attribute.viewManager.PlannerBuildingViewManager;
   import wom.model.component.attribute.viewManager.PlannerDecorationViewManager;
   import wom.model.component.behavior.mouse.follow.PlannerMouseFollower;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.component.entity.gamesprite.Decoration;
   import wom.model.component.entity.gamesprite.PlannerBuilding;
   import wom.model.component.enum.BuildingTypeHolder;
   import wom.model.component.enum.ConstructableTypeHolder;
   import wom.model.component.enum.DecorationTypeHolder;
   import wom.model.component.enum.PlannerBuildingGroupPositioning;
   import wom.model.component.enum.PlannerConstructableGroupPositioning;
   import wom.model.dto.PlannerBuildingDTO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.WomGameRootHolder;
   import wom.model.resource.WomAssetRepository;
   
   public class WomPlannerRootV2 extends Root
   {
      
      public static const SCALE_CONSTANT:int = 3;
      
      public static const BACKGROUND_WIDTH:int = 2250;
      
      public static const BACKGROUND_HEIGHT:int = 1500;
      
      private const CROSSHAIR_SIZE:int = 16;
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var gameRootHolder:WomGameRootHolder;
      
      [Inject]
      public var soundPlayer:SoundPlayer;
      
      public var buildings:Vector.<PlannerBuilding>;
      
      public var screenPan:ScreenPan;
      
      private var archerRangesActive:Boolean;
      
      private var cannonRangesActive:Boolean;
      
      private var gatlingRangesActive:Boolean;
      
      private var flamerRangesActive:Boolean;
      
      private var skyRangesActive:Boolean;
      
      private var mirrorRangesActive:Boolean;
      
      private var watchPostRangesActive:Boolean;
      
      private var beastRangesActive:Boolean;
      
      private var beastCannonRangesActive:Boolean;
      
      public var mouseFollower:PlannerMouseFollower;
      
      public var plannerGrid:PlannerGrid;
      
      public var inspectedBuilding:PlannerBuilding;
      
      public var inspectedBuildingChanged:Signal0;
      
      private var visualgrid:GameSprite;
      
      private var _cityBoundsAssetId:String = "CityGreenFloor";
      
      public function WomPlannerRootV2()
      {
         super();
         buildings = new Vector.<PlannerBuilding>();
         componentManager.add(screenPan = new ScreenPan());
         componentManager.add(userInteract = new StarlingTouchInteract());
         componentManager.add(viewport = new Viewport(new Rectangle(-1125,-750,2250,1500)));
         componentManager.add(render = BaseRender.getRender(4));
         componentManager.add(mouseFollower = new PlannerMouseFollower());
         createLayers();
         plannerGrid = new PlannerGrid();
         inspectedBuildingChanged = new Signal0();
      }
      
      override public function init() : void
      {
         super.init();
         userInteract.click.addFunction(onTouch);
         userInteract.moveDrag.addFunction(onMoveDrag);
         userInteract.mouseUp.addFunction(onTouchUp);
         cannonRangesActive = false;
         archerRangesActive = false;
         gatlingRangesActive = false;
         flamerRangesActive = false;
         skyRangesActive = false;
         mirrorRangesActive = false;
         watchPostRangesActive = false;
         beastRangesActive = false;
         beastCannonRangesActive = false;
         plannerGrid.city = city;
         plannerGrid.init();
         render.zoomReset();
         getCurrentCitySnapShot();
         prepareBackground();
      }
      
      private function onPickedEntitiyChanged() : void
      {
         if(userInteract.pickedEntity && userInteract.pickedEntity is PlannerBuilding)
         {
            inspectedBuilding = userInteract.pickedEntity as PlannerBuilding;
         }
         else
         {
            inspectedBuilding = null;
         }
         inspectedBuildingChanged.dispatch();
      }
      
      private function onCtrlMouseClick() : void
      {
         var _loc1_:PlannerBuilding = null;
         if(mouseFollower.enabled)
         {
            mouseFollower.stopDrag();
         }
         else if(userInteract.pickedEntity && userInteract.pickedEntity is PlannerBuilding)
         {
            _loc1_ = userInteract.pickedEntity as PlannerBuilding;
            mouseFollower.selectBuilding(_loc1_,true);
         }
      }
      
      private function onMouseClick() : void
      {
         var _loc1_:PlannerBuilding = null;
         if(mouseFollower.enabled)
         {
            mouseFollower.stopDrag();
         }
         else if(userInteract.pickedEntity && userInteract.pickedEntity is PlannerBuilding)
         {
            _loc1_ = userInteract.pickedEntity as PlannerBuilding;
            mouseFollower.selectBuilding(_loc1_);
            mouseFollower.startDrag();
         }
      }
      
      private function onTouch() : void
      {
         var _loc1_:PlannerBuilding = null;
         if(userInteract.pickedEntity && userInteract.pickedEntity is PlannerBuilding)
         {
            _loc1_ = userInteract.pickedEntity as PlannerBuilding;
            mouseFollower.selectBuilding(_loc1_,true);
         }
         else
         {
            mouseFollower.deselectAll();
            inspectedBuilding = null;
         }
         inspectedBuildingChanged.dispatch();
      }
      
      private function onMoveDrag() : void
      {
         if(userInteract.pickedEntity && userInteract.pickedEntity is PlannerBuilding && mouseFollower.isSelected(userInteract.pickedEntity as PlannerBuilding))
         {
            if(!mouseFollower.enabled)
            {
               mouseFollower.startDrag();
            }
            mouseFollower.onSignal0();
         }
         else
         {
            viewport.moveTo(userInteract.grabbedCanvasPoint.x - userInteract.moveDiff.x,userInteract.grabbedCanvasPoint.y - userInteract.moveDiff.y);
         }
      }
      
      private function onTouchUp() : void
      {
         if(mouseFollower.enabled)
         {
            mouseFollower.stopDrag(false);
         }
      }
      
      private function createPlannerBuilding(param1:GameSprite, param2:Point3) : PlannerBuilding
      {
         var _loc4_:Decoration = null;
         var _loc3_:Building = null;
         var _loc5_:PlannerBuilding = new PlannerBuilding();
         if(param1 is Decoration)
         {
            _loc4_ = param1 as Decoration;
            _loc5_.componentManager.add(_loc5_.data = new PlannerDecorationData(_loc4_));
            _loc5_.componentManager.add(_loc5_.viewManager = new PlannerDecorationViewManager(_loc5_,_loc4_.data));
         }
         else
         {
            _loc3_ = param1 as Building;
            _loc5_.componentManager.add(_loc5_.data = new PlannerBuildingData(_loc3_));
            _loc5_.componentManager.add(_loc5_.viewManager = new PlannerBuildingViewManager(_loc5_,_loc3_.data));
         }
         _loc5_.componentManager.add(_loc5_.position = new Position(param2));
         _loc5_.componentManager.add(new PlannerProjection());
         _loc5_.interactive = true;
         _loc5_.data.startPoint = new Point(_loc5_.position.point.x,_loc5_.position.point.y);
         addChild(_loc5_);
         _loc5_.init();
         layers[3].add(_loc5_);
         buildings.push(_loc5_);
         if(plannerGrid.checkCollision(_loc5_))
         {
            _loc5_.data.collide = true;
            _loc5_.viewManager.setCollision(true);
         }
         plannerGrid.markArea(_loc5_);
         return _loc5_;
      }
      
      public function getPlannerSnapShot(param1:Boolean = false) : Dictionary
      {
         var _loc3_:PlannerConstructableData = null;
         var _loc2_:PlannerBuildingData = null;
         var _loc6_:PlannerDecorationData = null;
         var _loc4_:Dictionary = new Dictionary();
         for each(var _loc5_ in buildings)
         {
            _loc3_ = _loc5_.data;
            if(_loc3_ is PlannerDecorationData)
            {
               _loc6_ = _loc3_ as PlannerDecorationData;
               if(!param1 || (_loc6_.decoration.position.point.x != _loc5_.position.point.x || _loc6_.decoration.position.point.y != _loc5_.position.point.y))
               {
                  _loc4_[_loc6_.decorationData.info.instanceId] = new PlannerBuildingDTO(_loc6_.decorationData.info.instanceId,_loc5_.position);
               }
            }
            else
            {
               _loc2_ = _loc3_ as PlannerBuildingData;
               if(!param1 || (_loc2_.building.position.point.x != _loc5_.position.point.x || _loc2_.building.position.point.y != _loc5_.position.point.y))
               {
                  _loc4_[_loc2_.buildingData.buildingInfo.instanceId] = new PlannerBuildingDTO(_loc2_.buildingData.buildingInfo.instanceId,_loc5_.position);
               }
            }
         }
         return _loc4_;
      }
      
      public function displayPlannerSnapShot(param1:Dictionary) : void
      {
         var _loc2_:Building = null;
         var _loc5_:Decoration = null;
         destroyAllBuildings();
         var _loc3_:Dictionary = new Dictionary();
         for each(_loc2_ in gameRootHolder.gameRoot.buildings)
         {
            _loc3_[_loc2_.data.buildingInfo.instanceId] = true;
         }
         for each(_loc5_ in gameRootHolder.gameRoot.decorations)
         {
            _loc3_[_loc5_.data.info.instanceId] = true;
         }
         for each(var _loc4_ in param1)
         {
            if(_loc4_.instanceId in gameRootHolder.gameRoot.decorations)
            {
               _loc5_ = gameRootHolder.gameRoot.decorations[_loc4_.instanceId] as Decoration;
               createPlannerBuilding(_loc5_,_loc4_.position.point);
            }
            else
            {
               _loc2_ = gameRootHolder.gameRoot.buildings[_loc4_.instanceId] as Building;
               createPlannerBuilding(_loc2_,_loc4_.position.point);
            }
            _loc3_[_loc4_.instanceId] = false;
         }
         var _loc9_:int = 0;
         var _loc7_:Number = city.dimensions.numberOfRows / 2;
         var _loc8_:int = city.dimensions.numberOfColumns / 2;
         var _loc6_:int = city.dimensions.numberOfRows / -2;
         for each(_loc2_ in gameRootHolder.gameRoot.buildings)
         {
            if(_loc3_[_loc2_.data.buildingInfo.instanceId])
            {
               createPlannerBuilding(_loc2_,new Point3(_loc8_,_loc6_));
               _loc6_ += _loc2_.data.buildingTypeDIO.baseSize + 1;
               if(_loc2_.data.buildingTypeDIO.baseSize > _loc9_)
               {
                  _loc9_ = _loc2_.data.buildingTypeDIO.baseSize;
               }
               if(_loc6_ > _loc7_)
               {
                  _loc8_ += _loc9_ + 1;
                  _loc6_ = city.dimensions.numberOfRows / -2;
                  _loc9_ = 0;
               }
            }
         }
         for each(_loc5_ in gameRootHolder.gameRoot.decorations)
         {
            if(_loc3_[_loc5_.data.info.instanceId])
            {
               createPlannerBuilding(_loc5_,new Point3(_loc8_,_loc6_));
               _loc6_ += _loc5_.data.dio.baseSize + 1;
               if(_loc5_.data.dio.baseSize > _loc9_)
               {
                  _loc9_ = _loc5_.data.dio.baseSize;
               }
               if(_loc6_ > _loc7_)
               {
                  _loc8_ += _loc9_ + 1;
                  _loc6_ = city.dimensions.numberOfRows / -2;
                  _loc9_ = 0;
               }
            }
         }
         checkCollision();
      }
      
      private function getCurrentCitySnapShot() : void
      {
         destroyAllBuildings();
         for each(var _loc1_ in gameRootHolder.gameRoot.buildings)
         {
            createPlannerBuilding(_loc1_,new Point3(_loc1_.position.point.x,_loc1_.position.point.y));
         }
         for each(var _loc2_ in gameRootHolder.gameRoot.decorations)
         {
            createPlannerBuilding(_loc2_,new Point3(_loc2_.position.point.x,_loc2_.position.point.y));
         }
         checkCollision();
      }
      
      public function checkCollision() : void
      {
         var _loc2_:Boolean = false;
         for each(var _loc1_ in buildings)
         {
            _loc2_ = plannerGrid.checkPigeonHole(_loc1_);
            if(_loc2_ != _loc1_.data.collide)
            {
               _loc1_.data.collide = _loc2_;
               _loc1_.viewManager.setCollision(_loc2_);
            }
         }
      }
      
      public function zoomOut() : void
      {
         render.zoomOut();
      }
      
      public function zoomIn() : void
      {
         render.zoomIn();
      }
      
      private function toggleRanges() : void
      {
         var _loc2_:int = 0;
         var _loc1_:PlannerConstructableData = null;
         for each(var _loc3_ in buildings)
         {
            _loc1_ = _loc3_.data;
            if(_loc1_ is PlannerDecorationData)
            {
               _loc2_ = (_loc1_ as PlannerDecorationData).decorationData.dio.id;
            }
            else
            {
               _loc2_ = (_loc1_ as PlannerBuildingData).buildingData.buildingTypeDIO.id;
            }
            if(_loc2_ == 31 && archerRangesActive || _loc2_ == 32 && cannonRangesActive || _loc2_ == 34 && gatlingRangesActive || _loc2_ == 33 && flamerRangesActive || _loc2_ == 35 && skyRangesActive || _loc2_ == 36 && mirrorRangesActive || _loc2_ == 37 && watchPostRangesActive || _loc2_ == 38 && watchPostRangesActive || _loc2_ == 29 && beastRangesActive || _loc2_ == 45 && beastCannonRangesActive)
            {
               _loc3_.viewManager.addRange();
            }
            else
            {
               _loc3_.viewManager.removeRange();
            }
         }
      }
      
      public function toggleArcherRanges(param1:Boolean) : void
      {
         archerRangesActive = param1;
         toggleRanges();
      }
      
      public function toggleBeastCannonRanges(param1:Boolean) : void
      {
         beastCannonRangesActive = param1;
         toggleRanges();
      }
      
      public function toggleCannonRanges(param1:Boolean) : void
      {
         cannonRangesActive = param1;
         toggleRanges();
      }
      
      public function toggleGatlingRanges(param1:Boolean) : void
      {
         gatlingRangesActive = param1;
         toggleRanges();
      }
      
      public function toggleFlamerRanges(param1:Boolean) : void
      {
         flamerRangesActive = param1;
         toggleRanges();
      }
      
      public function toggleSkyRanges(param1:Boolean) : void
      {
         skyRangesActive = param1;
         toggleRanges();
      }
      
      public function toggleMirrorRanges(param1:Boolean) : void
      {
         mirrorRangesActive = param1;
         toggleRanges();
      }
      
      public function toggleWatchPostRanges(param1:Boolean) : void
      {
         watchPostRangesActive = param1;
         toggleRanges();
      }
      
      public function toggleBeastRanges(param1:Boolean) : void
      {
         beastRangesActive = param1;
         toggleRanges();
      }
      
      public function toggleGrids(param1:Boolean) : void
      {
      }
      
      public function isLayoutValid() : Boolean
      {
         for each(var _loc1_ in buildings)
         {
            if(_loc1_.data.collide)
            {
               return false;
            }
         }
         return true;
      }
      
      public function isPlanChanged() : Boolean
      {
         for each(var _loc1_ in buildings)
         {
            if(_loc1_.data.startPoint.x != _loc1_.position.point.x || _loc1_.data.startPoint.y != _loc1_.position.point.y)
            {
               return true;
            }
         }
         return false;
      }
      
      public function refreshBuildingsStartPoint() : void
      {
         for each(var _loc1_ in buildings)
         {
            _loc1_.data.startPoint.x = _loc1_.position.point.x;
            _loc1_.data.startPoint.y = _loc1_.position.point.y;
         }
      }
      
      public function clearCityLayout() : void
      {
         var _loc2_:PlannerConstructableData = null;
         var _loc4_:int = 0;
         var _loc1_:int = 0;
         var _loc8_:PlannerConstructableGroupPositioning = null;
         var _loc7_:Dictionary = new Dictionary();
         var _loc5_:DecorationTypeHolder = new DecorationTypeHolder();
         for each(var _loc6_ in buildings)
         {
            _loc2_ = _loc6_.data;
            if(_loc2_ is PlannerDecorationData)
            {
               _loc5_.addBuilding(_loc6_);
            }
            else
            {
               _loc4_ = (_loc2_ as PlannerBuildingData).buildingData.buildingTypeDIO.id;
               if(BuildingTypeHolder.positioningMap[_loc4_])
               {
                  _loc1_ = (BuildingTypeHolder.positioningMap[_loc4_] as PlannerBuildingGroupPositioning).groupType;
                  if(!_loc7_[_loc1_])
                  {
                     _loc7_[_loc1_] = new BuildingTypeHolder(_loc1_);
                  }
                  (_loc7_[_loc1_] as BuildingTypeHolder).addBuilding(_loc6_);
               }
            }
         }
         for each(var _loc3_ in _loc7_)
         {
            _loc8_ = BuildingTypeHolder.positioningMap[_loc3_.typeId] as PlannerConstructableGroupPositioning;
            movePlannerBuilding(_loc3_,_loc8_.x,_loc8_.y,_loc8_.side);
         }
         _loc8_ = DecorationTypeHolder.positioning;
         movePlannerBuilding(_loc5_,_loc8_.x,_loc8_.y,_loc8_.side);
         checkCollision();
      }
      
      private function movePlannerBuilding(param1:ConstructableTypeHolder, param2:int, param3:int, param4:Boolean) : void
      {
         var _loc5_:int = 25;
         for each(var _loc6_ in param1.buildings)
         {
            if(param4)
            {
               param2 += -_loc6_.data.baseSize;
            }
            plannerGrid.unmarkArea(_loc6_);
            _loc6_.position.move(param2,param3,0);
            plannerGrid.markArea(_loc6_);
            if(!param4)
            {
               param2 += _loc6_.data.baseSize;
            }
            if(--_loc5_ == 0)
            {
               _loc5_ = 25;
               if(param1 is DecorationTypeHolder)
               {
                  param2 = DecorationTypeHolder.positioning.x;
               }
               else
               {
                  param2 = (BuildingTypeHolder.positioningMap[(param1 as BuildingTypeHolder).typeId] as PlannerConstructableGroupPositioning).x;
               }
               param3 += _loc6_.data.baseSize;
            }
         }
      }
      
      private function prepareBackground() : void
      {
         visualgrid = new GameSprite();
         visualgrid.componentManager.add(visualgrid.position = new Position(new Point3(city.dimensions.numberOfColumns / -2,city.dimensions.numberOfRows / -2,0)));
         visualgrid.componentManager.add(visualgrid.view = new AssetView(2,_cityBoundsAssetId,true));
         visualgrid.componentManager.add(new PlannerProjection());
         addChild(visualgrid);
         layers[2].add(visualgrid);
         visualgrid.init();
         var _loc1_:StarlingAtlasReference = atlasManager.getAtlasReference(_cityBoundsAssetId);
         var _loc7_:int = city.dimensions.numberOfColumns * 3;
         var _loc2_:int = city.dimensions.numberOfRows * 3;
         var _loc4_:Number = _loc7_ / _loc1_.width;
         var _loc5_:Number = _loc2_ / _loc1_.height;
         var _loc6_:Matrix = new Matrix();
         var _loc8_:Number = (_loc7_ - _loc1_.width) / 2;
         var _loc3_:Number = (_loc2_ - _loc1_.height) / 2;
         _loc6_.scale(_loc4_,_loc5_);
         _loc6_.translate(_loc8_,_loc3_);
         visualgrid.view.applyMatrix(_loc6_);
      }
      
      override protected function createLayers() : void
      {
         layers = [];
         var _loc1_:Layer = new Layer(2);
         layers[2] = _loc1_;
         addChild(_loc1_);
         _loc1_ = new Layer(3);
         _loc1_.componentManager.add(_loc1_.cull = new ViewingFrustumCull());
         _loc1_.componentManager.add(_loc1_.sort = new ZSort());
         layers[3] = _loc1_;
         addChild(_loc1_);
         _loc1_ = new Layer(4);
         layers[4] = _loc1_;
         addChild(_loc1_);
      }
      
      private function destroyAllBuildings() : void
      {
         for each(var _loc1_ in buildings)
         {
            plannerGrid.unmarkArea(_loc1_);
            layers[_loc1_.view.layerId].remove(_loc1_);
            destroyChild(_loc1_);
         }
         buildings.length = 0;
      }
      
      public function terminate() : void
      {
         var _loc2_:GameSprite = null;
         destroyAllBuildings();
         userInteract.click.removeAll();
         userInteract.ctrlClick.removeAll();
         userInteract.pickedEntityChanged.removeAll();
         inspectedBuildingChanged.removeAll();
         var _loc1_:Vector.<GameSprite> = layers[2].allChildrenContainer.children;
         while(_loc1_.length > 0)
         {
            _loc2_ = _loc1_[0];
            layers[2].remove(_loc2_);
            destroyChild(_loc2_);
         }
      }
      
      override public function reset() : void
      {
         terminate();
      }
      
      public function updateDimensions() : void
      {
         plannerGrid.city = city;
         checkCollision();
         render.zoomReset();
         prepareBackground();
      }
      
      public function removeRecycledBuilding(param1:int) : void
      {
         var _loc2_:PlannerBuilding = null;
         var _loc4_:int = 0;
         var _loc3_:PlannerBuilding = null;
         _loc4_ = 0;
         while(_loc4_ < buildings.length)
         {
            _loc3_ = buildings[_loc4_];
            if(_loc3_.data is PlannerBuildingData)
            {
               if((_loc3_.data as PlannerBuildingData).buildingData.buildingInfo.instanceId == param1)
               {
                  _loc2_ = _loc3_;
                  break;
               }
            }
            else if(_loc3_.data is PlannerDecorationData)
            {
               if((_loc3_.data as PlannerDecorationData).decorationData.info.instanceId == param1)
               {
                  _loc2_ = _loc3_;
                  break;
               }
            }
            _loc4_++;
         }
         if(mouseFollower.isSelected(_loc3_))
         {
            mouseFollower.selectBuilding(_loc3_,true);
         }
         _loc3_.viewManager.removeRange();
         buildings.splice(buildings.indexOf(_loc3_),1);
         plannerGrid.unmarkArea(_loc3_);
         layers[3].remove(_loc3_);
         _loc3_.destroy();
         removeChild(_loc3_);
         inspectedBuilding = null;
         inspectedBuildingChanged.dispatch();
      }
   }
}

