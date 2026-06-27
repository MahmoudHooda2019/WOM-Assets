package wom.controller.command.visit
{
   import peak.logging.log;
   import wom.controller.command.city.CityLoaderCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.message.response.StartSpyingResponse;
   import wom.service.logging.WomLoggerContexts;
   import wom.view.screen.popups.underattack.MobileAlreadyUnderAttackPopUp;
   
   public class HandleStartSpyingResponseCommand extends CityLoaderCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      public function HandleStartSpyingResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:StartSpyingResponse = messageReceivedEvent.message as StartSpyingResponse;
         var _loc2_:SpyErrorType = SpyErrorType.determineSpyErrorType(_loc1_.resultCode);
         if(_loc2_ == SpyErrorType.SUCCESS)
         {
            city.spyEnabled = true;
            dispatch(new ModelUpdateEvent("spyStatusChange"));
            coreManager.startSpying();
         }
         else
         {
            log(WomLoggerContexts.GAME,"Spying Failed : " + _loc1_.resultMessage);
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileAlreadyUnderAttackPopUp(_loc2_.errorPopupCode,false),0,null,null,false,userInfo.delayPopups));
         }
      }
   }
}

