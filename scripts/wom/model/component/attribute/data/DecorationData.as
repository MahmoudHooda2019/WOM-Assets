package wom.model.component.attribute.data
{
   import peak.cuckoo.core.Attribute;
   import wom.model.domain.domaininfoobject.DecorationTypeDIO;
   import wom.model.game.building.DecorationInfo;
   
   public class DecorationData extends Attribute
   {
      
      public static const TYPE_ID:String = "DecorationData";
      
      public var info:DecorationInfo;
      
      public var dio:DecorationTypeDIO;
      
      public function DecorationData(param1:DecorationInfo, param2:DecorationTypeDIO)
      {
         super();
         this.info = param1;
         this.dio = param2;
      }
      
      override public function get typeId() : String
      {
         return "DecorationData";
      }
   }
}

