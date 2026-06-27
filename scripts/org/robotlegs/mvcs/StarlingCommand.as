package org.robotlegs.mvcs
{
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import org.robotlegs.core.ICommandMap;
   import org.robotlegs.core.IInjector;
   import org.robotlegs.core.IStarlingMediatorMap;
   import starling.display.DisplayObjectContainer;
   
   public class StarlingCommand
   {
      
      [Inject]
      public var contextView:DisplayObjectContainer;
      
      [Inject]
      public var commandMap:ICommandMap;
      
      [Inject]
      public var eventDispatcher:IEventDispatcher;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var mediatorMap:IStarlingMediatorMap;
      
      public function StarlingCommand()
      {
         super();
      }
      
      public function execute() : void
      {
      }
      
      protected function dispatch(param1:Event) : Boolean
      {
         if(eventDispatcher.hasEventListener(param1.type))
         {
            return eventDispatcher.dispatchEvent(param1);
         }
         return false;
      }
   }
}

