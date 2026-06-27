package wom.controller.command.bootstrap
{
   import flash.system.Capabilities;
   import peak.logging.ConsoleLoggerTarget;
   import peak.logging.Logger;
   import peak.logging.LoggerContexts;
   import peak.logging.ShippingLoggerTarget;
   import peak.logging.TraceLoggerTarget;
   import peak.logging.log;
   import wom.controller.PCommand;
   import wom.model.configuration.WomDocumentConfiguration;
   import wom.service.logging.WomLoggerContexts;
   
   public class BootstrapLoggerCommand extends PCommand
   {
      
      [Inject]
      public var logger:Logger;
      
      [Inject]
      public var logShipper:ShippingLoggerTarget;
      
      [Inject]
      public var documentConfiguration:WomDocumentConfiguration;
      
      public function BootstrapLoggerCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         configureLogger();
         log(LoggerContexts.INFRASTRUCTURE,"WoM " + documentConfiguration.getParameter("buildTime") + " " + documentConfiguration.getParameter("buildRef"),null);
      }
      
      private function configureLogger() : void
      {
         injector.injectInto(logger);
         if(documentConfiguration.logEnabled)
         {
            logger.addTarget(logShipper);
         }
         if(Capabilities.playerType == "ActiveX" || Capabilities.playerType == "PlugIn")
         {
            if(documentConfiguration.hasParameter("clog"))
            {
               logger.addTarget(new ConsoleLoggerTarget());
            }
         }
         else
         {
            logger.addTarget(new TraceLoggerTarget());
         }
         configureLoggerContexts();
      }
      
      private function configureLoggerContexts() : void
      {
         logger.enableContext(LoggerContexts.INFRASTRUCTURE);
         logger.enableContext(LoggerContexts.NETWORK);
         logger.enableContext(LoggerContexts.UNEXPECTED);
         logger.enableContext(LoggerContexts.UNCAUGHT_ERROR);
         logger.enableContext(LoggerContexts.CUCKOOERROR);
         logger.enableContext(LoggerContexts.RENDER);
         logger.enableContext(WomLoggerContexts.GAME);
         logger.enableContext(WomLoggerContexts.KONTAGENT);
      }
   }
}

