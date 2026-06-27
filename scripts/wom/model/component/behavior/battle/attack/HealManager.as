package wom.model.component.behavior.battle.attack
{
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.dto.Point3;
   import wom.model.component.WomGameRoot;
   import wom.model.component.attribute.data.UnitData;
   import wom.model.component.behavior.ParticleManager;
   import wom.model.component.behavior.battle.BattleFieldControl;
   import wom.model.component.behavior.battle.BattleManager;
   import wom.model.component.behavior.battle.visuals.CalculationIdle;
   import wom.model.component.behavior.movement.Movement;
   import wom.model.component.entity.attackcluster.AttackCluster;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.component.entity.gamesprite.Particle;
   import wom.model.component.entity.gamesprite.Unit;
   import wom.model.component.structure.BattleField;
   
   public class HealManager extends UnitAttackManager
   {
      
      private const UPDATE_PERIOD_HEAL:int = 12;
      
      private const UPDATE_PERIOD_WAITING:int = 300;
      
      private var unitData:UnitData;
      
      private var position:Point3;
      
      private var battleField:Array;
      
      private var healUnits:Vector.<Unit>;
      
      private var movement:Movement;
      
      private var battleControl:BattleFieldControl;
      
      private var waiting:int;
      
      private var _calculationIdle:CalculationIdle;
      
      private var particleManager:ParticleManager;
      
      private var particleAssetId:String;
      
      public function HealManager(param1:BattleManager)
      {
         super();
         priority = 0;
         this.battleControl = param1.battleFieldControl;
         this.battleField = param1.battleFieldControl.battleFields;
         healUnits = new Vector.<Unit>();
      }
      
      override public function init() : void
      {
         sync = owner.root.sync;
         ownerUnit = owner as Unit;
         var _loc1_:WomGameRoot = owner.root as WomGameRoot;
         particleAssetId = "HealBall";
         unitData = ownerUnit.data;
         particleManager = _loc1_.particleManager;
         othersHitting = new Vector.<Unit>();
         position = (owner as GameSprite).position.point;
         movement = (owner as Unit).movement;
         _calculationIdle = owner.componentManager["CalculationIdle"] as CalculationIdle;
         sfx = _loc1_.sfxManager;
         attackSound = sfx.getAttackSound(ownerUnit.data);
      }
      
      override public function update() : void
      {
         var _loc12_:Unit = null;
         var _loc10_:* = undefined;
         var _loc14_:Unit = null;
         var _loc11_:* = 0;
         var _loc8_:* = 0;
         var _loc3_:int = 0;
         var _loc9_:int = 0;
         var _loc23_:GameSprite = null;
         var _loc15_:Number = NaN;
         var _loc17_:Point3 = null;
         var _loc6_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc13_:Particle = null;
         var _loc4_:int = 0;
         wait.value -= sync.precise;
         var _loc24_:WorkerThread = wait;
         if(_loc24_._value > 0)
         {
            return;
         }
         healUnits.length = 0;
         var _loc1_:int = (position.x - unitData.range) / 10;
         var _loc7_:int = (position.x + unitData.range) / 10;
         var _loc2_:int = (position.y - unitData.range) / 10;
         var _loc19_:int = (position.y + unitData.range) / 10;
         if(_loc1_ < 0)
         {
            _loc1_--;
         }
         if(_loc7_ > 0)
         {
            _loc7_++;
         }
         if(_loc2_ < 0)
         {
            _loc2_--;
         }
         if(_loc19_ > 0)
         {
            _loc19_++;
         }
         _loc11_ = _loc1_;
         while(_loc11_ <= _loc7_)
         {
            _loc8_ = _loc2_;
            while(_loc8_ <= _loc19_)
            {
               _loc3_ = (_loc11_ << 10) + (_loc8_ << 0);
               if(battleField[_loc3_])
               {
                  _loc10_ = (battleField[_loc3_] as BattleField).units;
                  _loc9_ = 0;
                  while(_loc9_ < _loc10_.length)
                  {
                     _loc14_ = _loc10_[_loc9_];
                     var _loc25_:WorkerThread;
                     if(_loc14_.isBeast && _loc14_.data.info.healthPoints < (_loc25_ = _loc14_.data.maxHealthPoint)._value)
                     {
                        _loc12_ = _loc14_;
                     }
                     else
                     {
                        var _loc26_:WorkerThread;
                        if(_loc14_.data.info.healthPoints < (_loc26_ = _loc14_.data.maxHealthPoint)._value && healUnits.length < 5 && _loc14_.data.healAvailable)
                        {
                           healUnits.push(_loc14_);
                        }
                     }
                     _loc9_++;
                  }
               }
               _loc8_++;
            }
            _loc11_++;
         }
         if(healUnits.length == 0 && _loc12_ == null)
         {
            _loc15_ = 0;
            for each(var _loc21_ in battleControl.clusters)
            {
               if(!(!_loc21_.leader.data.healAvailable || _loc21_.retreated))
               {
                  _loc17_ = _loc21_.leader.position.point;
                  _loc6_ = (_loc17_.x - position.x) * (_loc17_.x - position.x) + (_loc17_.y - position.y) * (_loc17_.y - position.y);
                  _loc22_ = Math.sqrt(_loc6_) / 100;
                  for each(var _loc18_ in _loc21_.units)
                  {
                     var _loc27_:WorkerThread;
                     _loc6_ = _loc22_ + _loc18_.data.info.healthPoints / (_loc27_ = _loc18_.data.maxHealthPoint)._value;
                     if(!_loc23_ || _loc6_ < _loc15_)
                     {
                        _loc15_ = _loc6_;
                        _loc23_ = _loc18_;
                     }
                  }
               }
            }
            if(_loc23_)
            {
               movement.moveToPoint(new Point3(_loc23_.position.point.x,_loc23_.position.point.y,15),unitData.range - 2);
               movement.movementFinished.addFunction(movementFinished);
               _calculationIdle.disable();
            }
            else
            {
               waiting = waiting + 1;
               _calculationIdle.enable();
            }
            var _temp_16:* = wait;
            var _loc35_:int = 300;
            var _loc32_:WorkerThread = _temp_16;
            _loc32_._value = _loc35_;
            return;
         }
         var _temp_18:* = wait;
         var _loc36_:int = 12;
         var _loc33_:WorkerThread = _temp_18;
         _loc33_._value = _loc36_;
         waiting = 0;
         _calculationIdle.disable();
         var _loc5_:Unit = healUnits.length > 0 ? healUnits[0] : _loc12_;
         if(!movement.enabled || movement._waypoints[0] && movement._waypoints[0] != _loc5_.position.point)
         {
            movement.moveToPoint(new Point3(_loc5_.position.point.x,_loc5_.position.point.y,15),unitData.range);
         }
         var _loc34_:WorkerThread = unitData.damage;
         var _loc20_:Number = _loc34_._value;
         if(_loc12_)
         {
            _loc16_ = _loc20_ / 10;
            _loc12_.underAttack.heal(_loc16_);
            _loc14_.data.unitLog.totalDamageGiven += _loc16_;
            _loc14_.data.unitLog.hitCount++;
            _loc13_ = new Particle(new Point3(ownerUnit.position.projected.x + 20,ownerUnit.position.projected.y + 15),_loc12_.position.projected,new Point3(_loc12_.viewManager.middlePoint.x,_loc12_.viewManager.middlePoint.y),30,particleAssetId,false,false);
            particleManager.throwParticle(_loc13_);
            _loc20_ -= _loc16_;
         }
         _loc16_ = _loc20_ / healUnits.length;
         _loc4_ = 0;
         while(_loc4_ < healUnits.length)
         {
            healUnits[_loc4_].underAttack.heal(_loc16_);
            _loc14_.data.unitLog.totalDamageGiven += _loc16_;
            _loc14_.data.unitLog.hitCount++;
            _loc13_ = new Particle(new Point3(ownerUnit.position.projected.x + 20,ownerUnit.position.projected.y + 15),healUnits[_loc4_].position.projected,new Point3(healUnits[_loc4_].viewManager.middlePoint.x,healUnits[_loc4_].viewManager.middlePoint.y),30,particleAssetId,false,false);
            particleManager.throwParticle(_loc13_);
            _loc4_++;
         }
         sfx.unitAttack(attackSound,ownerUnit);
      }
      
      private function movementFinished(param1:Unit) : void
      {
         var _temp_1:* = wait;
         var _loc3_:int = 12;
         var _loc2_:WorkerThread = _temp_1;
         _loc2_._value = _loc3_;
      }
      
      override public function defendYourself(param1:Unit = null) : void
      {
      }
      
      override public function startAttackBuilding(param1:Building) : void
      {
      }
      
      override public function stopAttackBuilding(param1:Boolean = false) : void
      {
      }
      
      override public function enemyUnitDied(param1:Unit) : void
      {
      }
   }
}

