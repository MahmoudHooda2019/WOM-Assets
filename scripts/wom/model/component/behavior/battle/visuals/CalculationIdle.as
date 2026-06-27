package wom.model.component.behavior.battle.visuals
{
   import peak.cuckoo.core.Behavior;
   import wom.model.component.entity.gamesprite.Unit;
   
   public class CalculationIdle extends Behavior
   {
      
      public static const TYPE_ID:String = "CalculationIdle";
      
      private var wait:int;
      
      public function CalculationIdle()
      {
         super();
         priority = 0;
      }
      
      override public function get typeId() : String
      {
         return "CalculationIdle";
      }
      
      override public function init() : void
      {
         wait = Math.random() * 30 + 10;
         (owner as Unit).animation.direction = wait % 8;
         startEnabled = false;
         super.init();
      }
      
      override public function update() : void
      {
         if(--wait < 0)
         {
            wait = Math.random() * 30 + 10;
            (owner as Unit).animation.direction = wait % 8;
         }
      }
   }
}

