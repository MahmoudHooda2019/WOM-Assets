package wom.model.component.behavior.battle.tower
{
   import wom.model.component.behavior.battle.BattleManager;
   import wom.model.component.behavior.catapult.CatapultAnimationFrame;
   import wom.model.component.entity.gamesprite.Unit;
   
   public class CombineDefenseBuilding extends CatapultAnimationFrame
   {
      
      public var units:Vector.<Unit>;
      
      public function CombineDefenseBuilding(param1:BattleManager, param2:Number)
      {
         super(param1,param2);
      }
      
      public function returnToHome(param1:Unit) : void
      {
      }
   }
}

