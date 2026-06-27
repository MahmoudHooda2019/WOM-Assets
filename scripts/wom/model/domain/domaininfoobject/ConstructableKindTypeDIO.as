package wom.model.domain.domaininfoobject
{
   public class ConstructableKindTypeDIO
   {
      
      public static const MAIN_BUILDING:int = 10;
      
      public static const RESOURCE_PRODUCER:int = 11;
      
      public static const RESOURCE_STORAGE:int = 12;
      
      public static const WATCH_POST:int = 21;
      
      public static const WALL:int = 26;
      
      public static const DEFENSIVE_BUILDING:int = 28;
      
      public static const DECORATION:int = 31;
      
      public var id:int;
      
      public var color:int;
      
      public var outline:int;
      
      public function ConstructableKindTypeDIO(param1:int, param2:int, param3:int)
      {
         super();
         this.id = param1;
         this.color = param2;
         this.outline = param3;
      }
   }
}

