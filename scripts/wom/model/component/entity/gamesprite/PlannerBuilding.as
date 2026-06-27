package wom.model.component.entity.gamesprite
{
   import peak.cuckoo.game.GameSprite;
   import wom.model.component.attribute.data.PlannerConstructableData;
   import wom.model.component.attribute.viewManager.PlannerConstructableViewManager;
   
   public class PlannerBuilding extends GameSprite
   {
      
      public var data:PlannerConstructableData;
      
      public var viewManager:PlannerConstructableViewManager;
      
      public function PlannerBuilding()
      {
         super();
      }
      
      override public function destroy() : void
      {
         super.destroy();
         data = null;
         viewManager = null;
      }
   }
}

