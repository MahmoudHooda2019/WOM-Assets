package wom.controller.command.chat
{
   import peak.network.ServerConnection;
   import wom.controller.PCommand;
   import wom.model.configuration.WomDocumentConfiguration;
   
   public class ConnectToChatServerCommand extends PCommand
   {
      
      [Inject(name="chatServer")]
      public var connection:ServerConnection;
      
      [Inject]
      public var documentConfiguration:WomDocumentConfiguration;
      
      public function ConnectToChatServerCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc2_:String = documentConfiguration.getParameter("chatServerUrl");
         var _loc1_:int = documentConfiguration.getParameter("chatServerPort");
         connection.connect(_loc2_,_loc1_);
      }
   }
}

