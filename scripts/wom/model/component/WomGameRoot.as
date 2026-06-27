package wom.model.component
{
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.events.IEventDispatcher;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.media.SoundChannel;
   import flash.ui.Mouse;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import peak.config.DocumentConfiguration;
   import peak.cuckoo.core.Entity;
   import peak.cuckoo.game.CuckooUtils;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.Layer;
   import peak.cuckoo.game.Root;
   import peak.cuckoo.game.attribute.Position;
   import peak.cuckoo.game.attribute.Viewport;
   import peak.cuckoo.game.attribute.filter.Filters;
   import peak.cuckoo.game.attribute.projection.IsoProjection;
   import peak.cuckoo.game.attribute.view.AssetView;
   import peak.cuckoo.game.behavior.AutoScreenPanning;
   import peak.cuckoo.game.behavior.ScreenPan;
   import peak.cuckoo.game.behavior.StarlingTouchInteract;
   import peak.cuckoo.game.behavior.TimeOut;
   import peak.cuckoo.game.behavior.render.BaseRender;
   import peak.cuckoo.game.behavior.task.PathFinderTemplate;
   import peak.cuckoo.game.behavior.task.TaskRunner;
   import peak.cuckoo.game.behavior.task.TaskRunnerValidator;
   import peak.cuckoo.game.dto.Point3;
   import peak.logging.LoggerContexts;
   import peak.logging.ShippingLoggerTarget;
   import peak.logging.log;
   import peak.resource.SoundPlayer;
   import peak.resource.atlas.starling.StarlingAtlasReference;
   import peak.signal.Signal0;
   import peak.task.Task;
   import peak.thread.WorkerThread;
   import peak.util.PseudoRandomNumberGenerator;
   import peak.util.ValidationRecorder;
   import peak.util.ValidationVerifier;
   import wom.Environment;
   import wom.controller.event.ConstructableActionEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.mobile.MobileCanvasOptionsPanelEvent;
   import wom.controller.event.mobile.MobileCloseCatapultMenuOptionEvent;
   import wom.controller.event.mobile.MobileConstructableOptionsEvent;
   import wom.controller.event.mobile.MobilePreSelectEvent;
   import wom.controller.event.mobile.MobileSelectEvent;
   import wom.controller.event.ui.ActionSelectEvent;
   import wom.controller.event.ui.BuildingTooltipEvent;
   import wom.controller.event.ui.DecorationTooltipEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.controller.event.ui.MobileTooltipEvent;
   import wom.controller.event.ui.PopUpWindowEvent;
   import wom.model.component.attribute.SfxManager;
   import wom.model.component.attribute.data.WorkerStatus;
   import wom.model.component.attribute.grid.CityGrid;
   import wom.model.component.attribute.grid.WeightGrid;
   import wom.model.component.attribute.projection.TerrainDoodadProjection;
   import wom.model.component.attribute.view.WomFilters;
   import wom.model.component.behavior.Earthquake;
   import wom.model.component.behavior.FpsSyncCollector;
   import wom.model.component.behavior.LineAnimationManager;
   import wom.model.component.behavior.Particle3DAnimationManager;
   import wom.model.component.behavior.ParticleManager;
   import wom.model.component.behavior.battle.AutoDeployer;
   import wom.model.component.behavior.battle.BattleManager;
   import wom.model.component.behavior.mouse.follow.BaseMouseFollow;
   import wom.model.component.behavior.mouse.follow.BuildingMouseFollow;
   import wom.model.component.behavior.mouse.follow.ConstructableMouseFollow;
   import wom.model.component.behavior.mouse.follow.DoodadMouseFollow;
   import wom.model.component.entity.EventItemsManager;
   import wom.model.component.entity.Grid;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.component.entity.gamesprite.Decoration;
   import wom.model.component.entity.gamesprite.Doodad;
   import wom.model.component.entity.gamesprite.Unit;
   import wom.model.component.entity.gamesprite.Worker;
   import wom.model.component.enum.ActionType;
   import wom.model.component.enum.CanvasMode;
   import wom.model.component.factory.ConstructableFactory;
   import wom.model.component.factory.UnitFactory;
   import wom.model.component.structure.FloatingTextStack;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.domain.domaininfoobject.DecorationTypeDIO;
   import wom.model.game.AttackInfo;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.VisitInfo;
   import wom.model.game.WomGameRootHolder;
   import wom.model.game.alliance.AllianceInfo;
   import wom.model.game.attack.GameModeType;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.building.BuildingTypeInfo;
   import wom.model.game.building.DecorationInfo;
   import wom.model.game.speech.SpeechType;
   import wom.model.message.request.BuyDecorationRequest;
   import wom.model.message.request.ConstructBuildingRequest;
   import wom.model.message.request.HelpFriendRequest;
   import wom.model.message.request.IdleWorkerRequest;
   import wom.model.message.request.MoveBuildingRequest;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.screen.popups.JobCapacityAlreadyReachedPopUp;
   import wom.view.screen.popups.expandcity.MobileExpandCityPopUp;
   import wom.view.screen.windows.beastcage.MobileBeastCageWindow;
   import wom.view.ui.MobileCanvasOptionsPanel;
   import wom.view.ui.mainframe.city.tooltip.mobile.MobileBaseBuildingTooltipView;
   
   public class WomGameRoot extends Root
   {
      
      public static const CANVAS_WIDTH:int = 4000;
      
      public static const CANVAS_HEIGHT:int = 2000;
      
      [Inject]
      public var massetRepository:MobileWomAssetRepository;
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      [Inject]
      public var notifier:CuckooNotifier;
      
      [Inject]
      public var eventDispatcher:IEventDispatcher;
      
      [Inject]
      public var cityInfo:CityStatusInfo;
      
      [Inject]
      public var attackInfo:AttackInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var visitInfo:VisitInfo;
      
      [Inject]
      public var soundPlayer:SoundPlayer;
      
      [Inject]
      public var documentConfiguration:DocumentConfiguration;
      
      [Inject]
      public var allianceInfo:AllianceInfo;
      
      [Inject]
      public var logShipper:ShippingLoggerTarget;
      
      [Inject]
      public var gameRootHolder:WomGameRootHolder;
      
      public var sfxManager:SfxManager;
      
      public var unitFactory:UnitFactory;
      
      public var globalActionType:ActionType = ActionType.ARROW;
      
      private var _canvasMode:CanvasMode = CanvasMode.NORMAL;
      
      public var buildByGold:Boolean = false;
      
      public var completeResources:Boolean = false;
      
      private var actionType:ActionType;
      
      public var updateProgressBarBitmaps:Vector.<BitmapData>;
      
      public var healthProgressBarBitmaps:Vector.<BitmapData>;
      
      public var unitHealthProgressBarBitmaps:Vector.<BitmapData>;
      
      public var speechBubbleBitmaps:Dictionary;
      
      public var constructableFactory:ConstructableFactory;
      
      public var movingConstructable:GameSprite;
      
      public var movingConstructableInitialPosition:Point;
      
      public var workers:Vector.<Worker>;
      
      public var units:Dictionary;
      
      public var buildings:Dictionary;
      
      public var decorations:Dictionary;
      
      public var doodads:Vector.<Doodad>;
      
      public var particle3DAnimationManager:Particle3DAnimationManager;
      
      public var lineAnimationManager:LineAnimationManager;
      
      public var particleManager:ParticleManager;
      
      public var screenPan:ScreenPan;
      
      public var cityGrid:CityGrid;
      
      public var grid:Grid;
      
      public var weightGrid:WeightGrid;
      
      public var bloodDisabled:Boolean = true;
      
      public var boundAssets:Vector.<GameSprite> = new Vector.<GameSprite>();
      
      public var multiBuildSoundPlayed:Boolean;
      
      public var earthquake:Earthquake;
      
      public var pseudoRandomGenerator:PseudoRandomNumberGenerator;
      
      private var deployer:AutoDeployer;
      
      private var mouseUpDownDiff:int;
      
      public var eventItemsManager:EventItemsManager;
      
      public var beastCage:Building;
      
      public var cagedBeast:Unit;
      
      public var expandSigns:Dictionary;
      
      public var mobileSelectedInstanceId:int;
      
      public var mobileOptionsPanel:MobileCanvasOptionsPanel;
      
      private var activeBuildingInSpyMode:Building;
      
      public var tds:WorkerThread;
      
      public var tda:WorkerThread;
      
      public var tdst:WorkerThread;
      
      public var tdrd:WorkerThread;
      
      public var tdrg:WorkerThread;
      
      public var uhwd:WorkerThread;
      
      public var bhwd:WorkerThread;
      
      public var zcmp:WorkerThread;
      
      private var v:Boolean = false;
      
      public var initialized:Signal0 = new Signal0();
      
      public var battleManager:BattleManager;
      
      public function WomGameRoot()
      {
         PROJECTION_PITCH_X = 12;
         PROJECTION_PITCH_Y = 6;
         super();
         componentManager.add(projection = new IsoProjection());
         componentManager.add(render = BaseRender.getRender(4));
         componentManager.add(viewport = new Viewport(new Rectangle(-2000,-1000,4000,2000)));
         componentManager.add(screenPan = new ScreenPan());
         componentManager.add(userInteract = new StarlingTouchInteract());
         componentManager.add(taskManager = new TaskRunner());
         componentManager.add(screenPanning = new AutoScreenPanning());
         componentManager.add(timeOut = new TimeOut());
         createLayers();
         componentManager.add(weightGrid = new WeightGrid());
         componentManager.add(particle3DAnimationManager = new Particle3DAnimationManager());
         componentManager.add(lineAnimationManager = new LineAnimationManager());
         componentManager.add(particleManager = new ParticleManager());
         componentManager.add(earthquake = new Earthquake());
         componentManager.add(deployer = new AutoDeployer());
         addChild(eventItemsManager = new EventItemsManager());
         workers = new Vector.<Worker>();
         units = new Dictionary();
         buildings = new Dictionary();
         decorations = new Dictionary();
         doodads = new Vector.<Doodad>();
         expandSigns = new Dictionary();
         multiBuildSoundPlayed = false;
         mobileSelectedInstanceId = -1;
         pseudoRandomGenerator = new PseudoRandomNumberGenerator();
         tds = new WorkerThread(1);
         tda = new WorkerThread(2);
         tdst = new WorkerThread(3);
         tdrd = new WorkerThread(11);
         tdrg = new WorkerThread(12);
         uhwd = new WorkerThread(60);
         bhwd = new WorkerThread(8);
         zcmp = new WorkerThread();
      }
      
      [PostConstruct]
      public function postConstruct() : void
      {
         componentManager.add(sfxManager = new SfxManager(soundPlayer,assetRepository));
      }
      
      public function displayFloatingText(param1:Point, param2:int, param3:String = "", param4:String = null, param5:FloatingTextStack = null) : void
      {
         particle3DAnimationManager.displayFloatingText(param1,param2,param3,param4,param5);
      }
      
      override public function init() : void
      {
         super.init();
         userInteract.click.addFunction(onMouseClick);
         userInteract.mouseDown.addFunction(onMouseDown);
         userInteract.mouseUp.addFunction(onMouseUp);
         userInteract.dragStarted.addFunction(onDragStarted);
         userInteract.moveDrag.addFunction(onMoveDrag);
         userInteract.pickedEntityChanged.addFunction(onPickedEntityChange);
         canvasMode = CanvasMode.NORMAL;
         globalActionType = ActionType.ARROW;
         eventItemsManager.init();
         initialized.dispatch();
      }
      
      private function onMoveDrag() : void
      {
         if(!(userInteract.pickedEntity && userInteract.pickedEntity == movingConstructable && (_canvasMode == CanvasMode.MOBILE_SELECT || _canvasMode == CanvasMode.MOVE || _canvasMode == CanvasMode.BUILD || _canvasMode == CanvasMode.MOBILE_CATAPULT || _canvasMode == CanvasMode.MOBILE_SIEGE_TOWER)) && !deployer.deployStarted)
         {
            viewport.moveTo(userInteract.grabbedCanvasPoint.x - userInteract.moveDiff.x,userInteract.grabbedCanvasPoint.y - userInteract.moveDiff.y);
            if(!userInteract.underDragThreshold)
            {
               deployer.disable();
            }
         }
      }
      
      private function onMouseUp() : void
      {
         deployer.disable();
         if(movingConstructable)
         {
            (movingConstructable.componentManager["MouseFollow"] as BaseMouseFollow).disable();
            (movingConstructable.componentManager["MouseFollow"] as BaseMouseFollow).disable();
         }
      }
      
      private function onDragStarted() : void
      {
         if(_canvasMode == CanvasMode.MOBILE_SELECT && userInteract.pickedEntity && mobileSelectedInstanceId != -1 && (buildings[mobileSelectedInstanceId] == userInteract.pickedEntity || decorations[mobileSelectedInstanceId] == userInteract.pickedEntity))
         {
            startMove(mobileSelectedInstanceId);
            eventDispatcher.dispatchEvent(new MobileConstructableOptionsEvent("mobileConstructableOptionsClose"));
            eventDispatcher.dispatchEvent(new MobileCanvasOptionsPanelEvent("showBuilidingOptionsPanel",mobileOptionsPanel = new MobileCanvasOptionsPanel()));
         }
         if(movingConstructable && movingConstructable == userInteract.pickedEntity)
         {
            (movingConstructable.componentManager["MouseFollow"] as BaseMouseFollow).enable();
         }
      }
      
      private function onMouseDown() : void
      {
         screenPan.reset();
         if(userInfo.gameMode == GameModeType.ATTACK || userInfo.gameMode == GameModeType.TUSK_HORN)
         {
            if(!attackInfo.deployPassed)
            {
               if(_canvasMode != CanvasMode.MOBILE_CATAPULT && _canvasMode != CanvasMode.MOBILE_SIEGE_TOWER)
               {
                  mouseUpDownDiff = getTimer();
                  deployer.enable();
               }
            }
         }
      }
      
      private function showMobileTooltip(param1:Building, param2:Viewport) : void
      {
         var _loc6_:MobileBaseBuildingTooltipView = new MobileBaseBuildingTooltipView(param1.data.buildingInfo,param1.data.buildingTypeDIO);
         var _loc3_:Number = scale / Environment.starling.contentScaleFactor;
         var _loc5_:int = param1.position.projected.x * _loc3_ + (param1.data.buildingTypeDIO.baseSize * Root.PROJECTION_PITCH_X * _loc3_ - _loc6_.width >> 1) >> 0;
         var _loc4_:int = param1.position.projected.y * _loc3_ - param1.data.buildingTypeDIO.baseSize * Root.PROJECTION_PITCH_Y * _loc3_ - _loc6_.height >> 0;
         _loc5_ -= param2.rect.x * _loc3_;
         _loc4_ -= param2.rect.y * _loc3_;
         if(_loc5_ < 10)
         {
            _loc5_ = 10;
         }
         else if(_loc5_ + _loc6_.width > param2.rect.width * _loc3_ - 10)
         {
            _loc5_ = param2.rect.width * _loc3_ - _loc6_.width - 10;
         }
         if(_loc4_ < 10)
         {
            _loc4_ = Math.max((param1.position.projected.y - param2.rect.y) * _loc3_,10);
         }
         else if(_loc4_ + _loc6_.height > param2.rect.height * _loc3_ - 40)
         {
            _loc4_ = param2.rect.height * _loc3_ - _loc6_.height - 40;
         }
         eventDispatcher.dispatchEvent(new MobileTooltipEvent("mobileTooltipEventShow",_loc6_,_loc5_,_loc4_));
      }
      
      private function onMouseClick() : void
      {
         var _loc1_:Building = null;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         if(userInfo.gameMode == GameModeType.ATTACK || userInfo.gameMode == GameModeType.VISIT)
         {
            if(cityInfo.spyEnabled)
            {
               if(userInteract.pickedEntity && userInteract.pickedEntity is Building && (userInteract.pickedEntity as Building).data.buildingInfo.healthPoint != 0)
               {
                  _loc1_ = userInteract.pickedEntity as Building;
                  if(_loc1_.data.buildingInfo.buildingTypeId == 100000 || _loc1_.data.buildingInfo.buildingTypeId == 100001)
                  {
                     return;
                  }
                  showMobileTooltip(_loc1_,gameRootHolder.gameRoot.viewport);
                  _loc1_.viewManager.manageRangeView(true);
                  activeBuildingInSpyMode = _loc1_;
               }
            }
         }
         if(userInfo.gameMode == GameModeType.NORMAL)
         {
            if(_canvasMode == CanvasMode.NORMAL || _canvasMode == CanvasMode.MOBILE_SELECT)
            {
               _loc3_ = -2;
               if(_canvasMode == CanvasMode.MOBILE_SELECT)
               {
                  _loc3_ = int(mobileSelectedInstanceId != -1 ? mobileSelectedInstanceId : -2);
                  mobileUnselect();
               }
               if(userInteract.pickedEntity && (userInteract.pickedEntity is Building || userInteract.pickedEntity is Decoration))
               {
                  closeTooltips();
                  if(userInteract.pickedEntity is Decoration)
                  {
                     _loc2_ = (userInteract.pickedEntity as Decoration).data.info.instanceId;
                  }
                  else
                  {
                     if((userInteract.pickedEntity as Building).data.buildingInfo.buildingTypeId == 100000)
                     {
                        eventDispatcher.dispatchEvent(new MobilePopUpWindowEvent("showPopUpWindow",new MobileBeastCageWindow()));
                        return;
                     }
                     if((userInteract.pickedEntity as Building).data.buildingInfo.buildingTypeId == 100001)
                     {
                        eventDispatcher.dispatchEvent(new MobilePopUpWindowEvent("showPopUpWindow",new MobileExpandCityPopUp()));
                        return;
                     }
                     _loc2_ = (userInteract.pickedEntity as Building).data.buildingInfo.instanceId;
                  }
                  if(_loc2_ == _loc3_)
                  {
                     return;
                  }
                  eventDispatcher.dispatchEvent(new MobilePreSelectEvent(_loc2_));
               }
            }
            else
            {
               if(_canvasMode == CanvasMode.BUILD)
               {
                  return;
               }
               if(_canvasMode == CanvasMode.MOVE)
               {
                  return;
               }
            }
         }
         else if(userInfo.gameMode == GameModeType.ATTACK || userInfo.gameMode == GameModeType.TUSK_HORN)
         {
            if(_canvasMode != CanvasMode.MOBILE_CATAPULT && !attackInfo.deployPassed && !(activeBuildingInSpyMode && cityInfo.spyEnabled))
            {
               battleManager.deploy();
            }
            eventDispatcher.dispatchEvent(new MobileCloseCatapultMenuOptionEvent());
         }
         else if(userInfo.gameMode == GameModeType.VISIT)
         {
            if(userInteract.pickedEntity && userInteract.pickedEntity is Building && (userInteract.pickedEntity as Building).data.helpable && visitInfo.remainingHelpCount > 0)
            {
               soundPlayer.playSfxById("UseResources");
               (userInteract.pickedEntity as Building).data.helpable = false;
               eventDispatcher.dispatchEvent(new OutgoingMessageEvent("outgoingMessage",new HelpFriendRequest(visitInfo.landlord,(userInteract.pickedEntity as Building).data.buildingInfo.instanceId)));
               displayFloatingText(DefaultCoreManager.getBuildingProjectedMiddlePoint(userInteract.pickedEntity as Building),12);
            }
            return;
         }
      }
      
      public function startMove(param1:int) : void
      {
         var _loc3_:GameSprite = null;
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:Building = null;
         var _loc4_:Decoration = null;
         var _loc5_:ConstructableMouseFollow = null;
         if(_canvasMode == CanvasMode.NORMAL || _canvasMode == CanvasMode.MOBILE_SELECT)
         {
            canvasMode = CanvasMode.MOVE;
            eventDispatcher.dispatchEvent(new BuildingTooltipEvent("closeBuildingTooltip"));
            _loc3_ = manageConstructableFloorWithRenderings(true,param1);
            _loc3_.filterManager.removeFilter(Filters.WHITE_FILTER);
            movingConstructable = _loc3_;
            grid.addView();
            if(movingConstructable)
            {
               _loc7_ = movingConstructable.position.point.x;
               _loc6_ = movingConstructable.position.point.y;
               movingConstructableInitialPosition = new Point(_loc7_,_loc6_);
               if(_loc3_ is Building)
               {
                  _loc2_ = _loc3_ as Building;
                  (componentManager["CityGrid"] as CityGrid).unmarkBuilding(_loc7_,_loc6_,_loc2_.data);
               }
               else
               {
                  _loc4_ = _loc3_ as Decoration;
                  (componentManager["CityGrid"] as CityGrid).unmarkConstructable(_loc7_,_loc6_,_loc4_.data.dio.baseSize);
               }
               _loc5_ = _loc3_ is Building ? new BuildingMouseFollow() : new ConstructableMouseFollow();
               movingConstructable.componentManager.add(_loc5_);
               _loc5_.init();
               _loc5_.enable();
               movingConstructable.filterManager.addFilter(WomFilters.MOVE_FILTER);
               if(_loc3_ is Building)
               {
                  _loc2_.viewManager.manageSoil();
                  _loc2_.viewManager.manageMainVisuals();
               }
               else
               {
                  _loc4_.viewManager.manageMainVisual();
               }
            }
            else
            {
               canvasMode = CanvasMode.NORMAL;
            }
         }
      }
      
      public function finishBuild() : void
      {
         var _loc10_:BuildingTypeDIO = null;
         var _loc3_:Boolean = false;
         var _loc8_:BuildingTypeInfo = null;
         var _loc1_:int = 0;
         var _loc13_:int = 0;
         var _loc12_:int = 0;
         var _loc4_:int = 0;
         var _loc7_:ConstructableMouseFollow = null;
         var _loc11_:Decoration = null;
         var _loc6_:DecorationTypeDIO = null;
         var _loc5_:DecorationInfo = null;
         var _loc9_:String = null;
         var _loc2_:int = 0;
         if(movingConstructable is Building)
         {
            _loc10_ = (movingConstructable as Building).data.buildingTypeDIO;
            _loc3_ = true;
            if(_loc10_.multibuild)
            {
               _loc8_ = (movingConstructable as Building).data.buildingTypeInfo;
               if(_loc8_.currentInstanceCount + 1 < _loc8_.maxInstanceCount)
               {
                  _loc3_ = false;
               }
            }
            _loc1_ = _loc10_.id;
            _loc13_ = int(movingConstructable.componentManager["Position"].point.x);
            _loc12_ = int(movingConstructable.componentManager["Position"].point.y);
            if(_loc3_)
            {
               exitBuildMode();
               eventDispatcher.dispatchEvent(new ActionSelectEvent("actionSelect",ActionType.ARROW));
            }
            else
            {
               _loc4_ = 0;
               if(movingConstructable is Building)
               {
                  _loc4_ = (movingConstructable as Building).data.buildingTypeDIO.baseSize;
               }
               else if(movingConstructable is Decoration)
               {
                  _loc4_ = (movingConstructable as Decoration).data.dio.baseSize;
               }
               if(_loc4_ > 0)
               {
                  _loc7_ = movingConstructable.componentManager["MouseFollow"] as ConstructableMouseFollow;
                  _loc7_.warnNewDeploy(movingConstructable.position.point);
                  _loc7_.updateState(new Point3(movingConstructable.position.point.x + _loc4_,movingConstructable.position.point.y,0));
               }
            }
            if(cityInfo.numberOfWorkingWorkers >= cityInfo.numberOfWorkers)
            {
               exitBuildMode();
               if(_loc10_.multibuild)
               {
                  eventDispatcher.dispatchEvent(new ActionSelectEvent("actionSelect",ActionType.ARROW));
               }
               eventDispatcher.dispatchEvent(new PopUpWindowEvent("showPopUpWindow",new JobCapacityAlreadyReachedPopUp(),0));
            }
            else
            {
               multiBuildSoundPlayed = true;
               buildByGold ? soundPlayer.playSfxById("PurchaseSuccessful") : soundPlayer.playSfxById("UseResources");
               eventDispatcher.dispatchEvent(new OutgoingMessageEvent("outgoingMessage",new ConstructBuildingRequest(_loc1_,_loc13_,_loc12_,buildByGold,completeResources)));
            }
         }
         else if(movingConstructable is Decoration)
         {
            _loc11_ = movingConstructable as Decoration;
            _loc6_ = _loc11_.data.dio;
            _loc5_ = _loc11_.data.info;
            _loc9_ = _loc5_.subType;
            _loc2_ = _loc6_.id;
            _loc13_ = int(movingConstructable.componentManager["Position"].point.x);
            _loc12_ = int(movingConstructable.componentManager["Position"].point.y);
            exitBuildMode();
            eventDispatcher.dispatchEvent(new ActionSelectEvent("actionSelect",ActionType.ARROW));
            eventDispatcher.dispatchEvent(new OutgoingMessageEvent("outgoingMessage",new BuyDecorationRequest(_loc2_,_loc13_,_loc12_,_loc9_,_loc5_.fromStash)));
         }
      }
      
      public function finishMove() : void
      {
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:Building = null;
         var _loc2_:Decoration = null;
         if(!(movingConstructable.componentManager["MouseFollow"] as ConstructableMouseFollow).collide)
         {
            if("MouseFollow" in movingConstructable.componentManager)
            {
               movingConstructable.componentManager.remove(movingConstructable.componentManager["MouseFollow"]);
            }
            _loc6_ = movingConstructable.position.point.x;
            _loc4_ = movingConstructable.position.point.y;
            _loc3_ = -1;
            if(movingConstructable is Building)
            {
               _loc5_ = movingConstructable as Building;
               _loc5_.viewManager.manageSoil();
               _loc5_.viewManager.manageMainVisuals();
               (componentManager["CityGrid"] as CityGrid).markBuilding(_loc6_,_loc4_,_loc5_.data);
               _loc3_ = _loc5_.data.buildingInfo.instanceId;
            }
            else
            {
               _loc2_ = movingConstructable as Decoration;
               _loc2_.viewManager.manageMainVisual();
               (componentManager["CityGrid"] as CityGrid).markConstructable(_loc6_,_loc4_,_loc2_.data.dio.baseSize,_loc2_);
               _loc3_ = _loc2_.data.info.instanceId;
            }
            for each(var _loc1_ in movingConstructable.children)
            {
               _loc1_.init();
            }
            eventDispatcher.dispatchEvent(new MobileCanvasOptionsPanelEvent("closeBuilidingOptionsPanel"));
            mobileUnselect();
            movingConstructable.interactive = true;
            eventDispatcher.dispatchEvent(new OutgoingMessageEvent("outgoingMessage",new MoveBuildingRequest(_loc3_,new Point(_loc6_,_loc4_))));
            movingConstructable = null;
            movingConstructableInitialPosition = null;
            canvasMode = CanvasMode.NORMAL;
            manageConstructableFloorWithRenderings(false);
            grid.removeView();
         }
      }
      
      public function onPickedEntityChange() : void
      {
         var _loc7_:* = null;
         var _loc1_:* = null;
         var _loc8_:int = 0;
         var _loc3_:Number = NaN;
         var _loc6_:int = 0;
         var _loc5_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc9_:int = 0;
         var _loc2_:* = null;
      }
      
      public function mobileSelect(param1:int) : void
      {
         var _loc3_:Building = null;
         var _loc2_:Decoration = null;
         canvasMode = CanvasMode.MOBILE_SELECT;
         mobileSelectedInstanceId = param1;
         if(mobileSelectedInstanceId in buildings)
         {
            _loc3_ = buildings[mobileSelectedInstanceId] as Building;
            _loc3_.viewManager.manageBuildingFloor(true);
            _loc3_.viewManager.drawMobileMoveArrows();
            _loc3_.viewManager.manageRangeView(true);
         }
         else if(mobileSelectedInstanceId in decorations)
         {
            _loc2_ = decorations[mobileSelectedInstanceId] as Decoration;
            _loc2_.viewManager.manageBuildingFloor(true);
            _loc2_.viewManager.drawMobileMoveArrows();
         }
         eventDispatcher.dispatchEvent(new MobileSelectEvent(mobileSelectedInstanceId,!userInfo.mandatoryTutorialCompleted));
      }
      
      public function mobileUnselect() : void
      {
         var _loc2_:Building = null;
         var _loc1_:Decoration = null;
         canvasMode = CanvasMode.NORMAL;
         if(mobileSelectedInstanceId in buildings)
         {
            _loc2_ = buildings[mobileSelectedInstanceId] as Building;
            _loc2_.viewManager.manageBuildingFloor(false);
            _loc2_.viewManager.clearMobileMoveArrows();
            _loc2_.viewManager.manageRangeView(false);
         }
         else if(mobileSelectedInstanceId in decorations)
         {
            _loc1_ = decorations[mobileSelectedInstanceId] as Decoration;
            _loc1_.viewManager.manageBuildingFloor(false);
            _loc1_.viewManager.clearMobileMoveArrows();
         }
         mobileSelectedInstanceId = -1;
         eventDispatcher.dispatchEvent(new MobileConstructableOptionsEvent("mobileConstructableOptionsClose"));
      }
      
      private function showBuildingTooltips(param1:ActionType, param2:Boolean = false) : void
      {
         var _loc3_:* = null;
      }
      
      private function showDecorationTooltip(param1:ActionType, param2:Boolean = false) : void
      {
      }
      
      public function closeTooltips() : void
      {
         closeBuildingTooltip();
         closeDecorationTooltip();
      }
      
      public function closeBuildingTooltip() : void
      {
         eventDispatcher.dispatchEvent(new BuildingTooltipEvent("closeBuildingTooltip"));
      }
      
      public function closeDecorationTooltip() : void
      {
         eventDispatcher.dispatchEvent(new DecorationTooltipEvent("closeDecorationTooltip"));
      }
      
      private function generateSpeechBubbleBitmaps() : void
      {
         var _loc1_:Dictionary = null;
         var _loc11_:int = 0;
         var _loc7_:WomTextField = null;
         var _loc8_:BitmapData = null;
         var _loc6_:Matrix = null;
         var _loc3_:Matrix = null;
         var _loc9_:int = 12;
         var _loc2_:int = 12;
         speechBubbleBitmaps = new Dictionary();
         var _loc10_:DisplayObject = assetRepository.getDisplayObject("TooltipBackgroundSkin");
         var _loc5_:DisplayObject = assetRepository.getDisplayObject("TooltipsBottomPin");
         for each(var _loc4_ in SpeechType.speechTypes)
         {
            _loc1_ = new Dictionary();
            _loc11_ = 0;
            while(_loc11_ < _loc4_.count)
            {
               _loc7_ = new WomTextField();
               _loc7_.autoSize = "left";
               _loc7_.wordWrap = true;
               _loc7_.defaultTextFormat = WomTextFormats.CENTER_14;
               _loc7_.text = _loc4_.getText(_loc11_);
               _loc10_.width = _loc7_.width + _loc9_;
               _loc10_.height = _loc7_.height + _loc2_;
               _loc8_ = new BitmapData(_loc10_.width,_loc10_.height + 6,true,0);
               _loc8_.lock();
               _loc8_.draw(_loc10_,new Matrix());
               _loc6_ = new Matrix();
               _loc6_.translate(_loc9_ >> 1,_loc2_ >> 1);
               _loc8_.draw(_loc7_,_loc6_);
               _loc3_ = new Matrix();
               _loc3_.translate((_loc10_.width >> 1) - 6,_loc10_.height - 5);
               _loc8_.draw(_loc5_,_loc3_);
               _loc8_.unlock();
               _loc1_[_loc11_] = _loc8_;
               _loc11_++;
            }
            speechBubbleBitmaps[_loc4_.id] = _loc1_;
         }
      }
      
      override public function stopUserInteract() : void
      {
         super.stopUserInteract();
      }
      
      override public function continueUserInteract() : void
      {
         super.continueUserInteract();
      }
      
      public function beforeShowPopup() : void
      {
         if(exitBuildMode())
         {
            eventDispatcher.dispatchEvent(new ActionSelectEvent("actionSelect",ActionType.ARROW));
         }
         cancelMove();
         mobileUnselect();
      }
      
      public function exitBuildMode() : Boolean
      {
         if(_canvasMode == CanvasMode.BUILD)
         {
            canvasMode = CanvasMode.NORMAL;
            layers[3].remove(movingConstructable);
            eventDispatcher.dispatchEvent(new MobileCanvasOptionsPanelEvent("closeBuilidingOptionsPanel"));
            if(movingConstructable is Building)
            {
               (movingConstructable as Building).viewManager.clearMobileMoveArrows();
            }
            else if(movingConstructable is Decoration)
            {
               (movingConstructable as Decoration).viewManager.clearMobileMoveArrows();
            }
            movingConstructable.componentManager.disableAll();
            removeChild(movingConstructable);
            movingConstructable.destroy();
            movingConstructable = null;
            manageConstructableFloorWithRenderings(false);
            grid.removeView();
            eventDispatcher.dispatchEvent(new MobilePopUpWindowEvent("showDelayedPopUps",null));
            return true;
         }
         return false;
      }
      
      public function manageConstructableFloorWithRenderings(param1:Boolean, param2:int = -1) : GameSprite
      {
         var _loc6_:GameSprite = null;
         for each(var _loc3_ in buildings)
         {
            if(_loc3_.viewManager)
            {
               if(param1)
               {
                  _loc3_.filterManager.addFilter(WomFilters.MOVE_FILTER);
               }
               else
               {
                  _loc3_.filterManager.removeFilter(WomFilters.MOVE_FILTER);
               }
               _loc3_.viewManager.manageBuildingFloor(param1);
               if(_loc3_.data.buildingInfo.instanceId == param2)
               {
                  _loc6_ = _loc3_;
               }
            }
         }
         for each(var _loc4_ in decorations)
         {
            if(_loc4_.viewManager)
            {
               if(param1)
               {
                  _loc4_.filterManager.addFilter(WomFilters.MOVE_FILTER);
               }
               else
               {
                  _loc4_.filterManager.removeFilter(WomFilters.MOVE_FILTER);
               }
               _loc4_.viewManager.manageBuildingFloor(param1);
               if(_loc4_.data.info.instanceId == param2)
               {
                  _loc6_ = _loc4_;
               }
            }
         }
         for each(var _loc5_ in expandSigns)
         {
            if(param1)
            {
               _loc5_.filterManager.addFilter(WomFilters.MOVE_FILTER);
            }
            else
            {
               _loc5_.filterManager.removeFilter(WomFilters.MOVE_FILTER);
            }
         }
         if(beastCage)
         {
            if(param1)
            {
               beastCage.filterManager.addFilter(WomFilters.MOVE_FILTER);
            }
            else
            {
               beastCage.filterManager.removeFilter(WomFilters.MOVE_FILTER);
            }
         }
         return _loc6_;
      }
      
      public function findNearestWorker(param1:int, param2:int) : Unit
      {
         var _loc7_:Unit = null;
         var _loc9_:WorkerStatus = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc3_:Number = 1.7976931348623157e+308;
         for each(var _loc6_ in workers)
         {
            _loc9_ = _loc6_.componentManager["WorkerStatus"] as WorkerStatus;
            if(!_loc9_.busy)
            {
               _loc4_ = _loc6_.position.point.x - param1;
               _loc5_ = _loc6_.position.point.y - param2;
               if(_loc7_ == null)
               {
                  _loc7_ = _loc6_;
                  _loc3_ = _loc4_ * _loc4_ + _loc5_ * _loc5_;
               }
               else
               {
                  _loc8_ = _loc4_ * _loc4_ + _loc5_ * _loc5_;
                  if(_loc8_ < _loc3_)
                  {
                     _loc7_ = _loc6_;
                     _loc3_ = _loc8_;
                  }
               }
            }
         }
         return _loc7_;
      }
      
      public function addTerrain(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 50;
         var _loc2_:Vector.<Point> = new Vector.<Point>();
         if(documentConfiguration.hasParameter("testval"))
         {
            _loc3_ = documentConfiguration.getParameter("testval");
         }
         _loc2_.push(new Point(cityGrid.projectedBoundLeft.x - _loc3_,cityGrid.projectedBoundLeft.y));
         _loc2_.push(new Point(cityGrid.projectedBoundBottom.x,cityGrid.projectedBoundBottom.y + (_loc3_ >> 1)));
         _loc2_.push(new Point(cityGrid.projectedBoundRight.x + _loc3_,cityGrid.projectedBoundRight.y));
         _loc2_.push(new Point(cityGrid.projectedBoundTop.x,cityGrid.projectedBoundTop.y - (_loc3_ >> 1)));
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            addDoodad(param1[_loc4_][0],new Point(param1[_loc4_][1],param1[_loc4_][2]),_loc2_,false);
            _loc4_++;
         }
      }
      
      private function addDoodad(param1:int, param2:Point, param3:Vector.<Point>, param4:Boolean) : void
      {
         var _loc10_:Boolean = false;
         var _loc8_:Point = param2.clone();
         var _loc5_:String = "Part0" + param1;
         _loc5_ = "Part06";
         var _loc11_:StarlingAtlasReference = atlasManager.getAtlasReference(_loc5_);
         var _loc9_:int = _loc11_.width;
         var _loc6_:int = _loc11_.height;
         _loc8_.x -= _loc9_ >> 1;
         _loc8_.y -= _loc6_ >> 1;
         if(!param4)
         {
            _loc10_ = false;
            if(!_loc10_)
            {
               _loc10_ = CuckooUtils.coordInPolygon(_loc8_.x,_loc8_.y + (_loc6_ >> 1),param3);
            }
            if(!_loc10_)
            {
               _loc10_ = CuckooUtils.coordInPolygon(_loc8_.x + (_loc9_ >> 1),_loc8_.y + _loc6_,param3);
            }
            if(!_loc10_)
            {
               _loc10_ = CuckooUtils.coordInPolygon(_loc8_.x + _loc9_,_loc8_.y + (_loc6_ >> 1),param3);
            }
            if(!_loc10_)
            {
               _loc10_ = CuckooUtils.coordInPolygon(_loc8_.x + (_loc9_ >> 1),_loc8_.y,param3);
            }
            if(_loc10_)
            {
               return;
            }
         }
         var _loc12_:Doodad = new Doodad();
         _loc12_.assetId = param1;
         _loc12_.componentManager.add(_loc12_.view = new AssetView(param4 ? 3 : 1,_loc5_));
         _loc12_.componentManager.add(_loc12_.position = new Position(new Point3()));
         _loc12_.componentManager.add(new TerrainDoodadProjection());
         if(param4)
         {
            _loc12_.componentManager.add(new DoodadMouseFollow());
            _loc12_.interactive = true;
         }
         _loc12_.position.point.x = _loc8_.x;
         _loc12_.position.point.y = _loc8_.y;
         addChild(_loc12_);
         _loc12_.init();
         (layers[param4 ? 3 : 1] as Layer).add(_loc12_);
         var _loc7_:Boolean = false;
         if(!_loc7_)
         {
            doodads.push(_loc12_);
         }
      }
      
      private function destroyDoodad(param1:Doodad) : void
      {
         doodads.splice(doodads.indexOf(param1),1);
         (layers[param1.view.layerId] as Layer).remove(param1);
         destroyChild(param1);
      }
      
      public function destroyAllDoodads() : void
      {
         while(doodads && doodads.length > 0)
         {
            destroyDoodad(doodads[0]);
         }
         doodads.length = 0;
      }
      
      public function startBattle() : void
      {
         var _loc1_:FpsSyncCollector = null;
         sync.reset();
         PathFinderTemplate.TASK_ID_COUNTER = 0;
         Task.TASK_ID_COUNTER = 0;
         if(battleManager == null)
         {
            componentManager.add(battleManager = new BattleManager(unitFactory,userInfo.mandatoryTutorialCompleted));
            battleManager.init();
            deployer.init();
            battleManager.enable();
         }
         _loc1_ = new FpsSyncCollector();
         componentManager.add(_loc1_);
         _loc1_.init();
         _loc1_.enable();
      }
      
      override public function reset() : void
      {
         if(battleManager)
         {
            battleManager.destroy();
            componentManager.remove(battleManager);
            battleManager = null;
         }
         super.reset();
         buildings = new Dictionary();
         decorations = new Dictionary();
         units = new Dictionary();
         workers.length = 0;
         doodads.length = 0;
         cityGrid = null;
         cagedBeast = null;
         beastCage = null;
         expandSigns = new Dictionary();
         mobileSelectedInstanceId = -1;
      }
      
      public function cancelMove() : void
      {
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Building = null;
         var _loc2_:Decoration = null;
         if(movingConstructable && _canvasMode == CanvasMode.MOVE)
         {
            if("MouseFollow" in movingConstructable.componentManager)
            {
               movingConstructable.componentManager.remove(movingConstructable.componentManager["MouseFollow"]);
            }
            _loc5_ = movingConstructableInitialPosition.x;
            _loc3_ = movingConstructableInitialPosition.y;
            movingConstructable.position.move(_loc5_,_loc3_,0);
            if(movingConstructable is Building)
            {
               _loc4_ = movingConstructable as Building;
               _loc4_.viewManager.manageSoil();
               _loc4_.viewManager.manageMainVisuals();
               (componentManager["CityGrid"] as CityGrid).markBuilding(_loc5_,_loc3_,_loc4_.data);
            }
            else
            {
               _loc2_ = movingConstructable as Decoration;
               _loc2_.viewManager.manageMainVisual();
               (componentManager["CityGrid"] as CityGrid).markConstructable(_loc5_,_loc3_,_loc2_.data.dio.baseSize,_loc2_);
            }
            movingConstructable.interactive = true;
            movingConstructable.init();
            for each(var _loc1_ in movingConstructable.children)
            {
               _loc1_.init();
            }
            eventDispatcher.dispatchEvent(new MobileCanvasOptionsPanelEvent("closeBuilidingOptionsPanel"));
            mobileUnselect();
            movingConstructable = null;
            movingConstructableInitialPosition = null;
            canvasMode = CanvasMode.NORMAL;
            manageConstructableFloorWithRenderings(false);
            grid.removeView();
         }
      }
      
      public function removeCagedBeast() : void
      {
         if(cagedBeast)
         {
            removeChild(cagedBeast);
            layers[3].remove(cagedBeast);
            cagedBeast.destroyAll();
            cagedBeast = null;
         }
         if(beastCage)
         {
            (componentManager["CityGrid"] as CityGrid).unmarkBuilding(beastCage.position.point.x,beastCage.position.point.y,beastCage.data);
            removeChild(beastCage);
            layers[3].remove(beastCage);
            beastCage.destroyAll();
            beastCage = null;
         }
      }
      
      override public function update() : void
      {
         try
         {
            super.update();
         }
         catch(e:Error)
         {
            if(!v)
            {
               v = true;
               (root as WomGameRoot).eventDispatcher.dispatchEvent(new OutgoingMessageEvent("outgoingMessage",new IdleWorkerRequest("V",true)));
            }
         }
      }
      
      public function setSeed() : void
      {
         pseudoRandomGenerator.seed = attackInfo.seedNumber;
      }
      
      override public function onError(param1:Error) : void
      {
         if(!errorFlag)
         {
            super.onError(param1);
            errorFlag = true;
            log(LoggerContexts.CUCKOOERROR,"BEHAVIOR UPDATER ERROR: " + param1.name + " " + param1.toString() + " " + param1.getStackTrace());
            logShipper.flushBuffer();
         }
      }
      
      public function set canvasMode(param1:CanvasMode) : void
      {
         _canvasMode = param1;
      }
      
      public function get canvasMode() : CanvasMode
      {
         return _canvasMode;
      }
      
      public function hideRangeInSpyModeIfApplicable() : void
      {
         if(activeBuildingInSpyMode)
         {
            activeBuildingInSpyMode.viewManager.manageRangeView(false);
            activeBuildingInSpyMode = null;
         }
      }
   }
}

