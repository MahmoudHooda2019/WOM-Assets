package wom.model.component.structure
{
   import wom.model.component.behavior.battle.tower.TowerDefense;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.component.entity.gamesprite.Unit;
   
   public class BattleField
   {
      
      public var towers:Vector.<TowerDefense> = new Vector.<TowerDefense>();
      
      public var units:Vector.<Unit> = new Vector.<Unit>();
      
      public var buildings:Vector.<Building> = new Vector.<Building>();
      
      public var defenceUnits:Vector.<Unit> = new Vector.<Unit>();
      
      public function BattleField()
      {
         super();
      }
   }
}

