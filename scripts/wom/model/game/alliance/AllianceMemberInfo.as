package wom.model.game.alliance
{
   import peak.i18n.PText;
   import wom.model.game.Profile;
   
   public class AllianceMemberInfo
   {
      
      private var _profile:Profile;
      
      private var _level:int;
      
      private var _battlePoints:Number;
      
      private var _contributionPoints:Number;
      
      private var _type:int;
      
      private var _name:String;
      
      private var _isLeader:Boolean;
      
      private var _availableAllianceBarracksCapacity:int;
      
      private var _allianceBarracksLevel:int;
      
      private var _tournamentContributionPoint:int;
      
      public function AllianceMemberInfo(param1:Profile, param2:int, param3:Number, param4:Boolean = false, param5:int = 1, param6:Number = NaN, param7:int = 0, param8:int = 0, param9:int = 0)
      {
         super();
         _profile = param1;
         _level = param2;
         _battlePoints = param3;
         _type = param5;
         _contributionPoints = param6;
         _availableAllianceBarracksCapacity = param7;
         _allianceBarracksLevel = param8;
         _tournamentContributionPoint = param9;
         var _loc10_:String = "ui.defaultplayername";
         _name = peak.i18n.PText.INSTANCE.getText0(_loc10_);
         _isLeader = param4;
      }
      
      public function get profile() : Profile
      {
         return _profile;
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      public function get battlePoints() : Number
      {
         return _battlePoints;
      }
      
      public function get contributionPoints() : Number
      {
         return _contributionPoints;
      }
      
      public function get type() : int
      {
         return _type;
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
      
      public function set type(param1:int) : void
      {
         _type = param1;
      }
      
      public function get isLeader() : Boolean
      {
         return _isLeader;
      }
      
      public function get availableAllianceBarracksCapacity() : int
      {
         return _availableAllianceBarracksCapacity;
      }
      
      public function get allianceBarracksLevel() : int
      {
         return _allianceBarracksLevel;
      }
      
      public function get tournamentContributionPoint() : int
      {
         return _tournamentContributionPoint;
      }
      
      public function set tournamentContributionPoint(param1:int) : void
      {
         _tournamentContributionPoint = param1;
      }
   }
}

