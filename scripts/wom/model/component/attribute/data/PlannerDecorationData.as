package wom.model.component.attribute.data
{
   import wom.model.component.entity.gamesprite.Decoration;
   
   public class PlannerDecorationData extends PlannerConstructableData
   {
      
      public var decorationData:DecorationData;
      
      public var decoration:Decoration;
      
      public function PlannerDecorationData(param1:Decoration)
      {
         this.decoration = param1;
         decorationData = param1.data;
         super(decorationData.dio.baseSize,1,0);
      }
   }
}

