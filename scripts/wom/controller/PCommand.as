package wom.controller
{
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import org.robotlegs.core.ICommandMap;
   import org.robotlegs.core.IInjector;
   
   public class PCommand
   {
      
      [Inject]
      public var commandMap:ICommandMap;
      
      [Inject]
      public var eventDispatcher:IEventDispatcher;
      
      [Inject]
      public var injector:IInjector;
      
      public function PCommand()
      {
         super();
      }
      
      protected function dispatch(param1:Event) : Boolean
      {
         if(eventDispatcher.hasEventListener(param1.type))
         {
            return eventDispatcher.dispatchEvent(param1);
         }
         return false;
      }
      
      public function execute() : void
      {
      }
   }
}

