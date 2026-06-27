package wom.model.dto
{
   public class CityPlanInfoDTO
   {
      
      private var _slot:int;
      
      private var _name:String;
      
      public function CityPlanInfoDTO(param1:int, param2:String)
      {
         super();
         _slot = param1;
         _name = param2;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function get slot() : int
      {
         return _slot;
      }
      
      public function set slot(param1:int) : void
      {
         _slot = param1;
      }
   }
}

