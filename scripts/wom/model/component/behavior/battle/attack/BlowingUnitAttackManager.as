package wom.model.component.behavior.battle.attack
{
   import wom.model.component.behavior.battle.BattleManager;
   
   public class BlowingUnitAttackManager extends UnitAttackManager
   {
      
      private var battleManager:BattleManager;
      
      private var range:Number;
      
      public function BlowingUnitAttackManager(param1:BattleManager)
      {
         super();
         this.battleManager = param1;
         range = 4;
      }
      
      override public function update() : void
      {
         if(!targetUnit && (!targetBuilding || targetBuilding.data.buildingInfo.healthPoint <= 0))
         {
            disable();
            ownerUnit.data.cluster.chooseTargetAndFight();
            return;
         }
         hit.hit(ownerUnit.position.point.x,ownerUnit.position.point.y);
         battleManager.effects.addExplosion(ownerUnit.position.point);
         ownerUnit.data.unitLog.totalDamageTaken += ownerUnit.data.info.healthPoints;
         ownerUnit.data.info.healthPoints = 0;
         battleManager.battleFieldControl.attackingUnitDied(ownerUnit);
      }
   }
}

