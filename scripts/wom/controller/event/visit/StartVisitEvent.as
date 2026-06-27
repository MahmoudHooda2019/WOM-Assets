package wom.controller.event.visit
{
   import flash.events.Event;
   import wom.model.game.Profile;
   
   public class StartVisitEvent extends Event
   {
      
      public static const START_VISIT:String = "startVisit";
      
      private var _profile:Profile;
      
      private var _npc:Boolean;
      
      private var _fromMap:Boolean;
      
      private var _isScout:Boolean;
      
      private var _fromCampaign:Boolean;
      
      public function StartVisitEvent(param1:String, param2:Profile, param3:Boolean, param4:Boolean, param5:Boolean = false, param6:Boolean = false)
      {
         super(param1);
         _profile = param2;
         _npc = param3;
         _fromMap = param5;
         _isScout = param4;
         _fromCampaign = param6;
      }
      
      override public function clone() : Event
      {
         return new StartVisitEvent(type,_profile,_npc,_isScout,_fromMap);
      }
      
      public function get profile() : Profile
      {
         return _profile;
      }
      
      public function get npc() : Boolean
      {
         return _npc;
      }
      
      public function get fromMap() : Boolean
      {
         return _fromMap;
      }
      
      public function get isScout() : Boolean
      {
         return _isScout;
      }
      
      public function get fromCampaign() : Boolean
      {
         return _fromCampaign;
      }
   }
}

