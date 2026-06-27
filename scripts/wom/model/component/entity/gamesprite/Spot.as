package wom.model.component.entity.gamesprite
{
   import wom.model.component.attribute.data.SpotList;
   
   public class Spot extends Doodad
   {
      
      public var next:Spot;
      
      public var prev:Spot;
      
      public var list:SpotList;
      
      public function Spot()
      {
         super();
         zIndex = 1000;
      }
   }
}

