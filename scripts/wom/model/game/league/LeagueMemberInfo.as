package wom.model.game.league
{
   import peak.i18n.PText;
   import wom.model.game.Profile;
   import wom.model.game.alliance.AllianceSummaryInfo;
   
   public class LeagueMemberInfo
   {
      
      private var _profile:Profile;
      
      private var _rank:int;
      
      private var _level:int;
      
      private var _battlePoints:Number;
      
      private var _numberOfWinsAsAttacker:int;
      
      private var _numberOfWinsAsDefender:int;
      
      private var _allianceSummary:AllianceSummaryInfo;
      
      private var _name:String;
      
      public function LeagueMemberInfo(param1:Profile, param2:int, param3:int, param4:Number, param5:int, param6:int, param7:AllianceSummaryInfo)
      {
         super();
         _profile = param1;
         _rank = param2;
         _level = param3;
         _battlePoints = param4;
         _numberOfWinsAsAttacker = param5;
         _numberOfWinsAsDefender = param6;
         _allianceSummary = param7;
         var _loc8_:String = "ui.defaultplayername";
         _name = peak.i18n.PText.INSTANCE.getText0(_loc8_);
      }
      
      public function get profile() : Profile
      {
         return _profile;
      }
      
      public function get rank() : int
      {
         return _rank;
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      public function set level(param1:int) : void
      {
         _level = param1;
      }
      
      public function get battlePoints() : Number
      {
         return _battlePoints;
      }
      
      public function set battlePoints(param1:Number) : void
      {
         _battlePoints = param1;
      }
      
      public function get numberOfWinsAsAttacker() : int
      {
         return _numberOfWinsAsAttacker;
      }
      
      public function set numberOfWinsAsAttacker(param1:int) : void
      {
         _numberOfWinsAsAttacker = param1;
      }
      
      public function get numberOfWinsAsDefender() : int
      {
         return _numberOfWinsAsDefender;
      }
      
      public function set numberOfWinsAsDefender(param1:int) : void
      {
         _numberOfWinsAsDefender = param1;
      }
      
      public function get allianceSummary() : AllianceSummaryInfo
      {
         return _allianceSummary;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set name(param1:String) : void
      {
         var _loc2_:String;
         _name = param1 != null ? param1 : (_loc2_ = "ui.defaultplayername",peak.i18n.PText.INSTANCE.getText0(_loc2_));
      }
   }
}

