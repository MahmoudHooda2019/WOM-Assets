package wom.model.component.behavior.battle.underatack
{
   import flash.geom.Point;
   import wom.model.component.behavior.battle.BattleManager;
   import wom.model.component.entity.gamesprite.Building;
   
   public class UnderAttackSiegeTower extends UnderAttackUnit
   {
      
      public function UnderAttackSiegeTower(param1:BattleManager)
      {
         super(param1);
      }
      
      override public function hit(param1:Number) : Boolean
      {
         param1 *= unitData.armor._value;
         unitData.info.healthPoints -= param1;
         unitData.unitLog.totalDamageTaken += param1;
         _womGameRoot.displayFloatingText(new Point(projectedPosition.x + ownerUnit.bounds.width / 2,projectedPosition.y),1,"" + (param1 << 0),null,hitTextStacker);
         viewManager.manageHealthProgressBar();
         var _loc3_:WorkerThread = _womGameRoot.zcmp;
         if(_loc3_._value >= unitData.info.healthPoints)
         {
            bloodPoint.x = projectedPoint.x + ownerUnit.bounds.width / 2;
            bloodPoint.y = projectedPoint.y + ownerUnit.bounds.height / 2;
            blood.spillSoil(bloodPoint);
            battleManager.battleFieldControl.attackingUnitDied(ownerUnit);
            return true;
         }
         return false;
      }
      
      override public function unitDestroy() : void
      {
         super.unitDestroy();
      }
      
      override public function heal(param1:Number) : void
      {
      }
      
      override public function stopTowerUnderAttack(param1:Building) : void
      {
         super.stopTowerUnderAttack(param1);
      }
      
      override public function startTowerUnderAttack(param1:Building) : void
      {
         super.startTowerUnderAttack(param1);
      }
   }
}

