package wom.model.dto
{
   public class PartInfoDTO
   {
      
      private var _id:int;
      
      private var _name:String;
      
      private var _amount:int;
      
      public function PartInfoDTO(param1:int, param2:String, param3:int)
      {
         super();
         _id = param1;
         _name = param2;
         _amount = param3;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get amount() : int
      {
         return _amount;
      }
   }
}

