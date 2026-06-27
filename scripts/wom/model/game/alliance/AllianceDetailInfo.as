package wom.model.game.alliance
{
   import wom.model.game.Profile;
   import wom.model.game.alliance.coa.CoatOfArmsInfo;
   
   public class AllianceDetailInfo
   {
      
      private var _id:Number;
      
      private var _name:String;
      
      private var _rank:int;
      
      private var _members:int;
      
      private var _membershipType:AllianceMembershipType;
      
      private var _score:int;
      
      private var _minScore:int;
      
      private var _minLevel:int;
      
      private var _description:String;
      
      private var _coatOfArmsInfo:CoatOfArmsInfo;
      
      private var _requestSent:Boolean;
      
      private var _leader:Profile;
      
      public function AllianceDetailInfo(param1:Number, param2:String, param3:int, param4:int, param5:AllianceMembershipType, param6:int, param7:int, param8:int, param9:String, param10:CoatOfArmsInfo, param11:Profile)
      {
         super();
         _id = param1;
         _name = param2;
         _rank = param3;
         _members = param4;
         _membershipType = param5;
         _score = param6;
         _minScore = param7;
         _minLevel = param8;
         _description = param9;
         _coatOfArmsInfo = param10;
         _leader = param11;
         _requestSent = false;
      }
      
      public function get id() : Number
      {
         return _id;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get rank() : int
      {
         return _rank;
      }
      
      public function get members() : int
      {
         return _members;
      }
      
      public function get membershipType() : AllianceMembershipType
      {
         return _membershipType;
      }
      
      public function get score() : int
      {
         return _score;
      }
      
      public function get minScore() : int
      {
         return _minScore;
      }
      
      public function get minLevel() : int
      {
         return _minLevel;
      }
      
      public function get description() : String
      {
         return _description;
      }
      
      public function get coatOfArmsInfo() : CoatOfArmsInfo
      {
         return _coatOfArmsInfo;
      }
      
      public function get requestSent() : Boolean
      {
         return _requestSent;
      }
      
      public function get leader() : Profile
      {
         return _leader;
      }
      
      public function set requestSent(param1:Boolean) : void
      {
         _requestSent = param1;
      }
   }
}

