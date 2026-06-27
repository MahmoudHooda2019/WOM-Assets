package wom.model.game.hiring
{
   public class HiringQueueInfo
   {
      
      private var _maxNumberOfHiringSlots:int;
      
      private var _hiringSlots:Vector.<HiringSlotView>;
      
      public function HiringQueueInfo(param1:int, param2:Vector.<HiringSlotView>)
      {
         super();
         this._maxNumberOfHiringSlots = param1;
         this._hiringSlots = param2;
      }
      
      public function get maxNumberOfHiringSlots() : int
      {
         return _maxNumberOfHiringSlots;
      }
      
      public function get hiringSlots() : Vector.<HiringSlotView>
      {
         return _hiringSlots;
      }
   }
}

