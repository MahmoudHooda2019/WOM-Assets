package wom.controller.command.ui
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ui.CaptchaEvent;
   import wom.model.game.UserInfo;
   import wom.model.message.notification.ShowCaptchaEventNotification;
   
   public class HandleShowCaptchaEventNotificationCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function HandleShowCaptchaEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:ShowCaptchaEventNotification = messageReceivedEvent.message as ShowCaptchaEventNotification;
         userInfo.captchaEnabled = true;
         dispatch(new CaptchaEvent("showCaptchaWindow"));
         dispatch(new CaptchaEvent("updateCaptcha",_loc1_.captchaImageByteArray,_loc1_.captchaWidth,_loc1_.captchaHeight));
      }
   }
}

