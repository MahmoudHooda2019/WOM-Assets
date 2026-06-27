package wom
{
   import org.robotlegs.mvcs.StarlingContext;
   import starling.display.DisplayObjectContainer;
   import wom.controller.command.bootstrap.BootstrapAssetsCommand;
   import wom.controller.command.bootstrap.BootstrapInternationalizationCommand;
   import wom.controller.command.bootstrap.BootstrapLoggerCommand;
   import wom.controller.command.bootstrap.BootstrapMessageCommandMapCommand;
   import wom.controller.command.bootstrap.BootstrapMessagingCommand;
   import wom.controller.command.bootstrap.MobileBootstrapCommandMapCommand;
   import wom.controller.command.bootstrap.MobileBootstrapInjectionsCommand;
   import wom.controller.command.bootstrap.MobileBootstrapMediatorsCommand;
   import wom.controller.command.bootstrap.MobileBootstrapStageCommand;
   import wom.controller.command.mobile.HandleRetrieveFlashVarsCommand;
   
   public class MobileClientContext extends StarlingContext
   {
      
      public function MobileClientContext(param1:DisplayObjectContainer = null, param2:Boolean = true)
      {
         super(param1,param2);
      }
      
      override public function startup() : void
      {
         commandMap.mapEvent("startupComplete",MobileBootstrapInjectionsCommand);
         commandMap.mapEvent("startupComplete",HandleRetrieveFlashVarsCommand);
         commandMap.mapEvent("flashVarsCompleted",BootstrapLoggerCommand);
         commandMap.mapEvent("flashVarsCompleted",BootstrapInternationalizationCommand);
         commandMap.mapEvent("flashVarsCompleted",BootstrapMessagingCommand);
         commandMap.mapEvent("flashVarsCompleted",BootstrapMessageCommandMapCommand);
         commandMap.mapEvent("flashVarsCompleted",BootstrapAssetsCommand);
         commandMap.mapEvent("flashVarsCompleted",MobileBootstrapCommandMapCommand);
         commandMap.mapEvent("flashVarsCompleted",MobileBootstrapMediatorsCommand);
         commandMap.mapEvent("flashVarsCompleted",MobileBootstrapStageCommand);
         commandMap.mapEvent("shutdownComplete",ShutdownCommand);
         super.startup();
      }
   }
}

import org.robotlegs.mvcs.StarlingCommand;
import peak.logging.Logger;
import peak.network.ServerConnection;
import peak.resource.SoundPlayer;
import starling.display.DisplayObject;
import starling.display.DisplayObjectContainer;
import wom.controller.event.StopRootUpdaterEvent;
import wom.model.game.WomGameRootHolder;
import wom.model.resource.WomAssetRepository;

class ShutdownCommand extends StarlingCommand
{
   
   [Inject]
   public var logger:Logger;
   
   [Inject]
   public var gameRootHolder:WomGameRootHolder;
   
   [Inject(name="gameServer")]
   public var gameConnection:ServerConnection;
   
   [Inject(name="chatServer")]
   public var chatConnection:ServerConnection;
   
   [Inject]
   public var assetRepository:WomAssetRepository;
   
   [Inject]
   public var soundPlayer:SoundPlayer;
   
   public function ShutdownCommand()
   {
      super();
   }
   
   protected static function disposeDisplayObjectContents(param1:DisplayObjectContainer) : void
   {
      var _loc4_:int = 0;
      var _loc2_:DisplayObject = null;
      var _loc3_:int = param1.numChildren;
      _loc4_ = _loc3_ - 1;
      while(_loc4_ >= 0)
      {
         _loc2_ = param1.getChildAt(_loc4_);
         if(_loc2_ is DisplayObjectContainer)
         {
            disposeDisplayObjectContents(_loc2_ as DisplayObjectContainer);
         }
         param1.removeChildAt(0,true);
         _loc4_--;
      }
   }
   
   override public function execute() : void
   {
      dispatch(new StopRootUpdaterEvent("stopRoot"));
      gameConnection.disconnect();
      chatConnection.disconnect();
      logger.reset();
      gameRootHolder.gameRoot.reset();
      gameRootHolder.gameRoot.destroy();
      assetRepository.dispose();
      soundPlayer.stopMusic(false);
      soundPlayer.stopAmbient();
      disposeDisplayObjectContents(Environment.starling.stage);
      commandMap.unmapEvents();
      mediatorMap.enabled = false;
   }
}
