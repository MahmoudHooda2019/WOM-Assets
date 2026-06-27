package wom.model.game.viral
{
   public class WallPostParams
   {
      
      private var _id:int;
      
      private var _p1:Object;
      
      private var _p2:Object;
      
      private var _p3:Object;
      
      public function WallPostParams(param1:int, param2:Object = null, param3:Object = null, param4:Object = null)
      {
         super();
         _id = param1;
         _p1 = param2;
         _p2 = param3;
         _p3 = param4;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get p1() : Object
      {
         return _p1;
      }
      
      public function get p2() : Object
      {
         return _p2;
      }
      
      public function get p3() : Object
      {
         return _p3;
      }
   }
}

