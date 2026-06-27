package wom.model.game.helper
{
   public class RowColumnPair
   {
      
      private var _numberOfRows:int;
      
      private var _numberOfColumns:int;
      
      public function RowColumnPair(param1:int, param2:int)
      {
         super();
         _numberOfRows = param1;
         _numberOfColumns = param2;
      }
      
      public function get numberOfRows() : int
      {
         return _numberOfRows;
      }
      
      public function get numberOfColumns() : int
      {
         return _numberOfColumns;
      }
      
      public function copyFrom(param1:RowColumnPair) : void
      {
         this._numberOfColumns = param1._numberOfColumns;
         this._numberOfRows = param1._numberOfRows;
      }
   }
}

