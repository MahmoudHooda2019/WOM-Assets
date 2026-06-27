package wom.controller.event.alliance
{
   import flash.events.Event;
   
   public class RequestedAllianceUpdateEvent extends Event
   {
      
      public static const ALLIANCE_ID_REQUESTED:String = "allianceIdRequested";
      
      public static const ALL_ALLIANCE_REQUESTS_UPDATED:String = "allAllianceRequestsUpdated";
      
      private var _allianceId:Number;
      
      public function RequestedAllianceUpdateEvent(param1:String, param2:Number = -1)
      {
         super(param1);
         _allianceId = param2;
      }
      
      override public function clone() : Event
      {
         return new RequestedAllianceUpdateEvent(type,_allianceId);
      }
      
      public function get allianceId() : Number
      {
         return _allianceId;
      }
   }
}

