package wom.controller.event.tutorial
{
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public class TutorialTriggerEvent extends Event
   {
      
      public static const TAB_BAR_INDEX_CHANGED:String = "tabBarIndexChanged";
      
      public static const DEFAULT_TRIGGER:String = "defaultActionTriggered";
      
      public static const START_BUILD:String = "startBuild";
      
      public static const TOOLTIP_SHOWN:String = "tooltipShown";
      
      public static const CENTER_MAP_MEMBER:String = "centerMapMember";
      
      public static const CHANGE_TAB_BAR_INDEX:String = "changeTabBarIndex";
      
      public static const SHOW_ALL_MAP_MEMBERS:String = "showAllMapMembers";
      
      private var _additionalInfo:Dictionary;
      
      public function TutorialTriggerEvent(param1:String, param2:Dictionary = null)
      {
         super(param1);
         _additionalInfo = param2 != null ? param2 : new Dictionary();
      }
      
      override public function clone() : Event
      {
         return new TutorialTriggerEvent(type,_additionalInfo);
      }
      
      public function get additionalInfo() : Dictionary
      {
         return _additionalInfo;
      }
   }
}

