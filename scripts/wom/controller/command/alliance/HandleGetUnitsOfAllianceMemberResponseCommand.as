package wom.controller.command.alliance
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.alliance.UnitsOfMemberOrFriendReceivedEvent;
   import wom.model.message.response.alliance.GetUnitsOfAllianceMemberResponse;
   
   public class HandleGetUnitsOfAllianceMemberResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      public function HandleGetUnitsOfAllianceMemberResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:GetUnitsOfAllianceMemberResponse = messageReceivedEvent.message as GetUnitsOfAllianceMemberResponse;
         if(_loc1_.resultCode != 0)
         {
            return;
         }
         dispatch(new UnitsOfMemberOrFriendReceivedEvent("unitsOfAllianceMemberReceived",_loc1_.allianceBarracksLevel,_loc1_.availableBarracksCapacity,_loc1_.units,_loc1_.unitLevels));
      }
   }
}

