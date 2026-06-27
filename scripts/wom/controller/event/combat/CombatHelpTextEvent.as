package wom.controller.event.combat
{
   import flash.events.Event;
   
   public class CombatHelpTextEvent extends Event
   {
      
      public static const FIRST_UNIT_DEPLOY_TEXT:String = "firstUnitDeployText";
      
      public static const TAP_WAR_BUTTON_TEXT:String = "tapWarButtonText";
      
      public static const CITY_OUT_OF_REACH_TEXT:String = "cityOutOfReachText";
      
      private var _visible:Boolean;
      
      public function CombatHelpTextEvent(param1:String, param2:Boolean)
      {
         super(param1);
         _visible = param2;
      }
      
      override public function clone() : Event
      {
         return new CombatHelpTextEvent(type,_visible);
      }
      
      public function get visible() : Boolean
      {
         return _visible;
      }
   }
}

