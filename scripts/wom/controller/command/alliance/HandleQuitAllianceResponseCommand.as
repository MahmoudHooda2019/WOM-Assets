package wom.controller.command.alliance
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.model.game.alliance.AllianceInfo;
   import wom.model.message.response.alliance.QuitAllianceResponse;
   import wom.service.messaging.ErrorCodeRepository;
   import wom.view.screen.popups.GenericActionPopUp;
   
   public class HandleQuitAllianceResponseCommand extends PCommand
   {
      
      [Inject]
      public var event:MessageReceivedEvent;
      
      [Inject]
      public var errorCodeRepository:ErrorCodeRepository;
      
      [Inject]
      public var allianceInfo:AllianceInfo;
      
      public function HandleQuitAllianceResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:QuitAllianceResponse = event.message as QuitAllianceResponse;
         if(_loc1_.resultCode != 0)
         {
            errorCodeRepository.dispatchError("Alliance",_loc1_.resultCode,GenericActionPopUp);
         }
      }
   }
}

