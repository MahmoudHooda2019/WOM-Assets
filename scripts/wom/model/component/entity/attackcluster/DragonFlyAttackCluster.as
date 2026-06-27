package wom.model.component.entity.attackcluster
{
   import peak.cuckoo.game.Root;
   import wom.model.component.behavior.battle.BattleManager;
   import wom.model.component.behavior.battle.attack.AreaBuffDispenserAndFollower;
   import wom.model.component.entity.gamesprite.Unit;
   
   public class DragonFlyAttackCluster extends FlyingAttackCluster
   {
      
      private var dragon:Unit;
      
      private var dispanser:AreaBuffDispenserAndFollower;
      
      public function DragonFlyAttackCluster(param1:Root, param2:BattleManager, param3:Number, param4:Number)
      {
         super(param1,param2,param3,param4);
      }
      
      override public function addUnit(param1:Unit) : void
      {
         dragon = param1;
         dispanser = param1.componentManager["AreaBuffDispenserAndFollower"] as AreaBuffDispenserAndFollower;
         super.addUnit(param1);
      }
      
      override public function chooseTargetAndFight() : Boolean
      {
         if(dispanser.unitToFollow)
         {
            return false;
         }
         return super.chooseTargetAndFight();
      }
   }
}

