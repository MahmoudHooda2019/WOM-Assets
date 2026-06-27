package wom.model.component.behavior.battle
{
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import peak.cuckoo.core.Behavior;
   import peak.cuckoo.core.Entity;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.Layer;
   import peak.cuckoo.game.attribute.Position;
   import peak.cuckoo.game.attribute.bounds.RenderBounds;
   import peak.cuckoo.game.attribute.bounds.compositeBased.CompositeChildRenderBounds;
   import peak.cuckoo.game.attribute.bounds.compositeBased.CompositeRenderBounds;
   import peak.cuckoo.game.attribute.projection.BaseProjection;
   import peak.cuckoo.game.attribute.projection.IsoOffsetProjection;
   import peak.cuckoo.game.attribute.projection.IsoProjection;
   import peak.cuckoo.game.attribute.view.AssetView;
   import peak.cuckoo.game.attribute.view.CompositeView;
   import peak.cuckoo.game.behavior.FpsSync;
   import peak.cuckoo.game.dto.Point3;
   import peak.i18n.PText;
   import peak.resource.atlas.starling.StarlingAtlasReference;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.mobile.MobileCanvasOptionsPanelEvent;
   import wom.controller.event.ui.MobileUINotificationEvent;
   import wom.model.component.CuckooNotifier;
   import wom.model.component.WomGameRoot;
   import wom.model.component.attribute.grid.CityGrid;
   import wom.model.component.attribute.projection.VoidProjection;
   import wom.model.component.attribute.view.SprayView;
   import wom.model.component.behavior.battle.attack.AreaBuffDispenserAndFollower;
   import wom.model.component.behavior.battle.tower.ArchersTower;
   import wom.model.component.behavior.battle.tower.BeastCannon;
   import wom.model.component.behavior.battle.tower.BeastCave;
   import wom.model.component.behavior.battle.tower.BombardTower;
   import wom.model.component.behavior.battle.tower.BurningMirrors;
   import wom.model.component.behavior.battle.tower.BurriedSpikes;
   import wom.model.component.behavior.battle.tower.FireTrap;
   import wom.model.component.behavior.battle.tower.FlamerTower;
   import wom.model.component.behavior.battle.tower.GatlingArrowTower;
   import wom.model.component.behavior.battle.tower.SkyTower;
   import wom.model.component.behavior.battle.tower.TowerDefense;
   import wom.model.component.behavior.battle.tower.WatchPost;
   import wom.model.component.behavior.battle.visuals.BattleEffects;
   import wom.model.component.behavior.battle.visuals.DeployCircleMouseFollow;
   import wom.model.component.behavior.battle.visuals.DeployWave;
   import wom.model.component.behavior.building.CombineBuildingChildManager;
   import wom.model.component.behavior.catapult.CatapultManager2;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.component.entity.gamesprite.Unit;
   import wom.model.component.enum.CanvasMode;
   import wom.model.component.factory.UnitFactory;
   import wom.model.game.attack.GameModeType;
   import wom.model.game.defense.NPCAttackDirection;
   import wom.model.game.unit.UnitInfo;
   import wom.model.game.unit.UnitStatusType;
   import wom.view.ui.MobileCanvasOptionsPanel;
   
   public class BattleManager extends Behavior
   {
      
      public static const TYPE_ID:String = "BattleManager";
      
      public static const MINIMUM_DEPLOYMENT_DIAMETER:int = 24;
      
      public static const DEPLOY_NONE:int = 0;
      
      public static const DEPLOY_UNIT:int = 1;
      
      public static const DEPLOY_CATAPULT:int = 2;
      
      public static var DEPLOY_MIGHT:int = 3;
      
      private var womRoot:WomGameRoot;
      
      private var firstDeployDone:Boolean = false;
      
      public var notifier:CuckooNotifier;
      
      public var sprayTool:GameSprite;
      
      public var effects:BattleEffects;
      
      public var unitFactory:UnitFactory;
      
      public var battleFieldControl:BattleFieldControl;
      
      public var mandatoryTutorialCompleted:Boolean;
      
      public var catapultManager2:CatapultManager2;
      
      public var _deploymentMode:int;
      
      private var diameter:int = 0;
      
      public var mobileDeployWaves:Vector.<DeployWave> = new Vector.<DeployWave>();
      
      public var frameCount:int;
      
      public var totalPrecise:Number;
      
      private var sync:FpsSync;
      
      public var buildings:Vector.<Building>;
      
      public function BattleManager(param1:UnitFactory, param2:Boolean)
      {
         super();
         priority = 0;
         this.unitFactory = param1;
         this.mandatoryTutorialCompleted = param2;
      }
      
      override public function get typeId() : String
      {
         return "BattleManager";
      }
      
      override public function init() : void
      {
         var _loc9_:int = 0;
         var _loc2_:TowerDefense = null;
         womRoot = owner.root as WomGameRoot;
         notifier = womRoot.notifier;
         womRoot.setSeed();
         super.init();
         frameCount = 0;
         totalPrecise = 0;
         sync = womRoot.sync;
         var _loc4_:Vector.<String> = new Vector.<String>();
         _loc4_.push("B39BuildingUsed");
         _loc4_.push("B40BuildingUsed");
         womRoot.assetRepository.preload(_loc4_);
         _loc9_ = womRoot.workers.length - 1;
         while(_loc9_ >= 0)
         {
            womRoot.layers[3].remove(womRoot.workers[_loc9_]);
            womRoot.destroyChild(womRoot.workers[_loc9_]);
            _loc9_--;
         }
         womRoot.workers.length = 0;
         battleFieldControl = new BattleFieldControl(this);
         battleFieldControl.init();
         owner.root.componentManager.add(effects = new BattleEffects(this));
         effects.init();
         catapultManager2 = new CatapultManager2(this);
         var _loc7_:Number = womRoot.userInfo.gameMode == GameModeType.DEFEND || womRoot.userInfo.gameMode == GameModeType.TUSK_HORN ? womRoot.userInfo.towerDamageModifier : womRoot.attackInfo.towerDamageModifier;
         buildings = new Vector.<Building>();
         for each(var _loc6_ in womRoot.buildings)
         {
            buildings.push(_loc6_);
         }
         buildings.sort(sortBuildings);
         var _loc5_:CityGrid = owner.root.componentManager["CityGrid"] as CityGrid;
         for each(var _loc3_ in buildings)
         {
            if(_loc3_.data.buildingInfo.healthPoint <= 0 && !_loc3_.data.buildingTypeDIO.indestructable)
            {
               _loc5_.unmarkBuilding(_loc3_.position.point.x,_loc3_.position.point.y,_loc3_.data);
            }
            if(!(_loc3_.data.buildingInfo.healthPoint <= 0 && !(_loc3_.data.buildingInfo.isTrap || _loc3_.data.buildingInfo.buildingTypeId == 29)))
            {
               battleFieldControl.registerBuilding(_loc3_);
               _loc3_.viewManager && _loc3_.viewManager.prepareAssetsForDestruction();
               if((_loc3_.data.buildingTypeDIO.kind.id == 28 || _loc3_.data.buildingInfo.buildingTypeId == 37 || _loc3_.data.buildingInfo.buildingTypeId == 38 || _loc3_.data.buildingInfo.buildingTypeId == 29) && !("BuildingUpgrade" in _loc3_.componentManager) && (_loc3_.data.buildingInfo.isTrap && _loc3_.data.buildingInfo.healthPoint != 0 || !_loc3_.data.buildingInfo.isTrap))
               {
                  _loc2_ = null;
                  if(_loc3_.data.buildingInfo.buildingTypeId == 31)
                  {
                     _loc2_ = new ArchersTower(this,_loc7_);
                  }
                  else if(_loc3_.data.buildingInfo.buildingTypeId == 32)
                  {
                     _loc2_ = new BombardTower(this,_loc7_);
                  }
                  else if(_loc3_.data.buildingInfo.buildingTypeId == 36)
                  {
                     _loc2_ = new BurningMirrors(this,_loc7_);
                  }
                  else if(_loc3_.data.buildingInfo.buildingTypeId == 35)
                  {
                     _loc2_ = new SkyTower(this,_loc7_);
                  }
                  else if(_loc3_.data.buildingInfo.buildingTypeId == 34)
                  {
                     _loc2_ = new GatlingArrowTower(this,_loc7_);
                  }
                  else if(_loc3_.data.buildingInfo.buildingTypeId == 29)
                  {
                     _loc2_ = new BeastCave(this);
                  }
                  else if(_loc3_.data.buildingInfo.buildingTypeId == 37 || _loc3_.data.buildingInfo.buildingTypeId == 38)
                  {
                     _loc2_ = new WatchPost(this);
                  }
                  else if(_loc3_.data.buildingInfo.buildingTypeId == 33)
                  {
                     _loc2_ = new FlamerTower(this,_loc7_);
                  }
                  else if(_loc3_.data.buildingInfo.buildingTypeId == 39)
                  {
                     _loc2_ = new BurriedSpikes(this);
                  }
                  else if(_loc3_.data.buildingInfo.buildingTypeId == 40)
                  {
                     _loc2_ = new FireTrap(this);
                  }
                  else if(_loc3_.data.buildingInfo.buildingTypeId == 45)
                  {
                     _loc2_ = new BeastCannon(this,_loc7_);
                  }
                  else
                  {
                     _loc2_ = new TowerDefense(this,_loc7_);
                  }
                  _loc3_.componentManager.add(_loc2_);
                  _loc2_.init();
                  if(_loc3_.data.buildingInfo.buildingTypeId != 45)
                  {
                     battleFieldControl.addTowerToCheckGrid(_loc2_);
                  }
               }
               else if(_loc3_.data.buildingInfo.buildingTypeId == 19)
               {
                  (_loc3_.componentManager["CombineBuildingChildManager"] as CombineBuildingChildManager).pruneUnitsForBattle();
               }
            }
         }
         var _loc8_:Dictionary = womRoot.units;
         for each(var _loc1_ in _loc8_)
         {
            if(_loc1_.data.typeDIO.id == 25)
            {
               _loc1_.componentManager.add(new AreaBuffDispenserAndFollower(this));
            }
         }
         notifier.battleStarted();
      }
      
      override public function update() : void
      {
         frameCount = frameCount + 1;
         totalPrecise += sync.precise;
         try
         {
            battleFieldControl.update();
         }
         catch(e:Error)
         {
            notifier.warnIdle(false,"BFC");
            throw e;
         }
      }
      
      public function deploy() : void
      {
         var _loc2_:Boolean = false;
         var _loc4_:int = 0;
         var _loc1_:UnitInfo = null;
         var _loc3_:Boolean = false;
         if(_deploymentMode == 1)
         {
            _loc3_ = mobileDeployUnits();
         }
         else if(_deploymentMode == 2)
         {
            if(sprayTool && (sprayTool.componentManager["MouseFollow"] as DeployCircleMouseFollow).moved)
            {
               _loc3_ = true;
               catapultManager2.deployCatapult(sprayTool.position.projected);
               setDeployDiameter(0);
            }
         }
         else if(_deploymentMode == 0)
         {
            _loc2_ = false;
            _loc4_ = 0;
            while(_loc4_ < womRoot.attackInfo.units.length && !_loc2_)
            {
               _loc1_ = womRoot.attackInfo.units[_loc4_];
               if(_loc1_.status.id < UnitStatusType.DEPLOYING.id)
               {
                  _loc2_ = true;
               }
               _loc4_++;
            }
            if(!_loc2_ && womRoot.attackInfo.beast && womRoot.attackInfo.beast.status.id < UnitStatusType.DEPLOYING.id)
            {
               _loc2_ = true;
            }
            if(!_loc2_)
            {
               var _temp_7:* = womRoot.eventDispatcher;
               var _temp_6:* = §§findproperty(MobileUINotificationEvent);
               var _temp_5:* = "mobileUINotificationEventShow";
               var _loc5_:String = "m.ui.warning.allunitsdeployed";
               _temp_7.dispatchEvent(new MobileUINotificationEvent(_temp_5,peak.i18n.PText.INSTANCE.getText0(_loc5_)));
            }
         }
         if(_loc3_ && !firstDeployDone)
         {
            firstDeployDone = true;
            notifier.firstDeploy();
         }
      }
      
      public function deployNPC(param1:Number, param2:Number, param3:NPCAttackDirection) : void
      {
         var _loc4_:Point3 = new Point3(param3.xDirection * int(param2),param3.yDirection * int(param2));
         battleFieldControl.deployUnits(param1,_loc4_,param3);
      }
      
      private function mobileDeployUnits(param1:Boolean = true) : Boolean
      {
         var _loc3_:int = -1;
         for each(var _loc2_ in womRoot.attackInfo.units)
         {
            if(_loc2_.status == UnitStatusType.DEPLOYING)
            {
               _loc3_ = _loc2_.typeId;
               break;
            }
         }
         if(_loc3_ != -1)
         {
            if(womRoot.domainInfo.getUnit(_loc3_).event)
            {
               param1 = false;
            }
         }
         var _loc4_:Point3 = new Point3();
         owner.root.projection.reverse(owner.root.userInteract.projectedPosition,_loc4_);
         if(!drawMobileDeployCircle())
         {
            if(isAnyMercSelected)
            {
               var _temp_3:* = womRoot.eventDispatcher;
               var _temp_2:* = §§findproperty(MobileUINotificationEvent);
               var _temp_1:* = "mobileUINotificationEventShow";
               var _loc9_:String = "m.ui.warning.cannotdeploycollision";
               _temp_3.dispatchEvent(new MobileUINotificationEvent(_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc9_)));
            }
            else
            {
               var _temp_6:* = womRoot.eventDispatcher;
               var _temp_5:* = §§findproperty(MobileUINotificationEvent);
               var _temp_4:* = "mobileUINotificationEventShow";
               var _loc10_:String = "m.ui.warning.cannotDeployNoMercSelected";
               _temp_6.dispatchEvent(new MobileUINotificationEvent(_temp_4,peak.i18n.PText.INSTANCE.getText0(_loc10_)));
            }
            return false;
         }
         battleFieldControl.deployUnits(diameter,_loc4_);
         if(param1)
         {
            for each(_loc2_ in womRoot.attackInfo.units)
            {
               if(_loc3_ == _loc2_.typeId && _loc2_.status == UnitStatusType.WAITING_TO_DEPLOY)
               {
                  _loc2_.status = UnitStatusType.DEPLOYING;
                  womRoot.eventDispatcher.dispatchEvent(new ModelUpdateEvent("attackingUnitUpdated"));
                  return true;
               }
            }
         }
         setDeployDiameter(0);
         return true;
      }
      
      private function drawMobileDeployCircle() : Boolean
      {
         var _loc9_:Point3 = null;
         var _loc10_:CityGrid = null;
         var _loc12_:Number = NaN;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         var _loc11_:Boolean = false;
         var _loc7_:Number = NaN;
         var _loc1_:Entity = null;
         var _loc13_:Boolean = false;
         if(isAnyMercSelected)
         {
            _loc9_ = new Point3();
            owner.root.projection.reverse(owner.root.userInteract.projectedPosition,_loc9_);
            _loc10_ = owner.root.componentManager["CityGrid"] as CityGrid;
            _loc9_.x >>= 0;
            _loc9_.y >>= 0;
            _loc12_ = diameter / 2;
            _loc2_ = _loc9_.x + _loc12_;
            _loc3_ = _loc9_.y + _loc12_;
            _loc5_ = _loc12_ * _loc12_;
            _loc11_ = false;
            _loc6_ = _loc9_.x - _loc12_;
            while(_loc6_ < _loc2_)
            {
               _loc4_ = _loc9_.y - _loc12_;
               while(_loc4_ < _loc3_)
               {
                  _loc7_ = (_loc6_ - _loc9_.x) * (_loc6_ - _loc9_.x) + (_loc4_ - _loc9_.y) * (_loc4_ - _loc9_.y);
                  if(_loc7_ <= _loc12_ * _loc12_)
                  {
                     _loc1_ = _loc10_.grid[(_loc6_ << 10) + _loc4_];
                     if(_loc1_)
                     {
                        _loc11_ = true;
                        if(_loc5_ > _loc7_)
                        {
                           _loc5_ = _loc7_;
                        }
                     }
                  }
                  _loc4_++;
               }
               _loc6_++;
            }
            _loc13_ = true;
            for each(var _loc8_ in mobileDeployWaves)
            {
               if(_loc8_.x == owner.root.userInteract.projectedPosition.x && _loc8_.y == owner.root.userInteract.projectedPosition.y)
               {
                  _loc13_ = false;
                  _loc8_.setNewDeploy(owner.root.userInteract.projectedPosition.x,owner.root.userInteract.projectedPosition.y);
               }
            }
            if(_loc13_)
            {
               createNewDeployWave(owner.root.userInteract.projectedPosition,_loc11_,_loc5_);
            }
            return !_loc11_;
         }
         return false;
      }
      
      public function createNewDeployWave(param1:Point, param2:Boolean, param3:Number) : void
      {
         var _loc4_:DeployWave = null;
         var _loc6_:GameSprite = new GameSprite();
         var _loc5_:StarlingAtlasReference = womRoot.atlasManager.getAtlasReference("TowerRange");
         _loc6_.componentManager.add(_loc6_.view = new AssetView(2,"TowerRange",true));
         _loc6_.componentManager.add(new VoidProjection());
         _loc6_.componentManager.add(_loc6_.bounds = new RenderBounds());
         _loc6_.componentManager.add(_loc6_.position = new Position(new Point3()));
         _loc6_.position.projected.x = param1.x - _loc5_.width / 2;
         _loc6_.position.projected.y = param1.y - _loc5_.height / 2;
         _loc6_.componentManager.add(_loc4_ = new DeployWave(param1,param2,param3,diameter));
         owner.addChild(_loc6_);
         _loc6_.init();
         (womRoot.layers[2] as Layer).add(_loc6_);
         mobileDeployWaves.push(_loc4_);
      }
      
      private function deployUnitsSprayTool(param1:GameSprite, param2:Boolean = true) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         if((param1.componentManager["MouseFollow"] as DeployCircleMouseFollow).collide)
         {
            return false;
         }
         var _loc4_:int = -1;
         if(param2)
         {
            for each(var _loc3_ in womRoot.attackInfo.units)
            {
               if(_loc3_.status == UnitStatusType.DEPLOYING)
               {
                  _loc4_ = _loc3_.typeId;
                  break;
               }
            }
            if(_loc4_ != -1)
            {
               if(womRoot.domainInfo.getUnit(_loc4_).event)
               {
                  param2 = false;
               }
            }
         }
         battleFieldControl.deployUnits(diameter,param1.position.point);
         if(param2)
         {
            for each(_loc3_ in womRoot.attackInfo.units)
            {
               if(_loc4_ == _loc3_.typeId && _loc3_.status == UnitStatusType.WAITING_TO_DEPLOY)
               {
                  _loc3_.status = UnitStatusType.DEPLOYING;
                  womRoot.eventDispatcher.dispatchEvent(new ModelUpdateEvent("attackingUnitUpdated"));
                  return true;
               }
            }
         }
         setDeployDiameter(0);
         return true;
      }
      
      public function setDeployDiameter(param1:int, param2:int = 0, param3:int = -1) : void
      {
         var _loc10_:GameSprite = null;
         var _loc7_:int = 0;
         var _loc6_:DeployCircleMouseFollow = null;
         var _loc12_:GameSprite = null;
         var _loc4_:String = null;
         var _loc13_:String = null;
         var _loc8_:StarlingAtlasReference = null;
         var _loc11_:Number = NaN;
         var _loc9_:StarlingAtlasReference = null;
         var _loc15_:GameSprite = null;
         var _loc5_:DeployCircleMouseFollow = null;
         var _loc14_:SprayView = null;
         this.diameter = param1;
         _deploymentMode = param2;
         if(womRoot.canvasMode == CanvasMode.MOBILE_SIEGE_TOWER)
         {
            womRoot.eventItemsManager.cancelDeployWarBuilding();
         }
         if(param1 == 0)
         {
            if(sprayTool)
            {
               while(sprayTool.children.length > 0)
               {
                  _loc10_ = sprayTool.children[0] as GameSprite;
                  _loc7_ = _loc10_.view.layerId;
                  if(_loc7_ == 3)
                  {
                     (sprayTool.view as CompositeView).clearChild(_loc10_);
                  }
                  else
                  {
                     owner.root.layers[_loc7_].remove(_loc10_);
                  }
                  sprayTool.destroyChild(_loc10_);
               }
               womRoot.eventDispatcher.dispatchEvent(new MobileCanvasOptionsPanelEvent("closeBuilidingOptionsPanel"));
               womRoot.canvasMode = CanvasMode.NORMAL;
               womRoot.movingConstructable = null;
               owner.root.removeChild(sprayTool);
               sprayTool.destroyAll();
               sprayTool = null;
               catapultManager2.removeCurrentCatapultPlan();
            }
         }
         else if(!sprayTool)
         {
            if(param2 != 2)
            {
               return;
            }
            (owner.root as WomGameRoot).eventDispatcher.dispatchEvent(new MobileCanvasOptionsPanelEvent("showBuilidingOptionsPanel",(owner.root as WomGameRoot).mobileOptionsPanel = new MobileCanvasOptionsPanel()));
            sprayTool = new GameSprite();
            sprayTool.componentManager.add(sprayTool.view = new CompositeView());
            sprayTool.componentManager.add(new IsoOffsetProjection(new Point3(10000,10000)));
            sprayTool.componentManager.add(sprayTool.bounds = new CompositeRenderBounds());
            sprayTool.componentManager.add(sprayTool.position = new Position(new Point3()));
            _loc6_ = new DeployCircleMouseFollow(param2,catapultManager2.currentCatapultPlan);
            sprayTool.componentManager.add(_loc6_);
            sprayTool.composite = sprayTool;
            _loc12_ = new GameSprite();
            _loc4_ = param3 + "";
            _loc4_ = "3";
            _loc13_ = param2 == 2 ? "CatapultCircle" + _loc4_ : "TowerRange";
            _loc8_ = owner.root.atlasManager.getAtlasReference(_loc13_);
            owner.root.addChild(sprayTool);
            sprayTool.init();
            owner.root.layers[3].add(sprayTool);
            _loc12_.componentManager.add(_loc12_.view = new AssetView(2,_loc13_,true));
            _loc12_.componentManager.add(new BaseProjection());
            _loc12_.componentManager.add(_loc12_.bounds = new CompositeChildRenderBounds());
            _loc12_.componentManager.add(_loc12_.position = new Position(new Point3(-_loc8_.width >> 1,-_loc8_.height >> 1)));
            _loc12_.composite = sprayTool;
            sprayTool.addChild(_loc12_);
            (owner.root.layers[2] as Layer).add(_loc12_);
            _loc12_.init();
            _loc11_ = param1 * (womRoot.projection as IsoProjection).pitchX * Math.sqrt(2) / (_loc8_.width * 2);
            _loc12_.view.scale(_loc11_,_loc11_ / 2);
            _loc9_ = owner.root.atlasManager.getAtlasReference("CatapultDrag");
            _loc15_ = new GameSprite();
            _loc15_.componentManager.add(_loc15_.view = new AssetView(3,"CatapultDrag"));
            _loc15_.componentManager.add(new BaseProjection());
            _loc15_.componentManager.add(_loc15_.bounds = new CompositeChildRenderBounds());
            _loc15_.componentManager.add(_loc15_.position = new Position(new Point3(-_loc9_.width >> 1,-_loc9_.height >> 1,10000)));
            _loc15_.composite = sprayTool;
            (sprayTool.view as CompositeView).addChild(_loc15_);
            sprayTool.addChild(_loc15_);
            _loc15_.init();
            sprayTool.interactive = true;
            womRoot.movingConstructable = sprayTool;
            womRoot.canvasMode = CanvasMode.MOBILE_CATAPULT;
         }
         else
         {
            if(param2 != 2)
            {
               return;
            }
            _loc5_ = sprayTool.componentManager["MouseFollow"] as DeployCircleMouseFollow;
            _loc5_.deploymentMode = param2;
            _loc5_.catapultObject = catapultManager2.currentCatapultPlan;
            _loc5_.init();
            _loc14_ = sprayTool.view as SprayView;
            _loc14_.deploymentMode = param2;
            _loc14_.salvoType = param2 == 2 ? param3 : -1;
            _loc14_.setSize(param1);
            _loc14_.init();
         }
      }
      
      public function handleCatapultDeployment(param1:int, param2:int) : void
      {
         catapultManager2.startCatapultPlan(param1,param2);
         setDeployDiameter(catapultManager2.currentDIO.rangesPerStaqe[param2] / 5,2,param1);
      }
      
      public function retreatBeast() : void
      {
         if(battleFieldControl.beast)
         {
            if(false && battleFieldControl.beast.data.info.status == UnitStatusType.DEAD)
            {
               return;
            }
            battleFieldControl.beast.attack.retreatAttack();
            notifier.beastRetreated();
         }
      }
      
      override public function destroy() : void
      {
         if(sprayTool)
         {
            owner.root.layers[2].remove(sprayTool);
            owner.root.removeChild(sprayTool);
            sprayTool = null;
         }
         battleFieldControl.destroy();
         effects.destroy();
         catapultManager2.destroy();
         super.destroy();
      }
      
      private function sortBuildings(param1:Building, param2:Building) : int
      {
         return param1.data.buildingInfo.instanceId < param2.data.buildingInfo.instanceId ? -1 : 1;
      }
      
      private function get isAnyMercSelected() : Boolean
      {
         return diameter != 0;
      }
   }
}

