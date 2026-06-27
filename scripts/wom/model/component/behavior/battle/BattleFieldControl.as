package wom.model.component.behavior.battle
{
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import peak.cuckoo.core.Behavior;
   import peak.cuckoo.game.behavior.FpsSync;
   import peak.cuckoo.game.dto.Point3;
   import peak.thread.IdleWorkerThreadEvent;
   import peak.util.ValidationRecorder;
   import peak.util.ValidationVerifier;
   import wom.controller.event.combat.CombatEventItemsEvent;
   import wom.controller.event.tutorial.TutorialTriggerEvent;
   import wom.model.component.CuckooNotifier;
   import wom.model.component.WomGameRoot;
   import wom.model.component.behavior.battle.tower.CombineDefenseBuilding;
   import wom.model.component.behavior.battle.tower.TowerDefense;
   import wom.model.component.entity.attackcluster.AttackCluster;
   import wom.model.component.entity.attackcluster.DragonFlyAttackCluster;
   import wom.model.component.entity.attackcluster.FlyingAttackCluster;
   import wom.model.component.entity.attackcluster.HealingAttackCluster;
   import wom.model.component.entity.attackcluster.SiegeTowerAttackCluster;
   import wom.model.component.entity.attackcluster.WalkingAttackCluster;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.component.entity.gamesprite.Unit;
   import wom.model.component.structure.BattleField;
   import wom.model.domain.domaininfoobject.GenericUnitTypeDIO;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.dto.DeployBeastCircleInfoDTO;
   import wom.model.dto.DeployUnitCircleInfoDTO;
   import wom.model.dto.UnitClusterDTO;
   import wom.model.dto.UnitTypeAmountDTO;
   import wom.model.game.AttackInfo;
   import wom.model.game.attack.GameModeType;
   import wom.model.game.defense.NPCAttackDirection;
   import wom.model.game.unit.UnitInfo;
   import wom.model.game.unit.UnitStatusType;
   import wom.model.game.unit.UnitTypeInfo;
   
   public class BattleFieldControl extends Behavior
   {
      
      public static const TYPE_ID:String = "BattleFieldControl";
      
      public static const BATTLEFIELD_FACTOR:int = 10;
      
      private const FORCE_TO_CLUSTERAZITION_LIMIT:int = 5;
      
      private var battleManager:BattleManager;
      
      private var towers:Vector.<TowerDefense>;
      
      public var clusters:Vector.<AttackCluster>;
      
      public var battleFieldRegisteredBuildings:Array;
      
      public var battleFields:Array;
      
      private var root:WomGameRoot;
      
      private var combineDefenceBuildings:Vector.<CombineDefenseBuilding>;
      
      public var beast:Unit;
      
      private var shown:Dictionary = new Dictionary();
      
      public function BattleFieldControl(param1:BattleManager)
      {
         super();
         this.battleManager = param1;
      }
      
      override public function get typeId() : String
      {
         return "BattleFieldControl";
      }
      
      override public function init() : void
      {
         super.init();
         clusters = new Vector.<AttackCluster>();
         battleFieldRegisteredBuildings = [];
         battleFields = [];
         root = battleManager.owner.root as WomGameRoot;
         towers = new Vector.<TowerDefense>();
         combineDefenceBuildings = new Vector.<CombineDefenseBuilding>();
      }
      
      public function addTowerToCheckGrid(param1:TowerDefense) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         towers.push(param1);
         var _temp_2:* = param1.tm;
         var _loc5_:WorkerThread;
         var _loc7_:Number = (_loc5_ = root.tds)._value;
         var _loc6_:WorkerThread = _temp_2;
         _loc6_._value = _loc7_;
         _loc4_ = param1.iS;
         while(_loc4_ <= param1.iF)
         {
            _loc3_ = param1.jS;
            while(_loc3_ <= param1.jF)
            {
               _loc2_ = (_loc4_ << 10) + (_loc3_ << 0);
               if(battleFields[_loc2_])
               {
                  (battleFields[_loc2_] as BattleField).towers.push(param1);
               }
               else
               {
                  ((battleFields[_loc2_] = new BattleField()) as BattleField).towers.push(param1);
               }
               _loc3_++;
            }
            _loc4_++;
         }
         if(param1 is CombineDefenseBuilding)
         {
            combineDefenceBuildings.push(param1 as CombineDefenseBuilding);
         }
      }
      
      public function removeTowerFromCheckGrid(param1:TowerDefense) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:BattleField = null;
         _loc4_ = param1.iS;
         while(_loc4_ <= param1.iF)
         {
            _loc3_ = param1.jS;
            while(_loc3_ <= param1.jF)
            {
               _loc2_ = battleFields[(_loc4_ << 10) + (_loc3_ << 0)];
               _loc2_.towers.splice(_loc2_.towers.indexOf(param1),1);
               _loc3_++;
            }
            _loc4_++;
         }
         towers.splice(towers.indexOf(param1),1);
      }
      
      override public function update() : void
      {
         var _loc14_:int = 0;
         var _loc12_:int = 0;
         var _loc7_:TowerDefense = null;
         var _loc3_:Unit = null;
         var _loc9_:AttackCluster = null;
         var _loc4_:int = 0;
         var _loc2_:BattleField = null;
         var _loc13_:int = 0;
         var _loc11_:TowerDefense = null;
         var _loc1_:int = 0;
         var _loc8_:CombineDefenseBuilding = null;
         var _loc10_:int = 0;
         var _loc5_:BattleField = null;
         var _loc6_:TowerDefense = null;
         _loc14_ = 0;
         while(_loc14_ < towers.length)
         {
            _loc7_ = towers[_loc14_];
            var _loc15_:WorkerThread = _loc7_.tm;
            var _loc16_:WorkerThread;
            if(_loc15_._value == (_loc16_ = root.tda)._value)
            {
               _loc7_.checkTarget();
            }
            _loc14_++;
         }
         _loc14_ = 0;
         while(_loc14_ < clusters.length)
         {
            _loc9_ = clusters[_loc14_];
            _loc12_ = 0;
            while(_loc12_ < _loc9_.units.length)
            {
               _loc3_ = _loc9_.units[_loc12_];
               _loc4_ = (_loc3_.position.point.x / 10 << 10) + (_loc3_.position.point.y / 10 << 0);
               _loc2_ = battleFields[_loc4_];
               if(_loc2_)
               {
                  _loc13_ = 0;
                  while(_loc13_ < _loc2_.towers.length)
                  {
                     _loc11_ = _loc2_.towers[_loc13_];
                     var _loc17_:WorkerThread = _loc11_.tm;
                     var _loc18_:WorkerThread;
                     if(_loc17_._value == (_loc18_ = root.tds)._value)
                     {
                        _loc1_ = _loc11_.checkUnitToAttack(_loc3_);
                        var _loc19_:WorkerThread;
                        var _loc20_:WorkerThread;
                        if(_loc1_ != (_loc19_ = root.tdrd)._value && _loc1_ != (_loc20_ = root.tdrg)._value)
                        {
                           root.eventDispatcher.dispatchEvent(new IdleWorkerThreadEvent("idleWorkerThread",true,"cuta"));
                        }
                     }
                     _loc13_++;
                  }
               }
               else
               {
                  _loc2_ = new BattleField();
                  battleFields[_loc4_] = _loc2_;
               }
               if(_loc3_.attack.field != _loc2_)
               {
                  if(_loc3_.attack.field)
                  {
                     _loc3_.attack.field.units.splice(_loc3_.attack.field.units.indexOf(_loc3_),1);
                  }
                  _loc3_.attack.field = _loc2_;
                  _loc3_.attack.field.units.push(_loc3_);
               }
               _loc12_++;
            }
            _loc14_++;
         }
         _loc14_ = 0;
         while(_loc14_ < combineDefenceBuildings.length)
         {
            _loc8_ = combineDefenceBuildings[_loc14_];
            _loc12_ = _loc8_.units.length - 1;
            while(_loc12_ >= 0)
            {
               _loc3_ = _loc8_.units[_loc12_];
               _loc10_ = (_loc3_.position.point.x / 10 << 10) + (_loc3_.position.point.y / 10 << 0);
               _loc5_ = battleFields[_loc10_];
               if(!_loc5_)
               {
                  _loc5_ = new BattleField();
                  battleFields[_loc10_] = _loc5_;
               }
               if(_loc3_.data.info.healthPoints <= 0)
               {
                  _loc8_.units.splice(_loc12_,1);
               }
               else if(_loc3_.defence && _loc3_.defence.field != _loc5_)
               {
                  if(_loc3_.defence.field)
                  {
                     _loc3_.defence.field.defenceUnits.splice(_loc3_.defence.field.defenceUnits.indexOf(_loc3_),1);
                  }
                  _loc3_.defence.field = _loc5_;
                  _loc3_.defence.field.defenceUnits.push(_loc3_);
               }
               _loc12_--;
            }
            _loc14_++;
         }
         _loc14_ = 0;
         while(_loc14_ < towers.length)
         {
            _loc6_ = towers[_loc14_];
            var _loc21_:WorkerThread = _loc6_.tm;
            var _loc22_:WorkerThread;
            if(_loc21_._value == (_loc22_ = root.tds)._value && _loc6_.tu)
            {
               var _temp_18:* = _loc6_.tm;
               var _loc23_:WorkerThread;
               var _loc25_:Number = (_loc23_ = root.tda)._value;
               var _loc24_:WorkerThread = _temp_18;
               _loc24_._value = _loc25_;
               _loc6_.startAttack();
            }
            _loc14_++;
         }
      }
      
      public function registerBuilding(param1:Building) : void
      {
         var _loc11_:* = 0;
         var _loc9_:* = 0;
         var _loc7_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc8_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc12_:int = param1.position.point.x;
         var _loc10_:int = param1.position.point.y;
         if(!param1.data.buildingInfo.isTrap)
         {
            _loc7_ = int(param1.data.buildingTypeDIO.pathMargin < 0 ? 0 : param1.data.buildingTypeDIO.pathMargin);
            _loc5_ = param1.data.buildingTypeDIO.baseSize - _loc7_;
            _loc11_ = _loc7_;
            while(_loc11_ < _loc5_)
            {
               _loc9_ = _loc7_;
               while(_loc9_ < _loc5_)
               {
                  battleFieldRegisteredBuildings[(_loc12_ + _loc11_ << 10) + (_loc10_ + _loc9_)] = param1;
                  _loc9_++;
               }
               _loc11_++;
            }
            _loc2_ = param1.position.point.x / 10;
            _loc8_ = (param1.position.point.x + param1.data.buildingTypeDIO.baseSize) / 10;
            _loc3_ = param1.position.point.y / 10;
            _loc6_ = (param1.position.point.y + param1.data.buildingTypeDIO.baseSize) / 10;
            if(_loc2_ < 0)
            {
               _loc2_--;
            }
            if(_loc8_ > 0)
            {
               _loc8_++;
            }
            if(_loc3_ < 0)
            {
               _loc3_--;
            }
            if(_loc6_ > 0)
            {
               _loc6_++;
            }
            _loc11_ = _loc2_;
            while(_loc11_ <= _loc8_)
            {
               _loc9_ = _loc3_;
               while(_loc9_ <= _loc6_)
               {
                  _loc4_ = (_loc11_ << 10) + (_loc9_ << 0);
                  if(battleFields[_loc4_])
                  {
                     (battleFields[_loc4_] as BattleField).buildings.push(param1);
                  }
                  else
                  {
                     ((battleFields[_loc4_] = new BattleField()) as BattleField).buildings.push(param1);
                  }
                  _loc9_++;
               }
               _loc11_++;
            }
         }
      }
      
      public function deregisterBuilding(param1:Building) : void
      {
         var _loc8_:* = 0;
         var _loc7_:* = 0;
         var _loc10_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         var _loc9_:int = 0;
         var _loc11_:BattleField = null;
         var _loc4_:int = 0;
         var _loc13_:int = param1.position.point.x;
         var _loc12_:int = param1.position.point.y;
         if(!param1.data.buildingInfo.isTrap)
         {
            _loc10_ = int(param1.data.buildingTypeDIO.pathMargin < 0 ? 0 : param1.data.buildingTypeDIO.pathMargin);
            _loc5_ = param1.data.buildingTypeDIO.baseSize - _loc10_;
            _loc8_ = _loc10_;
            while(_loc8_ < _loc5_)
            {
               _loc7_ = _loc10_;
               while(_loc7_ < _loc5_)
               {
                  delete battleFieldRegisteredBuildings[(_loc13_ + _loc8_ << 10) + (_loc12_ + _loc7_)];
                  _loc7_++;
               }
               _loc8_++;
            }
            _loc2_ = param1.position.point.x / 10;
            _loc6_ = (param1.position.point.x + param1.data.buildingTypeDIO.baseSize) / 10;
            _loc3_ = param1.position.point.y / 10;
            _loc9_ = (param1.position.point.y + param1.data.buildingTypeDIO.baseSize) / 10;
            if(_loc2_ < 0)
            {
               _loc2_--;
            }
            if(_loc6_ > 0)
            {
               _loc6_++;
            }
            if(_loc3_ < 0)
            {
               _loc3_--;
            }
            if(_loc9_ > 0)
            {
               _loc9_++;
            }
            _loc8_ = _loc2_;
            while(_loc8_ <= _loc6_)
            {
               _loc7_ = _loc3_;
               while(_loc7_ <= _loc9_)
               {
                  _loc11_ = battleFields[(_loc8_ << 10) + (_loc7_ << 0)] as BattleField;
                  if(_loc11_)
                  {
                     _loc4_ = _loc11_.buildings.indexOf(param1);
                     if(_loc4_ != -1)
                     {
                        _loc11_.buildings.splice(_loc4_,1);
                     }
                  }
                  _loc7_++;
               }
               _loc8_++;
            }
         }
      }
      
      public function attackingUnitDied(param1:Unit) : void
      {
         var _loc3_:int = 0;
         if(!param1.root)
         {
            return;
         }
         param1.attack.stopAttackBuilding();
         _loc3_ = param1.attack.othersHitting.length - 1;
         while(_loc3_ >= 0)
         {
            param1.attack.othersHitting[_loc3_].defence.stopAttack();
            _loc3_--;
         }
         param1.attack.othersHitting.length = 0;
         var _loc2_:Vector.<Building> = param1.underAttack.towers.slice();
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            try
            {
               (_loc2_[_loc3_].componentManager["TowerDefense"] as TowerDefense).stopAttack(false);
            }
            catch(e:Error)
            {
            }
            _loc3_++;
         }
         param1.underAttack.towers = new Vector.<Building>(0);
         param1.attack.field.units.splice(param1.attack.field.units.indexOf(param1),1);
         param1.underAttack.unitDestroy();
         battleManager.notifier.attackerUnitDied(param1);
         checkAllUnitDied();
      }
      
      public function checkAllUnitDied() : void
      {
         var _loc1_:Boolean = false;
         if(clusters.length == 0)
         {
            battleManager.notifier.allDeployedUnitsDied();
         }
         else
         {
            for each(var _loc2_ in clusters)
            {
               _loc1_ = _loc2_ is SiegeTowerAttackCluster;
               if(!(_loc2_.retreated || _loc1_ && !_loc2_.leader.attack.enabled))
               {
                  return;
               }
            }
            battleManager.notifier.allDeployedUnitsDied();
         }
      }
      
      public function checkAllBuildingsDestryoed() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:Building = null;
         _loc2_ = 0;
         while(_loc2_ < battleManager.buildings.length)
         {
            _loc1_ = battleManager.buildings[_loc2_];
            if(_loc1_ && _loc1_.data.buildingInfo.buildingTypeId != 41 && !_loc1_.data.buildingInfo.isTrap && _loc1_.data.buildingInfo.healthPoint > 0)
            {
               return false;
            }
            _loc2_++;
         }
         battleManager.notifier.noTargetToAttack();
         return true;
      }
      
      public function defendingUnitDied(param1:Unit) : void
      {
         if(param1.defence.target)
         {
            param1.defence.target.attack.enemyUnitDied(param1);
         }
         param1.defence.field.defenceUnits.splice(param1.defence.field.defenceUnits.indexOf(param1),1);
         battleManager.notifier.defenderUnitDied(param1);
         param1.underAttack.unitDestroy();
      }
      
      public function buildingDestroyed(param1:Building, param2:Number) : void
      {
         if(param1.data.battleDestroyedStatus)
         {
            if(param1.underAttack && param1.underAttack.attackerUnits.length > 0)
            {
               deregisterBuildingAndBalanceCluster(param1);
            }
            param1.data.buildingInfo.healthPoint = 0;
            return;
         }
         deregisterBuildingAndBalanceCluster(param1);
         if("TowerDefense" in param1.componentManager)
         {
            (param1.componentManager["TowerDefense"] as TowerDefense).stopAttack();
            removeTowerFromCheckGrid(param1.componentManager["TowerDefense"]);
         }
         if(param1.underAttack.lootable && param2 > 0)
         {
            battleManager.notifier.notifyDestroyedLoot(root,param1.data.buildingInfo.instanceId);
         }
         battleManager.notifier.notifyBuildingDestroyed(param1.data.buildingInfo.instanceId,param1.data.buildingInfo.buildingTypeId);
         param1.underAttack.destroyBuilding();
         param1.data.battleDestroyedStatus = true;
      }
      
      private function deregisterBuildingAndBalanceCluster(param1:Building) : void
      {
         var _loc10_:int = 0;
         var _loc2_:Unit = null;
         var _loc5_:AttackCluster = null;
         var _loc3_:Boolean = false;
         var _loc9_:int = 0;
         var _loc4_:AttackCluster = null;
         var _loc8_:Vector.<AttackCluster> = new Vector.<AttackCluster>();
         _loc10_ = 0;
         while(_loc10_ < param1.underAttack.attackerUnits.length && clusters.length > 5)
         {
            _loc2_ = param1.underAttack.attackerUnits[_loc10_];
            _loc5_ = _loc2_.data.cluster;
            if(_loc2_.data.info.status == UnitStatusType.DEAD)
            {
               _loc5_ && _loc5_.removeUnit(_loc2_);
            }
            else
            {
               _loc3_ = true;
               _loc9_ = 0;
               while(_loc9_ < _loc8_.length)
               {
                  _loc4_ = _loc8_[_loc9_];
                  if(_loc4_ == _loc5_)
                  {
                     _loc3_ = false;
                     break;
                  }
                  if(!_loc2_.isBeast && _loc2_.data.typeInfo.unitTypeId != 24 && _loc4_.typeInfo && _loc4_.typeInfo.unitTypeId == _loc5_.typeInfo.unitTypeId)
                  {
                     _loc5_.removeUnit(_loc2_);
                     _loc4_.addUnit(_loc2_);
                     _loc3_ = false;
                     break;
                  }
                  _loc9_++;
               }
               if(_loc3_)
               {
                  _loc8_.push(_loc5_);
               }
            }
            _loc10_++;
         }
         deregisterBuilding(param1);
         _loc10_ = 0;
         while(_loc10_ < param1.underAttack.attackerUnits.length)
         {
            _loc2_ = param1.underAttack.attackerUnits[_loc10_];
            _loc2_.attack.stopAttackBuilding(true);
            _loc10_++;
         }
         var _loc6_:Dictionary = new Dictionary();
         var _loc7_:Vector.<Unit> = new Vector.<Unit>();
         _loc10_ = 0;
         while(_loc10_ < param1.underAttack.attackerUnits.length)
         {
            _loc7_.push(param1.underAttack.attackerUnits[_loc10_]);
            _loc10_++;
         }
         _loc10_ = 0;
         while(_loc10_ < _loc7_.length)
         {
            _loc2_ = _loc7_[_loc10_];
            if(!(_loc2_.data.cluster in _loc6_))
            {
               _loc6_[_loc2_.data.cluster] = _loc2_.data.cluster;
               _loc2_.data.cluster.chooseTargetAndFight();
            }
            _loc10_++;
         }
         param1.underAttack.attackerUnits.length = 0;
      }
      
      public function deployUnits(param1:Number, param2:Point, param3:NPCAttackDirection = null) : void
      {
         var unitInfo:UnitInfo;
         var unitTypeDIO:UnitTypeDIO;
         var unitTypeInfo:UnitTypeInfo;
         var levelIndex:int;
         var deployedUnitInfo:UnitTypeAmountDTO;
         var unitClusterDTO:UnitClusterDTO;
         var max:int;
         var selected:UnitClusterDTO;
         var clusterDTO:UnitClusterDTO;
         var balancedUnits:Vector.<UnitInfo>;
         var balancedCluster:UnitClusterDTO;
         var isBeast:Boolean;
         var typeDIO:GenericUnitTypeDIO;
         var cluster:AttackCluster;
         var j:int;
         var x:Number;
         var y:Number;
         var t:Number;
         var unit:Unit;
         var unitsToRemove:Vector.<UnitTypeAmountDTO>;
         var unitTypeId:String;
         var radius:Number = param1;
         var point:Point = param2;
         var direction:NPCAttackDirection = param3;
         var unitClusterDictionary:Dictionary = new Dictionary();
         var unitClusterVector:Vector.<UnitClusterDTO> = new Vector.<UnitClusterDTO>();
         var unitsToRemoveDict:Dictionary = new Dictionary();
         var point3:Point3 = new Point3(point.x,point.y);
         var unitDeployed:Boolean = false;
         var messageEnabled:Boolean = false;
         var ottoman:Boolean = false;
         var spread:Boolean = direction != null;
         var attackInfo:AttackInfo = root.attackInfo;
         var i:int = 0;
         while(i < attackInfo.units.length)
         {
            unitInfo = attackInfo.units[i];
            if(unitInfo.status == UnitStatusType.DEPLOYING)
            {
               unitInfo.status = UnitStatusType.ATTACKING;
               unitTypeDIO = root.domainInfo.getUnit(unitInfo.typeId);
               if(!(unitInfo.typeId in unitClusterDictionary))
               {
                  if(unitInfo.typeId == 23 || unitInfo.typeId == 11)
                  {
                     ottoman = true;
                  }
                  else if(unitTypeDIO.teamSize > 1)
                  {
                     spread = true;
                  }
                  unitClusterDictionary[unitInfo.typeId] = new UnitClusterDTO(unitInfo.typeId,attackInfo.unitTypes[unitInfo.typeId],new Vector.<UnitInfo>());
               }
               (unitClusterDictionary[unitInfo.typeId] as UnitClusterDTO).units.push(unitInfo);
               unitTypeInfo = root.attackInfo.unitTypes[unitInfo.typeId];
               if(unitTypeDIO.teamSize > 1)
               {
                  addAllTeamToCluster(unitTypeDIO,unitClusterDictionary,unitInfo);
               }
               levelIndex = unitTypeInfo.currentLevel - 1;
               if(!(unitInfo.typeId in unitsToRemoveDict))
               {
                  unitsToRemoveDict[unitInfo.typeId] = deployedUnitInfo = new UnitTypeAmountDTO(unitInfo.typeId,0);
               }
               else
               {
                  deployedUnitInfo = unitsToRemoveDict[unitInfo.typeId];
               }
               deployedUnitInfo.amount++;
               messageEnabled = true;
            }
            i = i + 1;
         }
         if(attackInfo.beast && attackInfo.beast.status == UnitStatusType.DEPLOYING)
         {
            attackInfo.beast.status = UnitStatusType.ATTACKING;
            unitClusterDictionary[attackInfo.beast.typeId] = new UnitClusterDTO(attackInfo.beast.typeId,null,new Vector.<UnitInfo>());
            (unitClusterDictionary[attackInfo.beast.typeId] as UnitClusterDTO).units.push(attackInfo.beast);
            CuckooNotifier.getInstance().beastDeployedDTO(new DeployBeastCircleInfoDTO(FpsSync.frameNum,point3,attackInfo.beast.typeId,attackInfo.beast.healthPoints,radius));
         }
         for each(unitClusterDTO in unitClusterDictionary)
         {
            unitClusterVector.push(unitClusterDTO);
         }
         unitClusterVector.sort(function(param1:UnitClusterDTO, param2:UnitClusterDTO):int
         {
            return param1.unitTypeId > param2.unitTypeId ? 1 : -1;
         });
         while(unitClusterVector.length + clusters.length < 5)
         {
            max = 0;
            i = 0;
            while(i < unitClusterVector.length)
            {
               clusterDTO = unitClusterVector[i];
               if(clusterDTO.units.length > max)
               {
                  max = int(clusterDTO.units.length);
                  selected = clusterDTO;
               }
               i = i + 1;
            }
            if(max <= 1)
            {
               break;
            }
            balancedUnits = new Vector.<UnitInfo>();
            i = 0;
            while(i < max / 2)
            {
               balancedUnits.push(selected.units.splice(0,1)[0]);
               i = i + 1;
            }
            unitClusterVector.push(new UnitClusterDTO(selected.unitTypeId,selected.unitTypeInfo,balancedUnits));
         }
         i = 0;
         while(i < unitClusterVector.length)
         {
            balancedCluster = unitClusterVector[i];
            unitDeployed = true;
            unitInfo = balancedCluster.units[0];
            isBeast = UnitTypeInfo.isBeast(unitInfo.typeId);
            typeDIO = isBeast ? root.domainInfo.getBeast(unitInfo.typeId) : root.domainInfo.getUnit(unitInfo.typeId);
            if(unitInfo.typeId == 24)
            {
               cluster = new HealingAttackCluster(root,battleManager,point.x,point.y);
            }
            else if(typeDIO.flying)
            {
               if(typeDIO.id == 25)
               {
                  cluster = new DragonFlyAttackCluster(root,battleManager,point.x,point.y);
               }
               else
               {
                  cluster = new FlyingAttackCluster(root,battleManager,point.x,point.y);
               }
            }
            else
            {
               cluster = new WalkingAttackCluster(root,battleManager,point.x,point.y);
            }
            j = 0;
            while(j < balancedCluster.units.length)
            {
               unitInfo = balancedCluster.units[j];
               x = point.x;
               y = point.y;
               if(spread)
               {
                  t = root.pseudoRandomGenerator.nextDouble() * radius - radius / 2;
                  x += t;
                  t = root.pseudoRandomGenerator.nextDouble() * radius - radius / 2;
                  y += t;
               }
               unit = battleManager.unitFactory.addUnitToCanvas(unitInfo,balancedCluster.unitTypeInfo,x,y);
               if(unit.data.typeDIO.flying)
               {
                  unit.position.point.z = 15;
               }
               unit.data.cluster = cluster;
               cluster.addUnit(unit);
               unit.init();
               if(isBeast)
               {
                  beast = unit;
               }
               if(direction && !shown[direction])
               {
                  shown[direction] = true;
                  root.screenPanning.addPoint(unit.position.projected);
               }
               j = j + 1;
            }
            clusters.push(cluster);
            cluster.chooseTargetAndFight();
            i = i + 1;
         }
         if(unitDeployed)
         {
            battleManager.notifier.unitDeployed(ottoman);
         }
         if(messageEnabled && root.userInfo.gameMode == GameModeType.ATTACK)
         {
            unitsToRemove = new Vector.<UnitTypeAmountDTO>();
            for(unitTypeId in unitsToRemoveDict)
            {
               unitsToRemove.push(unitsToRemoveDict[unitTypeId]);
               if(root.domainInfo.getUnit(int(unitTypeId)).event)
               {
                  root.eventDispatcher.dispatchEvent(new CombatEventItemsEvent("itemDeployed",int(unitTypeId)));
               }
            }
            if(unitsToRemove.length > 0)
            {
               CuckooNotifier.getInstance().unitDeployedDTO(new DeployUnitCircleInfoDTO(FpsSync.frameNum,point3,radius,unitsToRemove,getTimer() - attackInfo.attackStartTime));
            }
            root.eventDispatcher.dispatchEvent(new TutorialTriggerEvent("defaultActionTriggered"));
         }
      }
      
      private function addAllTeamToCluster(param1:UnitTypeDIO, param2:Dictionary, param3:UnitInfo) : void
      {
         var _loc4_:int = 0;
         var _loc5_:Vector.<UnitInfo> = (param2[param3.typeId] as UnitClusterDTO).units;
         _loc4_ = 1;
         while(_loc4_ < param1.teamSize)
         {
            _loc5_.push(param3.clone());
            _loc4_++;
         }
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}

