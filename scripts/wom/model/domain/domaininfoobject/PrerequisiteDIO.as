package wom.model.domain.domaininfoobject
{
   public class PrerequisiteDIO
   {
      
      private var _id:int;
      
      private var _level:int;
      
      private var _count:int;
      
      public function PrerequisiteDIO(param1:int, param2:int, param3:int = 1)
      {
         super();
         _id = param1;
         _level = param2;
         if(param3 == 0)
         {
            param3 = 1;
         }
         _count = param3;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      public function get count() : int
      {
         return _count;
      }
   }
}

