package wom.model.game.hiring
{
   public class HiringSlotView
   {
      
      private var _slotIndex:int;
      
      private var _unitId:int;
      
      private var _numberOfUnits:Number;
      
      public function HiringSlotView(param1:int, param2:int, param3:Number)
      {
         super();
         _slotIndex = param1;
         _unitId = param2;
         _numberOfUnits = param3;
      }
      
      public function get slotIndex() : int
      {
         return _slotIndex;
      }
      
      public function get unitId() : int
      {
         return _unitId;
      }
      
      public function get numberOfUnits() : Number
      {
         return _numberOfUnits;
      }
      
      public function set numberOfUnits(param1:Number) : void
      {
         _numberOfUnits = param1;
      }
      
      public function set slotIndex(param1:int) : void
      {
         _slotIndex = param1;
      }
   }
}

