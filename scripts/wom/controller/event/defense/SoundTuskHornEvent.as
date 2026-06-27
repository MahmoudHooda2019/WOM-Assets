package wom.controller.event.defense
{
   import flash.events.Event;
   import wom.model.dto.UnitTypeAmountDTO;
   
   public class SoundTuskHornEvent extends Event
   {
      
      public static const START_DEFENSE:String = "startDefense";
      
      private var _units:Vector.<UnitTypeAmountDTO>;
      
      public function SoundTuskHornEvent(param1:String, param2:Vector.<UnitTypeAmountDTO>)
      {
         super(param1);
         _units = param2;
      }
      
      override public function clone() : Event
      {
         return new SoundTuskHornEvent(type,_units);
      }
      
      public function get units() : Vector.<UnitTypeAmountDTO>
      {
         return _units;
      }
   }
}

