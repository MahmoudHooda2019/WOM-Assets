package wom.model.game.alliance
{
   import wom.model.game.alliance.coa.CoatOfArmsInfo;
   
   public class AllianceSummaryInfo
   {
      
      private var _id:Number;
      
      private var _name:String;
      
      private var _role:AllianceRoleType;
      
      private var _coaInfo:CoatOfArmsInfo;
      
      public function AllianceSummaryInfo(param1:Number, param2:String, param3:AllianceRoleType, param4:CoatOfArmsInfo)
      {
         super();
         _id = param1;
         _name = param2;
         _role = param3;
         _coaInfo = param4;
      }
      
      public function get id() : Number
      {
         return _id;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get role() : AllianceRoleType
      {
         return _role;
      }
      
      public function get coaInfo() : CoatOfArmsInfo
      {
         return _coaInfo;
      }
   }
}

