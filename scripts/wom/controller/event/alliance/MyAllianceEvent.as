package wom.controller.event.alliance
{
   import flash.events.Event;
   
   public class MyAllianceEvent extends Event
   {
      
      public static const GENERAL_INFO:String = "navigateMyAllianceGeneralInfo";
      
      public static const MEMBERS:String = "navigateMyAllianceMembers";
      
      public static const EDIT_ALLIANCE:String = "editAlliance";
      
      public function MyAllianceEvent(param1:String)
      {
         super(param1);
      }
      
      override public function clone() : Event
      {
         return new MyAllianceEvent(type);
      }
   }
}

