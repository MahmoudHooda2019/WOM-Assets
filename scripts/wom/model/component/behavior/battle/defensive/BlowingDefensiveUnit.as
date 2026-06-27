package wom.model.component.behavior.battle.defensive
{
   import wom.model.component.behavior.battle.BattleManager;
   import wom.model.component.behavior.battle.tower.CombineDefenseBuilding;
   
   public class BlowingDefensiveUnit extends DefensiveUnit
   {
      
      private var battleManager:BattleManager;
      
      private var range:Number;
      
      public function BlowingDefensiveUnit(param1:CombineDefenseBuilding, param2:BattleManager)
      {
         super(param1);
         this.battleManager = param2;
         range = 4;
      }
      
      override public function update() : void
      {
         wait -= sync.precise;
         if(wait > 0)
         {
            return;
         }
         wait = 60;
         switch(int(state) - 1)
         {
            case 0:
               ownerUnit.movement.faceTo(target.position.point);
            case 1:
               if(target.data.info.healthPoints <= 0)
               {
                  stopAttack();
               }
               break;
            case 2:
               hit.hit(ownerUnit.position.point.x,ownerUnit.position.point.y);
               battleManager.effects.addExplosion(ownerUnit.position.point);
               ownerUnit.data.unitLog.totalDamageTaken += ownerUnit.data.info.healthPoints;
               ownerUnit.data.info.healthPoints = 0;
               battleManager.battleFieldControl.defendingUnitDied(ownerUnit);
         }
      }
      
      override public function enable() : void
      {
         super.enable();
         if(state == 3)
         {
            wait = -1;
         }
      }
   }
}

