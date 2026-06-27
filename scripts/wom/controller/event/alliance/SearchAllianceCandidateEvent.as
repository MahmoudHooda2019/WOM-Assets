package wom.controller.event.alliance
{
   import flash.events.Event;
   
   public class SearchAllianceCandidateEvent extends Event
   {
      
      public static const SEARCH_USER:String = "searchUser";
      
      private var _guid:String;
      
      public function SearchAllianceCandidateEvent(param1:String, param2:String)
      {
         super(param1);
         _guid = param2;
      }
      
      override public function clone() : Event
      {
         return new SearchAllianceCandidateEvent(type,_guid);
      }
      
      public function get guid() : String
      {
         return _guid;
      }
   }
}

