package wom.controller.event.ui
{
   import flash.events.Event;
   
   public class MobileMapListSelectionToggleEvent extends Event
   {
      
      public static const TOGGLE:String = "MobileMapListSelectionToggle";
      
      private var _selected:Boolean;
      
      public function MobileMapListSelectionToggleEvent(param1:String, param2:Boolean)
      {
         super(param1);
         _selected = param2;
      }
      
      override public function clone() : Event
      {
         return new MobileMapListSelectionToggleEvent(type,_selected);
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
   }
}

