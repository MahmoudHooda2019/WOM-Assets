package wom.model.component.enum
{
   public class PlannerConstructableGroupPositioning
   {
      
      private var _x:int;
      
      private var _y:int;
      
      private var _side:Boolean;
      
      public function PlannerConstructableGroupPositioning(param1:int, param2:int, param3:Boolean)
      {
         super();
         _x = param1;
         _y = param2;
         _side = param3;
      }
      
      public function get x() : int
      {
         return _x;
      }
      
      public function get y() : int
      {
         return _y;
      }
      
      public function get side() : Boolean
      {
         return _side;
      }
   }
}

