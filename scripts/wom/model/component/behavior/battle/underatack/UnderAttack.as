package wom.model.component.behavior.battle.underatack
{
   import peak.cuckoo.core.Attribute;
   import wom.model.component.behavior.battle.BattleManager;
   
   public class UnderAttack extends Attribute
   {
      
      public static const TYPE_ID:String = "UnderAttack";
      
      protected var battleManager:BattleManager;
      
      public function UnderAttack(param1:BattleManager)
      {
         super();
         this.battleManager = param1;
      }
      
      override public function get typeId() : String
      {
         return "UnderAttack";
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

