package wom.controller.command.city
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.alliance.UnitsOfMemberOrFriendReceivedEvent;
   import wom.model.message.response.GetWatchPostUnitsOfFriendResponse;
   
   public class HandleGetWatchPostUnitsOfFriendResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      public function HandleGetWatchPostUnitsOfFriendResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:GetWatchPostUnitsOfFriendResponse = messageReceivedEvent.message as GetWatchPostUnitsOfFriendResponse;
         if(_loc1_.resultCode != 0)
         {
            return;
         }
         dispatch(new UnitsOfMemberOrFriendReceivedEvent("unitsOfFriendWatchPostReceived",_loc1_.friendWatchPostLevel,_loc1_.availableFriendWatchPostCapacity,_loc1_.units,_loc1_.unitLevels));
      }
   }
}

