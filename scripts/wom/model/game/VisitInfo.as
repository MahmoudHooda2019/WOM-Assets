package wom.model.game
{
   public interface VisitInfo
   {
      
      function get guid() : Number;
      
      function set guid(param1:Number) : void;
      
      function get landlord() : Profile;
      
      function set landlord(param1:Profile) : void;
      
      function get isFriend() : Boolean;
      
      function set isFriend(param1:Boolean) : void;
      
      function get remainingHelpCount() : int;
      
      function set remainingHelpCount(param1:int) : void;
      
      function get interactable() : Boolean;
      
      function set interactable(param1:Boolean) : void;
      
      function reset() : void;
      
      function set isScout(param1:Boolean) : void;
      
      function get isScout() : Boolean;
      
      function get isOutOfReachForAttack() : Boolean;
      
      function set isOutOfReachForAttack(param1:Boolean) : void;
      
      function get bpGainEnabled() : Boolean;
      
      function set bpGainEnabled(param1:Boolean) : void;
   }
}

