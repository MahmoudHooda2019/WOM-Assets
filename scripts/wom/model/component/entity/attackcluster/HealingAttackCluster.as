package wom.model.component.entity.attackcluster
{
   import peak.cuckoo.game.Root;
   import wom.model.component.behavior.battle.BattleManager;
   import wom.model.component.behavior.battle.attack.HealManager;
   import wom.model.component.entity.gamesprite.Unit;
   
   public class HealingAttackCluster extends AttackCluster
   {
      
      public function HealingAttackCluster(param1:Root, param2:BattleManager, param3:Number, param4:Number)
      {
         super(param1,param2,param3,param4);
      }
      
      override public function addUnit(param1:Unit) : void
      {
         super.addUnit(param1);
         var _loc2_:HealManager = new HealManager(battleManager);
         param1.componentManager.add(param1.attack = _loc2_);
         param1.data.healAvailable = false;
         _loc2_.init();
      }
      
      override public function chooseTargetAndFight() : Boolean
      {
         return true;
      }
   }
}

