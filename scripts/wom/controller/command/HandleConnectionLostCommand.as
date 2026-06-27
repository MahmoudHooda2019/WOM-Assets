package wom.controller.command
{
   import peak.logging.LoggerContexts;
   import peak.logging.ShippingLoggerTarget;
   import peak.logging.log;
   import peak.network.ClientEvent;
   import peak.network.ServerConnection;
   import wom.controller.PCommand;
   import wom.controller.event.mobile.MobileApplicationStatusEvent;
   import wom.model.configuration.WomDocumentConfiguration;
   import wom.model.game.UserInfo;
   import wom.model.game.connection.DisconnectionReasonType;
   import wom.model.mobile.MobileConnectionServiceInfo;
   import wom.service.mobile.MobileApplicationStatusManager;
   
   public class HandleConnectionLostCommand extends PCommand
   {
      
      [Inject(name="chatServer")]
      public var chatServerConnection:ServerConnection;
      
      [Inject(name="gameServer")]
      public var gameServerConnection:ServerConnection;
      
      [Inject]
      public var logShipper:ShippingLoggerTarget;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var documentConfiguration:WomDocumentConfiguration;
      
      [Inject]
      public var mobileConnectionServiceInfo:MobileConnectionServiceInfo;
      
      [Inject]
      public var mobileApplicationStatusManager:MobileApplicationStatusManager;
      
      public function HandleConnectionLostCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         if(!userInfo.authResponseReceived && String(documentConfiguration.getParameter("serverPort")).length > 0)
         {
            gameServerConnection.reset();
            log(LoggerContexts.NETWORK,"Retrying server connection");
            dispatch(new ClientEvent("connectToServer"));
         }
         else
         {
            logShipper.flushBuffer();
            if(userInfo.disconnectionReason == DisconnectionReasonType.UNKNOWN_REASON)
            {
               dispatch(new MobileApplicationStatusEvent("disconnected",false));
            }
            else if(userInfo.disconnectionReason == DisconnectionReasonType.MULTIPLE_SESSION || userInfo.disconnectionReason == DisconnectionReasonType.INVALID_COMBAT)
            {
               dispatch(new MobileApplicationStatusEvent("disconnected",false));
            }
            else if(userInfo.disconnectionReason == DisconnectionReasonType.ACCOUNT_MERGE || userInfo.disconnectionReason == DisconnectionReasonType.IDLE)
            {
               dispatch(new MobileApplicationStatusEvent("disconnected",mobileApplicationStatusManager.autoReload));
            }
            else
            {
               dispatch(new MobileApplicationStatusEvent("disconnected",false));
            }
            chatServerConnection.disconnect();
            dispatch(new ClientEvent("connectionLostProcessed"));
         }
      }
   }
}

