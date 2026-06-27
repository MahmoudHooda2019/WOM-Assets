package wom.model.component.behavior.battle.attack
{
   import flash.media.Sound;
   import peak.cuckoo.core.Behavior;
   import peak.cuckoo.game.behavior.FpsSync;
   import peak.cuckoo.game.dto.Point3;
   import peak.thread.WorkerThread;
   import wom.model.component.WomGameRoot;
   import wom.model.component.attribute.SfxManager;
   import wom.model.component.behavior.battle.BattleManager;
   import wom.model.component.behavior.battle.hit.BaseHit;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.component.entity.gamesprite.Unit;
   import wom.model.component.structure.BattleField;
   import wom.model.game.unit.UnitStatusType;
   
   public class UnitAttackManager extends Behavior
   {
      
      public static const TYPE_ID:String = "UnitAttackManager";
      
      public var targetBuilding:Building;
      
      public var targetUnit:Unit;
      
      protected var ownerUnit:Unit;
      
      protected var wait:WorkerThread;
      
      protected var sync:FpsSync;
      
      public var field:BattleField;
      
      public var othersHitting:Vector.<Unit>;
      
      private var battleManager:BattleManager;
      
      protected var sfx:SfxManager;
      
      protected var attackSound:Sound;
      
      protected var womRoot:WomGameRoot;
      
      public var hit:BaseHit;
      
      public function UnitAttackManager()
      {
         super();
         wait = new WorkerThread();
      }
      
      override public function get typeId() : String
      {
         return "UnitAttackManager";
      }
      
      override public function init() : void
      {
         var womGameRoot:WomGameRoot;
         super.init();
         womRoot = owner.root as WomGameRoot;
         ownerUnit = owner as Unit;
         sync = owner.root.sync;
         womGameRoot = owner.root as WomGameRoot;
         hit = ownerUnit.hit;
         hit.hitFinished.addFunction(function(param1:*):void
         {
            ownerUnit.data.cluster.chooseTargetAndFight();
         });
         battleManager = womGameRoot.battleManager;
         othersHitting = new Vector.<Unit>();
         startEnabled = false;
         sfx = womGameRoot.sfxManager;
         attackSound = sfx.getAttackSound(ownerUnit.data);
      }
      
      public function startAttackBuilding(param1:Building) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:int = 0;
         if(targetUnit)
         {
            throw new Error();
         }
         if(targetBuilding != param1)
         {
            stopAttackBuilding();
            _loc3_ = param1.underAttack.attackerUnits;
            _loc2_ = _loc3_.indexOf(ownerUnit);
            if(_loc2_ == -1)
            {
               _loc3_.push(ownerUnit);
            }
            targetBuilding = param1;
         }
         hit.calculateLootAmount(targetBuilding);
         enable();
      }
      
      public function stopAttackBuilding(param1:Boolean = false) : void
      {
         var _loc2_:int = 0;
         if(!param1 && targetBuilding)
         {
            _loc2_ = targetBuilding.underAttack.attackerUnits.indexOf(ownerUnit);
            if(_loc2_ != -1)
            {
               targetBuilding.underAttack.attackerUnits.splice(_loc2_,1);
            }
         }
         targetBuilding = null;
         hit.lootAmount = 0;
         if(targetUnit)
         {
            return;
         }
         ownerUnit.animation.state = 0;
         disable();
      }
      
      override public function update() : void
      {
         wait.value -= sync.precise;
         var _loc1_:Number = 1.001;
         var _loc2_:WorkerThread = wait;
         if(_loc2_._value + _loc1_ > womRoot.zcmp._value + _loc1_)
         {
            return;
         }
         var _temp_5:* = wait;
         var _loc5_:WorkerThread = womRoot.uhwd;
         var _loc4_:WorkerThread = womRoot.bhwd;
         var _loc7_:Number = ownerUnit.data.isBeast && ownerUnit.data.typeDIO.id == 25 ? _loc4_._value : _loc5_._value;
         var _loc6_:WorkerThread = _temp_5;
         _loc6_._value = _loc7_;
         if(targetBuilding)
         {
            hit.hitBuilding(targetBuilding);
         }
         else if(targetUnit)
         {
            hit.hitUnit(targetUnit);
            if(!targetUnit || !targetUnit.data || targetUnit.data.info.healthPoints <= 0)
            {
               ownerUnit.data.cluster.chooseTargetAndFight();
            }
         }
         sfx.unitAttack(attackSound,ownerUnit);
      }
      
      public function defendYourself(param1:Unit = null) : void
      {
         var meleeFound:Boolean;
         var i:int;
         var unit:Unit;
         var dx:Number;
         var dy:Number;
         var dist:Number;
         var target:Unit = param1;
         ownerUnit.movement.clearWaypoint(true);
         if(targetBuilding)
         {
            stopAttackBuilding();
         }
         if(target == null)
         {
            if(othersHitting.length <= 0)
            {
               ownerUnit.data.cluster.chooseTargetAndFight();
               return;
            }
            target = othersHitting[0];
         }
         else if(othersHitting.indexOf(target) == -1)
         {
            othersHitting.push(target);
         }
         if(!targetUnit)
         {
            if(ownerUnit.movement.ranged == 0 && target.movement.ranged != 0)
            {
               meleeFound = false;
               i = 0;
               while(i < othersHitting.length)
               {
                  unit = othersHitting[i];
                  if(unit.movement.ranged == 0)
                  {
                     target = unit;
                     meleeFound = true;
                     break;
                  }
                  i = i + 1;
               }
               if(!meleeFound)
               {
                  dx = target.position.point.x - ownerUnit.position.point.x;
                  dy = target.position.point.y - ownerUnit.position.point.y;
                  dist = dx * dx + dy * dy;
                  if(dist > 25)
                  {
                     ownerUnit.movement.addWaypoint(target.position.point);
                     ownerUnit.movement.rangeSquare = 9;
                     ownerUnit.movement.generalTarget = target.position.point;
                     ownerUnit.movement.movementFinished.addFunction(function(param1:Unit):void
                     {
                        defendYourself();
                     });
                     return;
                  }
               }
            }
            targetUnit = target;
            ownerUnit.movement.faceTo(targetUnit.position.point);
            ownerUnit.animation.state = 2;
            var _temp_13:* = wait;
            var _loc5_:int = 60;
            var _loc3_:WorkerThread = _temp_13;
            _loc3_._value = _loc5_;
            if(!ownerUnit.isBeast && targetUnit.isBeast)
            {
               var _temp_16:* = wait;
               var _loc6_:int = 0;
               var _loc4_:WorkerThread = _temp_16;
               _loc4_._value = _loc6_;
               update();
            }
            enable();
         }
      }
      
      public function enemyUnitDied(param1:Unit) : void
      {
         var _loc2_:int = othersHitting.indexOf(param1);
         if(_loc2_ != -1)
         {
            othersHitting.splice(_loc2_,1);
         }
         if(targetUnit == param1)
         {
            disable();
            ownerUnit.animation.state = 0;
            targetUnit = null;
            if(othersHitting.length != 0)
            {
               defendYourself();
            }
            else
            {
               ownerUnit.data.cluster.chooseTargetAndFight();
            }
         }
      }
      
      public function retreatAttack() : void
      {
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc1_:Unit = null;
         var _loc2_:Point3 = new Point3();
         if(ownerUnit.position.point.x < 0)
         {
            _loc2_.x = -10000;
         }
         else
         {
            _loc2_.x = 10000;
         }
         if(ownerUnit.position.point.y < 0)
         {
            _loc2_.y = -10000;
         }
         else
         {
            _loc2_.y = 10000;
         }
         disable();
         ownerUnit.movement.moveToPoint(_loc2_);
         for each(_loc3_ in ownerUnit.data.cluster.units)
         {
            _loc3_.data.info.status = UnitStatusType.RETREATED;
            battleManager.notifier.unitRetreated(_loc3_);
         }
         if(targetUnit)
         {
            targetUnit.defence.stopAttack();
         }
         _loc4_ = 0;
         while(_loc4_ < othersHitting.length)
         {
            _loc1_ = othersHitting[_loc4_];
            _loc1_.defence.stopAttack();
            _loc4_++;
         }
         othersHitting.length = 0;
         ownerUnit.data.cluster.retreated = true;
         (owner.root as WomGameRoot).battleManager.battleFieldControl.checkAllUnitDied();
      }
      
      override protected function start() : void
      {
         super.start();
      }
      
      override protected function stop() : void
      {
         super.stop();
      }
   }
}

