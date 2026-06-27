package wom.model.game
{
   public class DefaultVisitInfo implements VisitInfo
   {
      
      public static const MAX_VISIT_LIMIT:int = 75;
      
      private var _guid:Number;
      
      private var _landlord:Profile;
      
      private var _isFriend:Boolean;
      
      private var _remainingHelpCount:int;
      
      private var _interactable:Boolean;
      
      private var _isScout:Boolean;
      
      private var _isOutOfReachForAttack:Boolean;
      
      private var _bpGainEnabled:Boolean;
      
      public function DefaultVisitInfo()
      {
         super();
      }
      
      public function reset() : void
      {
         _guid = -1;
         _landlord = null;
         _isFriend = false;
         _remainingHelpCount = -1;
         _interactable = false;
         _isOutOfReachForAttack = false;
         _bpGainEnabled = false;
      }
      
      public function get guid() : Number
      {
         return _guid;
      }
      
      public function set guid(param1:Number) : void
      {
         _guid = param1;
      }
      
      public function get landlord() : Profile
      {
         return _landlord;
      }
      
      public function set landlord(param1:Profile) : void
      {
         _landlord = param1;
      }
      
      public function get isFriend() : Boolean
      {
         return _isFriend;
      }
      
      public function set isFriend(param1:Boolean) : void
      {
         _isFriend = param1;
      }
      
      public function get remainingHelpCount() : int
      {
         return _remainingHelpCount;
      }
      
      public function set remainingHelpCount(param1:int) : void
      {
         _remainingHelpCount = param1;
      }
      
      public function get interactable() : Boolean
      {
         return _interactable;
      }
      
      public function set interactable(param1:Boolean) : void
      {
         _interactable = param1;
      }
      
      public function get isScout() : Boolean
      {
         return _isScout;
      }
      
      public function set isScout(param1:Boolean) : void
      {
         _isScout = param1;
      }
      
      public function get isOutOfReachForAttack() : Boolean
      {
         return _isOutOfReachForAttack;
      }
      
      public function set isOutOfReachForAttack(param1:Boolean) : void
      {
         _isOutOfReachForAttack = param1;
      }
      
      public function get bpGainEnabled() : Boolean
      {
         return _bpGainEnabled;
      }
      
      public function set bpGainEnabled(param1:Boolean) : void
      {
         _bpGainEnabled = param1;
      }
   }
}

