package wom.controller.command
{
   import peak.network.ServerConnection;
   import wom.controller.PCommand;
   import wom.model.configuration.WomDocumentConfiguration;
   
   public class ConnectToGameServerCommand extends PCommand
   {
      
      [Inject(name="gameServer")]
      public var connection:ServerConnection;
      
      [Inject]
      public var documentConfiguration:WomDocumentConfiguration;
      
      public function ConnectToGameServerCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc3_:String = documentConfiguration.getParameter("serverUrl");
         var _loc2_:Array = String(documentConfiguration.getParameter("serverPort")).split(",");
         var _loc1_:int = _loc2_.pop();
         documentConfiguration.setParameter("serverPort",_loc2_);
         connection.connect(_loc3_,_loc1_);
      }
   }
}

