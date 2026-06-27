package wom.controller.command.tavern
{
   import flash.utils.getTimer;
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.TavernItemDIO;
   import wom.model.game.tavern.TavernInfo;
   import wom.model.message.response.tavern.TavernSpinResponse;
   import wom.service.messaging.ErrorCodeRepository;
   import wom.view.screen.popups.GenericActionPopUp;
   
   public class HandleTavernSpinResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var tavernInfo:TavernInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var errorCodeRepository:ErrorCodeRepository;
      
      public function HandleTavernSpinResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:TavernSpinResponse = messageReceivedEvent.message as TavernSpinResponse;
         if(_loc1_.resultCode != 0)
         {
            errorCodeRepository.dispatchError("Tavern",_loc1_.resultCode,GenericActionPopUp);
            tavernInfo.spinInfo.spinCancelled = true;
            return;
         }
         tavernInfo.tillNextSpin = getTimer() + _loc1_.tillNextSpin;
         var _loc2_:TavernItemDIO = domainInfo.getTavernItem(_loc1_.spinGiftId);
         if(_loc2_ != null)
         {
            tavernInfo.spinInfo.resultTavernItemDIO = _loc2_;
         }
         if(_loc1_.unlockedCardIndex >= 0)
         {
            tavernInfo.unlockedCards[_loc1_.unlockedCardIndex] = true;
         }
      }
   }
}

