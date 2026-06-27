package wom.model.component.entity.attackcluster
{
   import peak.cuckoo.game.Root;
   import peak.cuckoo.game.dto.Point3;
   import peak.util.ValidationRecorder;
   import peak.util.ValidationVerifier;
   import wom.model.component.behavior.battle.BattleManager;
   import wom.model.component.behavior.battle.underatack.UnderAttackBuilding;
   import wom.model.component.behavior.battle.visuals.CalculationIdle;
   import wom.model.component.behavior.movement.Movement;
   import wom.model.component.entity.gamesprite.Unit;
   
   public class FlyingAttackCluster extends AttackCluster
   {
      
      public function FlyingAttackCluster(param1:Root, param2:BattleManager, param3:Number, param4:Number)
      {
         super(param1,param2,param3,param4);
      }
      
      override public function chooseTargetAndFight() : Boolean
      {
         var _loc9_:int = 0;
         var _loc4_:UnderAttackBuilding = null;
         var _loc1_:Unit = null;
         var _loc5_:Movement = null;
         var _loc2_:Point3 = null;
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         var _loc8_:Number = NaN;
         if(super.chooseTargetAndFight())
         {
            return true;
         }
         var _loc7_:int = targetBuilding.data.buildingTypeDIO.baseSize;
         if(!targetBuilding.underAttack)
         {
            _loc4_ = new UnderAttackBuilding(battleManager);
            targetBuilding.componentManager.add(targetBuilding.underAttack = _loc4_);
            _loc4_.init();
         }
         _loc9_ = 0;
         while(_loc9_ < units.length)
         {
            _loc1_ = units[_loc9_];
            (_loc1_.componentManager["CalculationIdle"] as CalculationIdle).disable();
            if(!units[_loc9_].attack.targetUnit)
            {
               _loc5_ = _loc1_.movement;
               _loc2_ = new Point3();
               _loc6_ = int(targetBuilding.data.buildingTypeDIO.pathMargin < 0 ? 0 : targetBuilding.data.buildingTypeDIO.pathMargin);
               _loc3_ = targetBuilding.data.buildingTypeDIO.baseSize - _loc6_ * 2;
               _loc8_ = womRoot.pseudoRandomGenerator.nextDouble();
               _loc2_.x = _loc8_ * _loc3_ + _loc6_ + targetBuilding.position.point.x;
               _loc2_.y = womRoot.pseudoRandomGenerator.nextDouble() * _loc3_ + _loc6_ + targetBuilding.position.point.y;
               _loc5_.moveToSquare(targetBuilding.position.point.x,targetBuilding.position.point.y,_loc7_,_loc2_,unitData.range);
               _loc5_.movementFinished.addFunctionOnce(unitMoveFinished);
               targetBuilding.underAttack.attackerUnits.push(units[_loc9_]);
               units[_loc9_].attack.targetBuilding = targetBuilding;
            }
            _loc9_++;
         }
         return false;
      }
   }
}

