package wom
{
   import flash.events.IEventDispatcher;
   import flash.system.ApplicationDomain;
   import org.robotlegs.adapters.SwiftSuspendersInjector;
   import org.robotlegs.adapters.SwiftSuspendersReflector;
   import org.robotlegs.base.CommandMap;
   import org.robotlegs.base.ContextBase;
   import org.robotlegs.base.ContextEvent;
   import org.robotlegs.core.ICommandMap;
   import org.robotlegs.core.IContext;
   import org.robotlegs.core.IInjector;
   import org.robotlegs.core.IReflector;
   
   public class PContext extends ContextBase implements IContext
   {
      
      protected var _injector:IInjector;
      
      protected var _reflector:IReflector;
      
      protected var _autoStartup:Boolean;
      
      protected var _commandMap:ICommandMap;
      
      public function PContext()
      {
         super();
      }
      
      public function startup() : void
      {
         dispatchEvent(new ContextEvent("startupComplete"));
      }
      
      public function shutdown() : void
      {
         dispatchEvent(new ContextEvent("shutdownComplete"));
      }
      
      protected function get injector() : IInjector
      {
         if(!_injector)
         {
            _injector = createInjector();
         }
         return _injector;
      }
      
      protected function set injector(param1:IInjector) : void
      {
         _injector = param1;
      }
      
      protected function get reflector() : IReflector
      {
         if(!_reflector)
         {
            _reflector = new SwiftSuspendersReflector();
         }
         return _reflector;
      }
      
      protected function set reflector(param1:IReflector) : void
      {
         _reflector = param1;
      }
      
      protected function get commandMap() : ICommandMap
      {
         if(!_commandMap)
         {
            _commandMap = new CommandMap(eventDispatcher,createChildInjector(),reflector);
         }
         return _commandMap;
      }
      
      protected function set commandMap(param1:ICommandMap) : void
      {
         _commandMap = param1;
      }
      
      protected function mapInjections() : void
      {
         injector.mapValue(IReflector,reflector);
         injector.mapValue(IInjector,injector);
         injector.mapValue(IEventDispatcher,eventDispatcher);
         injector.mapValue(ICommandMap,commandMap);
      }
      
      protected function createInjector() : IInjector
      {
         var _loc1_:IInjector = new SwiftSuspendersInjector();
         _loc1_.applicationDomain = getApplicationDomainFromContextView();
         return _loc1_;
      }
      
      protected function createChildInjector() : IInjector
      {
         return injector.createChild(getApplicationDomainFromContextView());
      }
      
      protected function getApplicationDomainFromContextView() : ApplicationDomain
      {
         return ApplicationDomain.currentDomain;
      }
   }
}

