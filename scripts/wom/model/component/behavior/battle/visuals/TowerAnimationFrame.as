package wom.model.component.behavior.battle.visuals
{
   import peak.cuckoo.core.Behavior;
   import wom.model.component.behavior.battle.BattleManager;
   
   public class TowerAnimationFrame extends Behavior
   {
      
      protected var b:BattleManager;
      
      protected var d:Number;
      
      public var r:Number = 10.24;
      
      public function TowerAnimationFrame(param1:BattleManager, param2:Number)
      {
         super();
         this.b = param1;
         this.d = param2;
      }
   }
}

