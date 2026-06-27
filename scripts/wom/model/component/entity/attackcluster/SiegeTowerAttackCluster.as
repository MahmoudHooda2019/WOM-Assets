package wom.model.component.entity.attackcluster
{
   import peak.cuckoo.game.Root;
   import wom.model.component.behavior.battle.BattleManager;
   
   public class SiegeTowerAttackCluster extends AttackCluster
   {
      
      public function SiegeTowerAttackCluster(param1:Root, param2:BattleManager, param3:Number, param4:Number)
      {
         super(param1,param2,param3,param4);
      }
      
      override public function chooseTargetAndFight() : Boolean
      {
         return true;
      }
   }
}

