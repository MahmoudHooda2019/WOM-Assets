package wom.model.game.alliance
{
   import wom.model.game.alliance.coa.CoatOfArmsInfo;
   
   public class AllianceInvitationInfo
   {
      
      private var _allianceId:Number;
      
      private var _allianceName:String;
      
      private var _coatOfArmsInfo:CoatOfArmsInfo;
      
      public function AllianceInvitationInfo(param1:Number, param2:String, param3:CoatOfArmsInfo)
      {
         super();
         _allianceId = param1;
         _allianceName = param2;
         _coatOfArmsInfo = param3;
      }
      
      public function get allianceId() : Number
      {
         return _allianceId;
      }
      
      public function get allianceName() : String
      {
         return _allianceName;
      }
      
      public function get coatOfArmsInfo() : CoatOfArmsInfo
      {
         return _coatOfArmsInfo;
      }
   }
}

