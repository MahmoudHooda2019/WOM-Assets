package wom.model.game.staff
{
   import wom.model.game.Profile;
   
   public class StaffInfo
   {
      
      private var _staffId:int;
      
      private var _profile:Profile;
      
      public function StaffInfo(param1:int, param2:Profile)
      {
         super();
         _staffId = param1;
         _profile = param2;
      }
      
      public function get staffId() : int
      {
         return _staffId;
      }
      
      public function get profile() : Profile
      {
         return _profile;
      }
   }
}

