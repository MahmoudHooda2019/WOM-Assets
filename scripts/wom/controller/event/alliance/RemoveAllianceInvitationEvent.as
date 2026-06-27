package wom.controller.event.alliance
{
   import flash.events.Event;
   
   public class RemoveAllianceInvitationEvent extends Event
   {
      
      public static const REMOVE:String = "removeAllianceInvitation";
      
      private var _allianceId:Number;
      
      public function RemoveAllianceInvitationEvent(param1:String, param2:Number)
      {
         super(param1);
         _allianceId = param2;
      }
      
      override public function clone() : Event
      {
         return new RemoveAllianceInvitationEvent(type,_allianceId);
      }
      
      public function get allianceId() : Number
      {
         return _allianceId;
      }
   }
}

