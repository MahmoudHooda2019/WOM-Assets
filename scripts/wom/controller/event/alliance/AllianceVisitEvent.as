package wom.controller.event.alliance
{
   import flash.events.Event;
   import wom.model.game.Profile;
   
   public class AllianceVisitEvent extends Event
   {
      
      public static const VISIT:String = "allianceVisit";
      
      private var _profile:Profile;
      
      public function AllianceVisitEvent(param1:String, param2:Profile)
      {
         super(param1);
         _profile = param2;
      }
      
      override public function clone() : Event
      {
         return new AllianceVisitEvent(type,_profile);
      }
      
      public function get profile() : Profile
      {
         return _profile;
      }
   }
}

