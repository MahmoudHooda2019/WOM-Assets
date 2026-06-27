package wom.controller.event.unit
{
   import flash.events.Event;
   
   public class ChooseAttackingSoldierEvent extends Event
   {
      
      public static const CHOOSE:String = "chooseAttackingSoldierEvent";
      
      private var _unitTypeId:int;
      
      private var _select:Boolean;
      
      private var _inTutorial:Boolean;
      
      public function ChooseAttackingSoldierEvent(param1:String, param2:int, param3:Boolean, param4:Boolean = false)
      {
         super(param1);
         _unitTypeId = param2;
         _select = param3;
         _inTutorial = param4;
      }
      
      override public function clone() : Event
      {
         return new ChooseAttackingSoldierEvent(type,_unitTypeId,_select,_inTutorial);
      }
      
      public function get unitTypeId() : int
      {
         return _unitTypeId;
      }
      
      public function get select() : Boolean
      {
         return _select;
      }
      
      public function get inTutorial() : Boolean
      {
         return _inTutorial;
      }
   }
}

