package wom.model.component.attribute.viewManager
{
   import wom.model.component.attribute.data.DecorationData;
   import wom.model.component.entity.gamesprite.PlannerBuilding;
   
   public class PlannerDecorationViewManager extends PlannerConstructableViewManager
   {
      
      private var ownerDecorationRootData:DecorationData;
      
      public function PlannerDecorationViewManager(param1:PlannerBuilding, param2:DecorationData)
      {
         this.ownerDecorationRootData = param2;
         this.constructableTypeDIO = param2.dio;
         super(param1,false);
      }
   }
}

