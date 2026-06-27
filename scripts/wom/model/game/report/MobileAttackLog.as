package wom.model.game.report
{
   import wom.model.game.Profile;
   import wom.model.game.alliance.AllianceSummaryInfo;
   
   public class MobileAttackLog extends AttackLog
   {
      
      private var _attackerName:String;
      
      private var _defenderName:String;
      
      public function MobileAttackLog(param1:Number, param2:Profile, param3:AllianceSummaryInfo, param4:Profile, param5:AllianceSummaryInfo, param6:Number, param7:Number, param8:Boolean, param9:Boolean, param10:int, param11:int, param12:int, param13:int, param14:int, param15:Boolean)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13,param14,param15);
         _attackerName = null;
         _defenderName = null;
      }
      
      public function get attackerName() : String
      {
         return _attackerName;
      }
      
      public function set attackerName(param1:String) : void
      {
         _attackerName = param1;
      }
      
      public function get defenderName() : String
      {
         return _defenderName;
      }
      
      public function set defenderName(param1:String) : void
      {
         _defenderName = param1;
      }
   }
}

