package wom.model.game.alliance
{
   public class AllianceMembershipType
   {
      
      public static const OPEN:AllianceMembershipType = new AllianceMembershipType(0,"ui.windows.alliance.browse.create.open");
      
      public static const INVITATION:AllianceMembershipType = new AllianceMembershipType(1,"ui.windows.alliance.browse.create.invitation","m.ui.windows.alliance.browse.create.invitation");
      
      public static const CLOSED:AllianceMembershipType = new AllianceMembershipType(2,"ui.windows.alliance.browse.create.closed");
      
      private var _id:int;
      
      private var _i18nKey:String;
      
      private var _mobileI18nKey:String;
      
      public function AllianceMembershipType(param1:int, param2:String, param3:String = null)
      {
         super();
         _id = param1;
         _i18nKey = param2;
         _mobileI18nKey = param3 ? param3 : param2;
      }
      
      public static function determineMembershiptType(param1:int) : AllianceMembershipType
      {
         var _loc2_:AllianceMembershipType = OPEN;
         switch(param1)
         {
            case OPEN._id:
               _loc2_ = OPEN;
               break;
            case INVITATION._id:
               _loc2_ = INVITATION;
               break;
            case CLOSED._id:
               _loc2_ = CLOSED;
         }
         return _loc2_;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get i18nKey() : String
      {
         return _i18nKey;
      }
      
      public function get mobileI18nKey() : String
      {
         return _mobileI18nKey;
      }
   }
}

