package wom.model.game.attack
{
   public class CatapultTimeDTO
   {
      
      private var _id:int;
      
      private var _catapultTime:Number;
      
      public function CatapultTimeDTO(param1:int, param2:Number)
      {
         super();
         _id = param1;
         _catapultTime = param2;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get catapultTime() : Number
      {
         return _catapultTime;
      }
      
      public function set catapultTime(param1:Number) : void
      {
         _catapultTime = param1;
      }
   }
}

