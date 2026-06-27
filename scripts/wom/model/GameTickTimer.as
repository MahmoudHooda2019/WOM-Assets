package wom.model
{
   import flash.errors.IllegalOperationError;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import org.robotlegs.mvcs.Actor;
   import peak.logging.LoggerContext;
   import peak.logging.LoggerContexts;
   import peak.logging.log;
   import wom.controller.event.GameTickEvent;
   import wom.model.configuration.WomDocumentConfiguration;
   import wom.service.logging.WomLoggerContexts;
   
   public class GameTickTimer extends Actor
   {
      
      private static const TICK_TIME_INTERVAL:int = 1000;
      
      private var tickTimer:Timer;
      
      private var _tickCount:Number = 0;
      
      private const AUTO_REFRESH_INTERVAL_IN_SECONDS:int = 5;
      
      private var _timeDifferenceFromServer:Number;
      
      private var isConfigured:Boolean;
      
      private var isStarted:Boolean;
      
      [Inject]
      public var documentConfiguration:WomDocumentConfiguration;
      
      public function GameTickTimer()
      {
         super();
         tickTimer = new Timer(1000);
         _timeDifferenceFromServer = 0;
         isConfigured = false;
         isStarted = false;
      }
      
      public function configure(param1:Number) : void
      {
         if(!isStarted)
         {
            _timeDifferenceFromServer = param1;
            isConfigured = true;
            return;
         }
         throw new IllegalOperationError("GameTickTimer.configure, game tick timer can not be configured while it is running!");
      }
      
      public function start() : void
      {
         if(isConfigured)
         {
            if(!isStarted)
            {
               eventMap.mapListener(tickTimer,"timer",onTick,TimerEvent);
               tickTimer.start();
               isStarted = true;
            }
            else
            {
               log(LoggerContext.combine(LoggerContexts.INFRASTRUCTURE,WomLoggerContexts.GAME),"GameTickTimer.start, game tick timer is already running!");
            }
            return;
         }
         throw new IllegalOperationError("GameTickTimer.start, game tick timer can not be started before it is configured!");
      }
      
      public function stop() : void
      {
         if(isStarted)
         {
            eventMap.unmapListener(tickTimer,"timer",onTick,TimerEvent);
            tickTimer.stop();
            isStarted = false;
         }
         else
         {
            log(LoggerContext.combine(LoggerContexts.INFRASTRUCTURE,WomLoggerContexts.GAME),"GameTickTimer.stop, game tick timer is already stopped!");
         }
      }
      
      private function onTick(param1:TimerEvent) : void
      {
         _tickCount = _tickCount + 1;
         dispatch(new GameTickEvent("tick",_timeDifferenceFromServer));
      }
   }
}

