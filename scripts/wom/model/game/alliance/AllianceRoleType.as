package wom.model.game.alliance
{
   public class AllianceRoleType
   {
      
      public static const LEADER:AllianceRoleType = new AllianceRoleType(0);
      
      public static const MEMBER:AllianceRoleType = new AllianceRoleType(1);
      
      public static const OUTSIDER:AllianceRoleType = new AllianceRoleType(2);
      
      private var id:int;
      
      public function AllianceRoleType(param1:int)
      {
         super();
         this.id = param1;
      }
      
      public static function determineRoleType(param1:int) : AllianceRoleType
      {
         var _loc2_:AllianceRoleType = OUTSIDER;
         switch(param1)
         {
            case OUTSIDER.id:
               _loc2_ = OUTSIDER;
               break;
            case MEMBER.id:
               _loc2_ = MEMBER;
               break;
            case LEADER.id:
               _loc2_ = LEADER;
         }
         return _loc2_;
      }
   }
}

