package wom.model.game.alliance
{
   public class AllianceMembersRankingInfo
   {
      
      private var _allianceId:Number;
      
      private var _allianceName:String;
      
      private var _members:Vector.<AllianceMemberInfo>;
      
      public function AllianceMembersRankingInfo(param1:Number, param2:String, param3:Vector.<AllianceMemberInfo>)
      {
         super();
         _allianceId = param1;
         _allianceName = param2;
         _members = param3;
      }
      
      public function get allianceId() : Number
      {
         return _allianceId;
      }
      
      public function get allianceName() : String
      {
         return _allianceName;
      }
      
      public function get members() : Vector.<AllianceMemberInfo>
      {
         return _members;
      }
   }
}

