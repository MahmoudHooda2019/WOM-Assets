package wom.model.component.entity.gamesprite
{
   import peak.cuckoo.game.GameSprite;
   import wom.model.component.attribute.data.BuildingData;
   import wom.model.component.attribute.viewManager.BuildingViewManager;
   import wom.model.component.behavior.battle.underatack.UnderAttackBuilding;
   
   public class Building extends GameSprite
   {
      
      public var viewManager:BuildingViewManager;
      
      public var data:BuildingData;
      
      public var underAttack:UnderAttackBuilding;
      
      public function Building()
      {
         super();
      }
      
      override public function destroy() : void
      {
         super.destroy();
         viewManager = null;
         data = null;
         underAttack = null;
      }
   }
}

