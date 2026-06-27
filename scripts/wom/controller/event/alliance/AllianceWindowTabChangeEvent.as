package wom.controller.event.alliance
{
   import flash.events.Event;
   
   public class AllianceWindowTabChangeEvent extends Event
   {
      
      public static const CHANGE_ALLIANCE_TAB:String = "changeAllianceTab";
      
      public static const ALLIANCE_TAB_CHANGED:String = "allianceTabChanged";
      
      private var _tabIndex:int;
      
      public function AllianceWindowTabChangeEvent(param1:String, param2:int)
      {
         super(param1);
         _tabIndex = param2;
      }
      
      override public function clone() : Event
      {
         return new AllianceWindowTabChangeEvent(type,_tabIndex);
      }
      
      public function get tabIndex() : int
      {
         return _tabIndex;
      }
   }
}

