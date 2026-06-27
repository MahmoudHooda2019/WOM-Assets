package wom.model.component.entity.attackcluster
{
   import flash.media.Sound;
   import peak.cuckoo.core.Entity;
   import peak.cuckoo.game.Root;
   import wom.model.component.WomGameRoot;
   import wom.model.component.attribute.SfxManager;
   import wom.model.component.attribute.data.UnitData;
   import wom.model.component.behavior.battle.BattleManager;
   import wom.model.component.behavior.battle.underatack.UnderAttackBuilding;
   import wom.model.component.behavior.battle.visuals.CalculationIdle;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.component.entity.gamesprite.Unit;
   import wom.model.game.unit.UnitTypeInfo;
   
   public class AttackCluster extends Entity
   {
      
      protected var battleManager:BattleManager;
      
      public var units:Vector.<Unit>;
      
      public var leader:Unit;
      
      public var typeInfo:UnitTypeInfo;
      
      protected var unitData:UnitData;
      
      public var x:Number;
      
      public var y:Number;
      
      public var availableUnit:uint;
      
      protected var targetBuilding:Building;
      
      public var retreated:Boolean;
      
      protected var sfx:SfxManager;
      
      protected var moveSound:Sound;
      
      private var soundVariarity:uint;
      
      private var sounds:Vector.<Sound>;
      
      protected var womRoot:WomGameRoot;
      
      public function AttackCluster(param1:Root, param2:BattleManager, param3:Number, param4:Number)
      {
         super();
         units = new Vector.<Unit>();
         root = param1;
         womRoot = root as WomGameRoot;
         this.x = param3;
         this.y = param4;
         this.battleManager = param2;
         retreated = false;
         sfx = (param2.owner.root as WomGameRoot).sfxManager;
      }
      
      public function chooseTargetAndFight() : Boolean
      {
         var _loc1_:int = 0;
         if(units.length == 0 || retreated)
         {
            return true;
         }
         if(soundVariarity > 1)
         {
            moveSound = sounds[Math.random() * soundVariarity >> 0];
         }
         sfx.unitMove(moveSound,leader);
         availableUnit = 0;
         _loc1_ = 0;
         while(_loc1_ < units.length)
         {
            if(units[_loc1_].attack.targetBuilding)
            {
               units[_loc1_].attack.stopAttackBuilding();
            }
            if(!units[_loc1_].attack.targetUnit)
            {
               units[_loc1_].movement.clearWaypoint(true);
               (units[_loc1_].componentManager["CalculationIdle"] as CalculationIdle).enable();
               x = units[_loc1_].position.point.x;
               y = units[_loc1_].position.point.y;
               availableUnit = availableUnit + 1;
            }
            _loc1_++;
         }
         targetBuilding = findNearestBuilding(true);
         if(!targetBuilding)
         {
            targetBuilding = findNearestBuilding(false);
         }
         if(!targetBuilding)
         {
            battleManager.notifier.noTargetToAttack();
            return true;
         }
         return false;
      }
      
      private function findNearestBuilding(param1:Boolean) : Building
      {
         var _loc10_:Building = null;
         var _loc4_:Number = NaN;
         var _loc5_:* = undefined;
         var _loc9_:Boolean = false;
         var _loc2_:int = 0;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc8_:Vector.<Building> = battleManager.buildings;
         for each(var _loc3_ in _loc8_)
         {
            if(_loc3_.data.buildingInfo.healthPoint > 0)
            {
               if(!(_loc3_.underAttack && _loc3_.data.battleDestroyedStatus || _loc3_.data.buildingTypeDIO.indestructable))
               {
                  _loc5_ = unitData.favouriteTargets;
                  if(!(_loc3_.data.buildingInfo.buildingTypeId == 41 && (_loc5_.length > 0 && _loc5_[0] != 26 || _loc5_.length == 0)))
                  {
                     if(param1)
                     {
                        _loc9_ = true;
                        for each(var _loc12_ in _loc5_)
                        {
                           if(_loc3_.data.buildingTypeDIO.kind.id == _loc12_)
                           {
                              _loc9_ = false;
                           }
                        }
                        if(_loc9_)
                        {
                           continue;
                        }
                     }
                     _loc2_ = _loc3_.data.buildingTypeDIO.baseSize;
                     _loc6_ = _loc3_.position.point.x + _loc2_ / 2 - x;
                     _loc7_ = _loc3_.position.point.y + _loc2_ / 2 - y;
                     if(_loc10_ == null)
                     {
                        _loc10_ = _loc3_;
                        _loc4_ = _loc6_ * _loc6_ + _loc7_ * _loc7_;
                     }
                     else
                     {
                        _loc11_ = _loc6_ * _loc6_ + _loc7_ * _loc7_;
                        if(_loc11_ < _loc4_)
                        {
                           _loc10_ = _loc3_;
                           _loc4_ = _loc11_;
                        }
                     }
                  }
               }
            }
         }
         return _loc10_;
      }
      
      protected function unitMoveFinished(param1:Unit) : void
      {
         var _loc2_:UnderAttackBuilding = null;
         var _loc3_:int = targetBuilding.data.buildingTypeDIO.baseSize;
         param1.movement.faceToCoor(targetBuilding.position.point.x + _loc3_ / 2,targetBuilding.position.point.y + _loc3_ / 2);
         param1.animation.state = 2;
         if(!targetBuilding.underAttack)
         {
            _loc2_ = new UnderAttackBuilding(battleManager);
            targetBuilding.componentManager.add(targetBuilding.underAttack = _loc2_);
            _loc2_.init();
         }
         targetBuilding.underAttack.startUnderAttack(param1);
         param1.attack.startAttackBuilding(targetBuilding);
      }
      
      public function removeUnit(param1:Unit) : void
      {
         units.splice(units.indexOf(param1),1);
         if(units.length == 0)
         {
            battleManager.battleFieldControl.clusters.splice(battleManager.battleFieldControl.clusters.indexOf(this),1);
         }
         else if(param1 == leader)
         {
            leader = units[0];
         }
      }
      
      public function addUnit(param1:Unit) : void
      {
         adjustmentProgramme();
         units.push(param1);
         if(param1.data)
         {
            param1.data.cluster = this;
         }
         if(!leader)
         {
            leader = param1;
            unitData = param1.data;
            typeInfo = param1.data.typeInfo;
            sounds = sfx.getMoveSound(unitData);
            soundVariarity = sounds.length;
            moveSound = sounds[0];
         }
         param1.data.cluster = this;
      }
      
      private function adjustmentProgramme() : void
      {
      }
      
      override public function destroy() : void
      {
         destroyAll();
         for each(var _loc1_ in units)
         {
            _loc1_.underAttack.unitDestroy();
         }
      }
      
      private function sortBuildings(param1:Building, param2:Building) : int
      {
         return param1.data.buildingInfo.instanceId < param2.data.buildingInfo.instanceId ? -1 : 1;
      }
   }
}

