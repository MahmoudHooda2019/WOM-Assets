package wom.model.domain.domaininfoobject
{
   public class StaffDIO
   {
      
      private var _id:int;
      
      public function StaffDIO(param1:int)
      {
         super();
         _id = param1;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function set id(param1:int) : void
      {
         _id = param1;
      }
   }
}

