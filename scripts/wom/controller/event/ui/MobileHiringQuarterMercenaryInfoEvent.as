package wom.controller.event.ui
{
   import flash.events.Event;
   
   public class MobileHiringQuarterMercenaryInfoEvent extends Event
   {
      
      public static const SHOW_INFO:String = "info";
      
      private var _unitId:int;
      
      public function MobileHiringQuarterMercenaryInfoEvent(param1:String, param2:int)
      {
         super(param1);
         _unitId = param2;
      }
      
      override public function clone() : Event
      {
         return new MobileHiringQuarterMercenaryInfoEvent(type,_unitId);
      }
      
      public function get unitId() : int
      {
         return _unitId;
      }
   }
}

