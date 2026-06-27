package wom.controller.command.ui
{
   import peak.network.ClientEvent;
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.ui.CaptchaEvent;
   import wom.model.game.UserInfo;
   import wom.model.message.request.GetNewCaptchaRequest;
   import wom.model.message.response.ConfirmCaptchaResponse;
   
   public class HandleConfirmCaptchaResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function HandleConfirmCaptchaResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:ConfirmCaptchaResponse = messageReceivedEvent.message as ConfirmCaptchaResponse;
         if(_loc1_.captchaCorrect)
         {
            dispatch(new CaptchaEvent("closeCaptchaWindow"));
            userInfo.captchaEnabled = false;
            if(userInfo.profile == null)
            {
               dispatch(new ClientEvent("connectionEstablished"));
            }
         }
         else
         {
            dispatch(new OutgoingMessageEvent("outgoingMessage",new GetNewCaptchaRequest()));
         }
      }
   }
}

