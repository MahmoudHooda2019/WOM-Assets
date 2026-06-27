package wom.model.component.factory
{
   import flash.geom.Point;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.attribute.Position;
   import peak.cuckoo.game.attribute.bounds.notCompositeBased.ParentRenderBounds;
   import peak.cuckoo.game.attribute.projection.IsoProjection;
   import peak.cuckoo.game.dto.Point3;
   import wom.model.component.attribute.data.UnitData;
   import wom.model.component.attribute.data.WorkerData;
   import wom.model.component.attribute.data.WorkerStatus;
   import wom.model.component.attribute.grid.CityGrid;
   import wom.model.component.attribute.projection.IsoUnitProjection;
   import wom.model.component.attribute.viewManager.UnitViewManager;
   import wom.model.component.behavior.battle.attack.AreaBuffDispenserAndFollower;
   import wom.model.component.behavior.battle.attack.BlowingUnitAttackManager;
   import wom.model.component.behavior.battle.attack.RangedUnitAttackManager;
   import wom.model.component.behavior.battle.attack.UnitAttackManager;
   import wom.model.component.behavior.battle.hit.SingleHit;
   import wom.model.component.behavior.battle.hit.SplashHit;
   import wom.model.component.behavior.battle.underatack.UnderAttackUnit;
   import wom.model.component.behavior.battle.visuals.CalculationIdle;
   import wom.model.component.behavior.building.CombineBuildingChildManager;
   import wom.model.component.behavior.movement.MovementAir;
   import wom.model.component.behavior.movement.MovementUnderGround;
   import wom.model.component.behavior.movement.MovementWalk;
   import wom.model.component.behavior.unit.Speak;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.component.entity.gamesprite.Unit;
   import wom.model.component.entity.gamesprite.Worker;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BeastTypeDIO;
   import wom.model.domain.domaininfoobject.GenericUnitTypeDIO;
   import wom.model.domain.domaininfoobject.WorkerTypeDIO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.WomGameRootHolder;
   import wom.model.game.attack.GameModeType;
   import wom.model.game.beast.BeastInfo;
   import wom.model.game.unit.UnitInfo;
   import wom.model.game.unit.UnitStatusType;
   import wom.model.game.unit.UnitTypeInfo;
   
   public class DefaultUnitFactory implements UnitFactory
   {
      
      private static var unitIdGenerator:int = 0;
      
      public var gameRootHolder:WomGameRootHolder;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      public function DefaultUnitFactory()
      {
         super();
      }
      
      public static function generateUnitId() : int
      {
         return ++unitIdGenerator;
      }
      
      [PostConstruct]
      public function init() : void
      {
      }
      
      public function setGameRootHolder(param1:WomGameRootHolder) : void
      {
         this.gameRootHolder = param1;
      }
      
      public function addBeastToCanvas(param1:BeastInfo, param2:int, param3:int, param4:int = 0) : Unit
      {
         var _loc5_:Unit = createUnit(param1,null,param2,param3,param4);
         gameRootHolder.gameRoot.layers[3].add(_loc5_);
         return _loc5_;
      }
      
      public function addUnitToCanvas(param1:UnitInfo, param2:UnitTypeInfo, param3:int, param4:int, param5:int = 0) : Unit
      {
         var _loc6_:Unit = createUnit(param1,param2,param3,param4,param5);
         gameRootHolder.gameRoot.layers[3].add(_loc6_);
         return _loc6_;
      }
      
      public function createUnit(param1:UnitInfo, param2:UnitTypeInfo = null, param3:Number = 0, param4:Number = 0, param5:Number = 0, param6:Boolean = true) : Unit
      {
         var _loc12_:int = param1.typeId;
         var _loc9_:Unit = new Unit();
         var _loc7_:Boolean = param1 is BeastInfo;
         _loc9_.isBeast = _loc7_;
         var _loc10_:GenericUnitTypeDIO = _loc7_ ? domainInfo.getBeast(_loc12_) : domainInfo.getUnit(_loc12_);
         var _loc8_:UnitData = new UnitData(param1,param2,_loc10_,_loc7_);
         _loc9_.componentManager.add(_loc9_.data = _loc8_);
         _loc9_.componentManager.add(_loc9_.viewManager = new UnitViewManager(_loc9_,param1,param2,_loc10_,null,gameRootHolder));
         _loc9_.componentManager.add(_loc9_.position = new Position(new Point3(param3,param4,0)));
         var _loc11_:Point = _loc7_ ? (_loc10_ as BeastTypeDIO).animationSortPointsPerStage[_loc8_.levelIndex] : _loc10_.animationSortPoint;
         var _loc13_:IsoProjection = new IsoUnitProjection(new Point3(_loc11_.x,_loc11_.y));
         _loc9_.componentManager.add(_loc9_.bounds = new ParentRenderBounds());
         _loc9_.componentManager.add(_loc13_);
         if(_loc10_.flying)
         {
            _loc9_.componentManager.add(_loc9_.movement = new MovementAir());
         }
         else if(_loc10_.id == 22 && (param1.status == UnitStatusType.ATTACKING || param1.status == UnitStatusType.DEFENDING || param1.status == UnitStatusType.IN_WATCH_POST) && (gameRootHolder.gameRoot.userInfo.gameMode == GameModeType.ATTACK || gameRootHolder.gameRoot.userInfo.gameMode == GameModeType.DEFEND || gameRootHolder.gameRoot.userInfo.gameMode == GameModeType.TUSK_HORN))
         {
            _loc9_.componentManager.add(_loc9_.movement = new MovementUnderGround());
         }
         else
         {
            _loc9_.componentManager.add(_loc9_.movement = new MovementWalk());
         }
         _loc9_.componentManager.add(_loc8_);
         if(gameRootHolder.gameRoot.battleManager)
         {
            if(gameRootHolder.gameRoot.userInfo.gameMode == GameModeType.ATTACK || gameRootHolder.gameRoot.userInfo.gameMode == GameModeType.DEFEND || gameRootHolder.gameRoot.userInfo.gameMode == GameModeType.TUSK_HORN)
            {
               _loc9_.componentManager.add(new CalculationIdle());
               switch(_loc10_.id - 25)
               {
                  case 0:
                     _loc9_.componentManager.add(new AreaBuffDispenserAndFollower(gameRootHolder.gameRoot.battleManager));
               }
               if(param1.typeId == 14)
               {
                  _loc9_.componentManager.add(_loc9_.attack = new BlowingUnitAttackManager(gameRootHolder.gameRoot.battleManager));
               }
               else if(_loc9_.data.range > 0)
               {
                  _loc9_.componentManager.add(_loc9_.attack = new RangedUnitAttackManager());
                  if(!_loc10_.flying && !_loc7_)
                  {
                     (_loc9_.attack as RangedUnitAttackManager).arrowThrower = true;
                  }
                  _loc9_.movement.ranged = _loc9_.data.range;
               }
               else if(!"UnitAttackManager" in _loc9_.componentManager || !_loc9_.attack)
               {
                  _loc9_.componentManager.add(_loc9_.attack = new UnitAttackManager());
               }
               if(_loc10_.splashRange == 0)
               {
                  _loc9_.componentManager.add(_loc9_.hit = new SingleHit());
               }
               else
               {
                  _loc9_.componentManager.add(_loc9_.hit = new SplashHit());
               }
               _loc9_.componentManager.add(_loc9_.underAttack = new UnderAttackUnit(gameRootHolder.gameRoot.battleManager));
            }
         }
         gameRootHolder.gameRoot.addChild(_loc9_);
         _loc9_.init();
         if(param6)
         {
            gameRootHolder.gameRoot.units[param1.instanceId] = _loc9_;
         }
         return _loc9_;
      }
      
      public function addBeastToCave(param1:BeastInfo) : void
      {
         var _loc3_:Building = gameRootHolder.gameRoot.buildings[param1.buildingId];
         var _loc2_:Unit = createUnit(param1);
         (_loc3_.componentManager["CombineBuildingChildManager"] as CombineBuildingChildManager).addUnit(_loc2_);
      }
      
      public function addUnitToBarracks(param1:UnitInfo, param2:UnitTypeInfo) : void
      {
         var _loc4_:Building = gameRootHolder.gameRoot.buildings[param1.buildingId];
         var _loc3_:Unit = createUnit(param1,param2,0,0);
         (_loc4_.componentManager["CombineBuildingChildManager"] as CombineBuildingChildManager).addUnit(_loc3_);
      }
      
      public function addHiredUnitToBarracks(param1:UnitInfo, param2:UnitTypeInfo, param3:int) : void
      {
         var unit:UnitInfo = param1;
         var unitTypeInfo:UnitTypeInfo = param2;
         var hiringQuartersId:int = param3;
         var sparseBarracks:Building = gameRootHolder.gameRoot.buildings[unit.buildingId];
         var cbcm:CombineBuildingChildManager = sparseBarracks.componentManager["CombineBuildingChildManager"] as CombineBuildingChildManager;
         var start:Point3 = (gameRootHolder.gameRoot.buildings[hiringQuartersId] as GameSprite).position.point;
         var newUnit:Unit = createUnit(unit,unitTypeInfo,start.x,start.y);
         gameRootHolder.gameRoot.addChild(newUnit);
         gameRootHolder.gameRoot.layers[3].add(newUnit);
         newUnit.init();
         newUnit.movement.moveToPoint(new Point3(sparseBarracks.position.point.x,sparseBarracks.position.point.y,0));
         newUnit.movement.movementFinished.addFunctionOnce(function(param1:Unit):void
         {
            cbcm.addUnit(param1,true);
         });
         gameRootHolder.gameRoot.units[unit.instanceId] = newUnit;
      }
      
      private function addWorkerToCanvas(param1:Number, param2:Number) : Worker
      {
         var _loc3_:Worker = new Worker();
         var _loc5_:WorkerTypeDIO = domainInfo.getWorker();
         _loc3_.componentManager.add(_loc3_.viewManager = new UnitViewManager(_loc3_,null,null,null,_loc5_,gameRootHolder));
         _loc3_.componentManager.add(_loc3_.data = new WorkerData(_loc5_));
         _loc3_.componentManager.add(_loc3_.position = new Position(new Point3(param1,param2,0)));
         var _loc4_:IsoProjection = new IsoUnitProjection(new Point3(_loc5_.animationSortPoint.x,_loc5_.animationSortPoint.y));
         _loc3_.componentManager.add(_loc3_.bounds = new ParentRenderBounds());
         _loc3_.componentManager.add(_loc4_);
         _loc3_.componentManager.add(_loc3_.movement = new MovementWalk());
         _loc3_.componentManager.add(new Speak());
         gameRootHolder.gameRoot.addChild(_loc3_);
         gameRootHolder.gameRoot.layers[3].add(_loc3_);
         _loc3_.init();
         return _loc3_;
      }
      
      public function setWorkerCount(param1:int) : void
      {
         var _loc9_:int = 0;
         var _loc6_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc2_:int = 0;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc4_:Worker = null;
         var _loc3_:WorkerStatus = null;
         _loc9_ = int(gameRootHolder.gameRoot.workers.length);
         while(_loc9_ < param1)
         {
            _loc6_ = (gameRootHolder.gameRoot.componentManager["CityGrid"] as CityGrid).dimension.numberOfColumns / 2;
            _loc5_ = (gameRootHolder.gameRoot.componentManager["CityGrid"] as CityGrid).dimension.numberOfRows / 2;
            _loc2_ = Math.random() * 8;
            if(_loc2_ % 2 == 0)
            {
               _loc7_ = Math.random() * _loc6_ * 2 - _loc6_;
               _loc8_ = Math.random() * 40 - 20;
               _loc8_ = _loc8_ < 0 ? -1 * _loc5_ + _loc8_ : _loc5_ + _loc8_;
            }
            else
            {
               _loc8_ = Math.random() * _loc5_ * 2 - _loc5_;
               _loc7_ = Math.random() * 40 - 20;
               _loc7_ = _loc7_ < 0 ? -1 * _loc6_ + _loc7_ : _loc6_ + _loc7_;
            }
            _loc4_ = addWorkerToCanvas(_loc7_,_loc8_);
            _loc3_ = new WorkerStatus(false);
            _loc4_.componentManager.add(_loc3_);
            _loc3_.init();
            _loc4_.animation.direction = _loc2_ << 0;
            gameRootHolder.gameRoot.workers.push(_loc4_);
            _loc9_++;
         }
      }
      
      public function assignAlreadyWorkingWorker(param1:Building) : void
      {
         var _loc2_:Number = param1.position.point.x;
         var _loc4_:Number = param1.position.point.y;
         var _loc7_:int = param1.data.buildingTypeDIO.baseSize;
         var _loc5_:int = Math.random() * _loc7_;
         if(_loc5_ % 4 == 0)
         {
            _loc2_ += _loc5_;
            _loc4_++;
         }
         else if(_loc5_ % 4 == 1)
         {
            _loc2_ += _loc5_;
            _loc4_ += _loc7_ - 1;
         }
         else if(_loc5_ % 4 == 2)
         {
            _loc2_++;
            _loc4_ += _loc5_;
         }
         else
         {
            _loc2_ += _loc7_ - 1;
            _loc4_ += _loc5_;
         }
         var _loc6_:Unit = addWorkerToCanvas(_loc2_,_loc4_);
         var _loc3_:WorkerStatus = new WorkerStatus(true);
         _loc3_.targetBuilding = param1;
         _loc6_.componentManager.add(_loc3_);
         _loc3_.attendingX = param1.position.point.x;
         _loc3_.attendingY = param1.position.point.y;
         _loc6_.animation.state = 2;
         _loc6_.movement.faceTo(param1.position.point);
         gameRootHolder.gameRoot.workers.push(_loc6_);
         _loc3_.init();
      }
   }
}

