package wom.controller.command
{
   import flash.utils.getTimer;
   import peak.network.ServerConnection;
   import wom.controller.PCommand;
   import wom.controller.event.KeepAliveEvent;
   import wom.model.game.UserInfo;
   
   public class KeepAliveCommand extends PCommand
   {
      
      public static const KEEPALIVE_INTERVAL:Number = 60000;
      
      [Inject]
      public var event:KeepAliveEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject(name="gameServer")]
      public var serverConnection:ServerConnection;
      
      public function KeepAliveCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:int = getTimer();
         if(_loc1_ - userInfo.lastKeepAliveSendTimer >= 60000)
         {
            userInfo.lastKeepAliveSendTimer = _loc1_;
            serverConnection.keepAlive();
         }
      }
   }
}

