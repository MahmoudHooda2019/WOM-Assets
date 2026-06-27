package wom.model.domain.domaininfoobject
{
   public class UnitSpecificInfoType
   {
      
      public static const RANGES_PER_MASTERY:UnitSpecificInfoType = new UnitSpecificInfoType(1,"Ranges per mastery");
      
      public static const CLOAK_PER_MASTERY:UnitSpecificInfoType = new UnitSpecificInfoType(2,"Cloak per mastery");
      
      public static const SPLASH_PER_MASTERY:UnitSpecificInfoType = new UnitSpecificInfoType(3,"Splash per mastery");
      
      private var _id:int;
      
      private var _name:String;
      
      public function UnitSpecificInfoType(param1:int, param2:String)
      {
         super();
         _id = param1;
         _name = param2;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get name() : String
      {
         return _name;
      }
   }
}

