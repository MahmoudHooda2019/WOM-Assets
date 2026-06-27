package wom.controller.event.combat
{
   import flash.events.Event;
   import wom.model.game.Profile;
   
   public class StartAttackEvent extends Event
   {
      
      public static const START_ATTACK:String = "startAttack";
      
      public static const START_SPYING:String = "startSpying";
      
      private var _profile:Profile;
      
      private var _tearProtection:Boolean;
      
      private var _checkResources:Boolean;
      
      private var _npc:Boolean;
      
      private var _fromMap:Boolean;
      
      private var _isQuickAttack:Boolean;
      
      private var _fromCampaign:Boolean;
      
      private var _isTournamentAttack:Boolean;
      
      private var _isTournamentAttackByGold:Boolean;
      
      public function StartAttackEvent(param1:String, param2:Profile, param3:Boolean, param4:Boolean = false, param5:Boolean = true, param6:Boolean = false, param7:Boolean = false, param8:Boolean = false, param9:Boolean = false, param10:Boolean = false)
      {
         super(param1);
         _profile = param2;
         _tearProtection = param4;
         _checkResources = param5;
         _npc = param3;
         _fromMap = param6;
         _isQuickAttack = param7;
         _fromCampaign = param8;
         _isTournamentAttack = param9;
         _isTournamentAttackByGold = param10;
      }
      
      override public function clone() : Event
      {
         return new StartAttackEvent(type,_profile,_npc,_tearProtection,_checkResources,_fromMap,_isQuickAttack,_fromCampaign,_isTournamentAttack,_isTournamentAttackByGold);
      }
      
      public function get profile() : Profile
      {
         return _profile;
      }
      
      public function get tearProtection() : Boolean
      {
         return _tearProtection;
      }
      
      public function get checkResources() : Boolean
      {
         return _checkResources;
      }
      
      public function get npc() : Boolean
      {
         return _npc;
      }
      
      public function get fromMap() : Boolean
      {
         return _fromMap;
      }
      
      public function get isQuickAttack() : Boolean
      {
         return _isQuickAttack;
      }
      
      public function get fromCampaign() : Boolean
      {
         return _fromCampaign;
      }
      
      public function get isTournamentAttack() : Boolean
      {
         return _isTournamentAttack;
      }
      
      public function get isTournamentAttackByGold() : Boolean
      {
         return _isTournamentAttackByGold;
      }
   }
}