import peak.cuckoo.game.dto.Point3;
import peak.cuckoo.game.dto.WeightNode;
import peak.signal.Slot1;
import wom.model.component.entity.gamesprite.Unit;

class MoveFinishedHandler implements Slot1
{
   
   private var bound:Number = 200;
   
   private var grid:Array;
   
   public function MoveFinishedHandler(param1:Array)
   {
      super();
      this.grid = param1;
   }
   
   public function onSignal1(param1:*) : void
   {
      var _loc4_:WeightNode = null;
      var _loc3_:Unit = param1 as Unit;
      var _loc2_:Point3 = new Point3(Math.random() * bound * 2 - bound,Math.random() * bound * 2 - bound);
      var _loc5_:int = Math.random() * 4;
      do
      {
         switch(_loc5_)
         {
            case 0:
               _loc2_.x--;
               break;
            case 1:
               _loc2_.x++;
               break;
            case 2:
               _loc2_.y--;
               break;
            case 3:
               _loc2_.y++;
         }
      }
      while(_loc4_ = grid[(_loc2_.x << 10) + (_loc2_.y << 0)], _loc4_ && _loc4_.weight > 7);
      _loc3_.movement.moveToPoint(_loc2_);
      _loc3_.movement.movementFinished.add(new MoveFinishedHandler(grid));
   }
}
