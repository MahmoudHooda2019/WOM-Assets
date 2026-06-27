package wom.model.component.enum
{
   import wom.model.component.entity.gamesprite.PlannerBuilding;
   
   public class ConstructableTypeHolder
   {
      
      private var _buildings:Vector.<PlannerBuilding>;
      
      public function ConstructableTypeHolder()
      {
         super();
         _buildings = new Vector.<PlannerBuilding>();
      }
      
      public function addBuilding(param1:PlannerBuilding) : void
      {
         _buildings.push(param1);
      }
      
      public function get buildings() : Vector.<PlannerBuilding>
      {
         return _buildings;
      }
   }
}

