package wom.model.component.behavior.battle.attack
{
   import peak.cuckoo.core.Behavior;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.behavior.FpsSync;
   import peak.cuckoo.game.dto.Point3;
   import wom.model.component.WomGameRoot;
   import wom.model.component.attribute.data.UnitData;
   import wom.model.component.behavior.battle.BattleFieldControl;
   import wom.model.component.behavior.battle.BattleManager;
   import wom.model.component.behavior.battle.underatack.UnderAttackBuilding;
   import wom.model.component.behavior.movement.Movement;
   import wom.model.component.entity.attackcluster.AttackCluster;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.component.entity.gamesprite.Unit;
   import wom.model.component.structure.BattleField;
   import wom.model.domain.domaininfoobject.BeastTypeDIO;
   import wom.model.game.beast.BeastInfo;
   import wom.model.game.unit.UnitStatusType;
   
   public class AreaBuffDispenserAndFollower extends Behavior
   {
      
      public static const TYPE_ID:String = "AreaBuffDispenserAndFollower";
      
      private const UPDATE_PERIOD:int = 60;
      
      private var wait:Number = 0;
      
      private var sync:FpsSync;
      
      private var battleField:Array;
      
      private var battleControl:BattleFieldControl;
      
      private var battleManager:BattleManager;
      
      private var position:Point3;
      
      private var attacker:Boolean;
      
      private var ownerUnit:Unit;
      
      private var activeBuffList:Vector.<Unit>;
      
      private var tempBuffList:Vector.<Unit>;
      
      private var range:int;
      
      private var damageModifier:Number;
      
      private var speedModifier:Number;
      
      private var armorModifier:Number;
      
      public var unitToFollow:Unit;
      
      private var ownerCluster:AttackCluster;
      
      public function AreaBuffDispenserAndFollower(param1:BattleManager)
      {
         super();
         priority = 0;
         this.battleControl = param1.battleFieldControl;
         this.battleField = param1.battleFieldControl.battleFields;
         this.battleManager = param1;
      }
      
      override public function get typeId() : String
      {
         return "AreaBuffDispenserAndFollower";
      }
      
      override public function init() : void
      {
         super.init();
         ownerUnit = owner as Unit;
         sync = owner.root.sync;
         position = (owner as GameSprite).position.point;
         activeBuffList = new Vector.<Unit>();
         tempBuffList = new Vector.<Unit>();
         attacker = !("DefensiveUnit" in owner.componentManager);
         var _loc3_:UnitData = (owner as Unit).data;
         range = _loc3_.range;
         var _loc4_:BeastTypeDIO = _loc3_.typeDIO as BeastTypeDIO;
         var _loc2_:BeastInfo = _loc3_.info as BeastInfo;
         var _loc1_:Number = Number(_loc2_.bonusStage > 0 ? _loc4_.buffsPerStage[_loc2_.bonusStage - 1] : _loc4_.buffsPerLevel[_loc2_.level - 1]);
         _loc1_ /= 100;
         damageModifier = 1 + _loc1_;
         speedModifier = 1 + _loc1_;
         armorModifier = 1 - _loc1_;
         unitToFollow = null;
         ownerCluster = ownerUnit.data.cluster;
      }
      
      override public function update() : void
      {
         var _loc14_:* = null;
         var _loc11_:* = undefined;
         var _loc13_:Unit = null;
         var _loc12_:* = 0;
         var _loc7_:* = 0;
         var _loc3_:int = 0;
         var _loc9_:int = 0;
         var _loc8_:Unit = null;
         var _loc4_:int = 0;
         var _loc18_:AttackCluster = null;
         var _loc10_:Unit = null;
         var _loc5_:Number = NaN;
         var _loc20_:Number = NaN;
         wait -= sync.precise;
         if(wait > 0)
         {
            return;
         }
         wait = 60;
         for each(_loc14_ in activeBuffList)
         {
            _loc14_.data.beastBuff = 2;
         }
         var _loc1_:int = (position.x - range) / 10;
         var _loc6_:int = (position.x + range) / 10;
         var _loc2_:int = (position.y - range) / 10;
         var _loc16_:int = (position.y + range) / 10;
         if(_loc1_ < 0)
         {
            _loc1_--;
         }
         if(_loc6_ > 0)
         {
            _loc6_++;
         }
         if(_loc2_ < 0)
         {
            _loc2_--;
         }
         if(_loc16_ > 0)
         {
            _loc16_++;
         }
         _loc12_ = _loc1_;
         while(_loc12_ <= _loc6_)
         {
            _loc7_ = _loc2_;
            while(_loc7_ <= _loc16_)
            {
               _loc3_ = (_loc12_ << 10) + (_loc7_ << 0);
               if(battleField[_loc3_])
               {
                  if(attacker)
                  {
                     _loc11_ = (battleField[_loc3_] as BattleField).units;
                  }
                  else
                  {
                     _loc11_ = (battleField[_loc3_] as BattleField).defenceUnits;
                  }
                  _loc9_ = 0;
                  while(_loc9_ < _loc11_.length)
                  {
                     _loc13_ = _loc11_[_loc9_];
                     if(!(!_loc13_.data.buffAvailable || _loc13_.isBeast))
                     {
                        if(_loc13_.data.beastBuff == 2)
                        {
                           _loc13_.data.beastBuff = 1;
                        }
                        else
                        {
                           _loc13_.data.armorBuffModifier *= armorModifier;
                           _loc13_.data.speedBuffModifier *= speedModifier;
                           _loc13_.data.damageBuffModifier *= damageModifier;
                           _loc13_.data.beastBuff = 1;
                           _loc13_.data.calculateStats();
                        }
                        tempBuffList.push(_loc13_);
                     }
                     _loc9_++;
                  }
               }
               _loc7_++;
            }
            _loc12_++;
         }
         for each(_loc14_ in activeBuffList)
         {
            if(_loc14_.data.beastBuff == 2)
            {
               _loc14_.data.armorBuffModifier /= armorModifier;
               _loc14_.data.speedBuffModifier /= speedModifier;
               _loc14_.data.damageBuffModifier /= damageModifier;
               _loc14_.data.beastBuff = 0;
               _loc14_.data.calculateStats();
            }
         }
         activeBuffList.length = 0;
         var _loc19_:Vector.<Unit> = activeBuffList;
         activeBuffList = tempBuffList;
         tempBuffList = _loc19_;
         if(!attacker || ownerUnit.data.cluster.retreated || ownerUnit.attack.targetUnit)
         {
            return;
         }
         if(unitToFollow && (unitToFollow.data.info.status == UnitStatusType.RETREATED || unitToFollow.data.info.status == UnitStatusType.DEAD || unitToFollow.movement.enabled || unitToFollow.attack.targetUnit || ownerUnit.attack.targetBuilding != unitToFollow.attack.targetBuilding))
         {
            unitToFollow = null;
         }
         var _loc17_:Number = 1.7976931348623157e+308;
         _loc4_ = 0;
         while(_loc4_ < battleControl.clusters.length)
         {
            _loc18_ = battleControl.clusters[_loc4_];
            if(_loc18_.units.length > 0)
            {
               _loc10_ = _loc18_.leader;
               if(!(_loc10_ == ownerUnit || !_loc10_.data.buffAvailable || _loc10_.data.info.typeId == 24))
               {
                  _loc5_ = (_loc10_.position.point.x - ownerUnit.position.point.x) * (_loc10_.position.point.x - ownerUnit.position.point.x) + (_loc10_.position.point.y - ownerUnit.position.point.y) * (_loc10_.position.point.y - ownerUnit.position.point.y);
                  _loc20_ = Math.sqrt(_loc5_) / 100;
                  for each(var _loc15_ in _loc18_.units)
                  {
                     var _loc25_:WorkerThread;
                     _loc5_ = _loc20_ + _loc15_.data.info.healthPoints / (_loc25_ = _loc15_.data.maxHealthPoint)._value;
                     if(!_loc15_.attack.targetUnit)
                     {
                        if(!_loc8_ || _loc5_ < _loc17_)
                        {
                           _loc17_ = _loc5_;
                           _loc8_ = _loc15_;
                        }
                     }
                  }
               }
            }
            _loc4_++;
         }
         if(unitToFollow != _loc8_ && _loc8_)
         {
            if(ownerUnit.attack.targetBuilding)
            {
               ownerUnit.attack.stopAttackBuilding();
            }
            unitToFollow = _loc8_;
            ownerUnit.movement.moveToPoint(new Point3(_loc8_.position.point.x,_loc8_.position.point.y),30);
            ownerUnit.movement.movementFinished.addFunctionOnce(catchAUnit);
         }
         if(!unitToFollow && !ownerUnit.attack.targetBuilding && !ownerUnit.attack.targetUnit)
         {
            ownerCluster.chooseTargetAndFight();
         }
      }
      
      private function catchAUnit(param1:Unit) : void
      {
         var targetBuilding:Building;
         var movement:Movement;
         var t:Point3;
         var margin:int;
         var range:int;
         var baseSize:int;
         var unit:Unit = param1;
         if(unitToFollow && unitToFollow.attack.targetBuilding)
         {
            targetBuilding = unitToFollow.attack.targetBuilding;
            movement = ownerUnit.movement;
            t = new Point3();
            margin = int(targetBuilding.data.buildingTypeDIO.pathMargin < 0 ? 0 : targetBuilding.data.buildingTypeDIO.pathMargin);
            range = targetBuilding.data.buildingTypeDIO.baseSize - margin * 2;
            t.x = (owner.root as WomGameRoot).pseudoRandomGenerator.nextDouble() * range + margin + targetBuilding.position.point.x;
            t.y = (owner.root as WomGameRoot).pseudoRandomGenerator.nextDouble() * range + margin + targetBuilding.position.point.y;
            baseSize = targetBuilding.data.buildingTypeDIO.baseSize;
            movement.moveToSquare(targetBuilding.position.point.x,targetBuilding.position.point.y,baseSize,t,30);
            movement.movementFinished.addFunctionOnce(function(param1:Unit):void
            {
               unitMoveFinished(param1,targetBuilding);
            });
            targetBuilding.underAttack.attackerUnits.push(ownerUnit);
            ownerUnit.attack.targetBuilding = targetBuilding;
         }
      }
      
      protected function unitMoveFinished(param1:Unit, param2:Building) : void
      {
         var _loc3_:UnderAttackBuilding = null;
         var _loc4_:int = param2.data.buildingTypeDIO.baseSize;
         param1.movement.faceToCoor(param2.position.point.x + _loc4_ / 2,param2.position.point.y + _loc4_ / 2);
         param1.animation.state = 2;
         if(!param2.underAttack)
         {
            _loc3_ = new UnderAttackBuilding(battleManager);
            param2.componentManager.add(param2.underAttack = _loc3_);
            _loc3_.init();
         }
         param2.underAttack.startUnderAttack(param1);
         param1.attack.startAttackBuilding(param2);
      }
      
      override protected function stop() : void
      {
         for each(var _loc1_ in activeBuffList)
         {
            _loc1_.data.armorBuffModifier /= armorModifier;
            _loc1_.data.speedBuffModifier /= speedModifier;
            _loc1_.data.damageBuffModifier /= damageModifier;
            _loc1_.data.beastBuff = 0;
            _loc1_.data.calculateStats();
         }
         super.stop();
      }
   }
}

