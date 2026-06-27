package peak.display
{
   public class Viewport
   {
      
      private var _width:int;
      
      private var _height:int;
      
      public function Viewport(param1:int, param2:int)
      {
         super();
         this._width = param1;
         this._height = param2;
      }
      
      public function get width() : int
      {
         return _width;
      }
      
      public function get height() : int
      {
         return _height;
      }
   }
}

