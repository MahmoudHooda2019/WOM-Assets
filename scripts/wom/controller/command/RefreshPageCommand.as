package wom.controller.command
{
   import flash.external.ExternalInterface;
   import peak.logging.LoggerContexts;
   import peak.logging.log;
   import peak.network.ClientEvent;
   
   public class RefreshPageCommand
   {
      
      [Inject]
      public var event:ClientEvent;
      
      public function RefreshPageCommand()
      {
         super();
      }
      
      public function execute() : void
      {
         if(ExternalInterface.available)
         {
            log(LoggerContexts.INFRASTRUCTURE,"Page will be refreshed");
         }
         else
         {
            log(LoggerContexts.INFRASTRUCTURE,"Page refreshing is not available since external interface does not exist!");
         }
      }
   }
}

