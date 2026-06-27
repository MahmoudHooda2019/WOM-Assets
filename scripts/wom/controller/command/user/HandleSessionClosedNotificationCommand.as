package wom.controller.command.user
{
   import peak.logging.log;
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.StopRootUpdaterEvent;
   import wom.controller.event.ui.PopUpWindowEvent;
   import wom.model.GameTickTimer;
   import wom.model.game.UserInfo;
   import wom.model.game.connection.DisconnectionReasonType;
   import wom.model.message.notification.SessionClosedNotification;
   import wom.service.logging.WomLoggerContexts;
   import wom.view.screen.popups.AnyoneHomePopUp;
   import wom.view.screen.popups.DidYouKnowPopUp;
   
   public class HandleSessionClosedNotificationCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var gameTickTimer:GameTickTimer;
      
      public function HandleSessionClosedNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:SessionClosedNotification = null;
         if(userInfo.profile != null)
         {
            _loc1_ = messageReceivedEvent.message as SessionClosedNotification;
            if(_loc1_.disconnecting)
            {
               userInfo.disconnectionReason = _loc1_.reason;
               log(WomLoggerContexts.STATUS,"Server is closing connection. Reason id : " + _loc1_.reason.id);
               dispatch(new StopRootUpdaterEvent("stopRoot"));
               gameTickTimer.stop();
            }
            else if(_loc1_.reason == DisconnectionReasonType.IDLE)
            {
               if(Math.random() > 0.5)
               {
                  dispatch(new PopUpWindowEvent("showPopUpWindow",new AnyoneHomePopUp(),0,null,null,false,userInfo.delayPopups));
               }
               else
               {
                  dispatch(new PopUpWindowEvent("showPopUpWindow",new DidYouKnowPopUp(),0,null,null,false,userInfo.delayPopups));
               }
            }
         }
      }
   }
}

