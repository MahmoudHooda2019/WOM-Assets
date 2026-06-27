package org.robotlegs.mvcs
{
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.utils.getDefinitionByName;
   import org.robotlegs.base.MediatorBase;
   import org.robotlegs.base.StarlingEventMap;
   import org.robotlegs.core.IStarlingEventMap;
   import org.robotlegs.core.IStarlingMediatorMap;
   import starling.display.DisplayObjectContainer;
   import starling.events.Event;
   import starling.events.EventDispatcher;
   
   public class StarlingMediator extends MediatorBase
   {
      
      protected static var FeathersControlType:Class;
      
      protected static const feathersAvailable:Boolean = checkFeathers();
      
      [Inject]
      public var contextView:DisplayObjectContainer;
      
      [Inject]
      public var mediatorMap:IStarlingMediatorMap;
      
      protected var _eventDispatcher:IEventDispatcher;
      
      protected var _eventMap:IStarlingEventMap;
      
      public function StarlingMediator()
      {
         super();
      }
      
      protected static function checkFeathers() : Boolean
      {
         try
         {
            FeathersControlType = getDefinitionByName("feathers.core::IFeathersControl") as Class;
         }
         catch(error:Error)
         {
         }
         return FeathersControlType != null;
      }
      
      override public function preRegister() : void
      {
         removed = false;
         if(feathersAvailable && viewComponent is FeathersControlType && !viewComponent["isInitialized"])
         {
            EventDispatcher(viewComponent).addEventListener("initialize",onInitialize);
         }
         else
         {
            onRegister();
         }
      }
      
      override public function preRemove() : void
      {
         if(feathersAvailable && viewComponent is FeathersControlType)
         {
            EventDispatcher(viewComponent).removeEventListener("initialize",onInitialize);
         }
         if(_eventMap)
         {
            _eventMap.unmapListeners();
         }
         super.preRemove();
      }
      
      public function get eventDispatcher() : IEventDispatcher
      {
         return _eventDispatcher;
      }
      
      [Inject]
      public function set eventDispatcher(param1:IEventDispatcher) : void
      {
         _eventDispatcher = param1;
      }
      
      protected function get eventMap() : IStarlingEventMap
      {
         return _eventMap || (_eventMap = new StarlingEventMap(eventDispatcher));
      }
      
      protected function dispatch(param1:flash.events.Event) : Boolean
      {
         if(eventDispatcher.hasEventListener(param1.type))
         {
            return eventDispatcher.dispatchEvent(param1);
         }
         return false;
      }
      
      protected function addViewListener(param1:String, param2:Function, param3:Class = null) : void
      {
         eventMap.mapStarlingListener(EventDispatcher(viewComponent),param1,param2,param3);
      }
      
      protected function removeViewListener(param1:String, param2:Function, param3:Class = null) : void
      {
         eventMap.unmapStarlingListener(EventDispatcher(viewComponent),param1,param2,param3);
      }
      
      protected function addContextListener(param1:String, param2:Function, param3:Class = null, param4:Boolean = false, param5:int = 0, param6:Boolean = true) : void
      {
         eventMap.mapListener(eventDispatcher,param1,param2,param3,param4,param5,param6);
      }
      
      protected function removeContextListener(param1:String, param2:Function, param3:Class = null, param4:Boolean = false) : void
      {
         eventMap.unmapListener(eventDispatcher,param1,param2,param3,param4);
      }
      
      protected function onInitialize(param1:starling.events.Event) : void
      {
         param1.target.removeEventListener("initialize",onInitialize);
         if(!removed)
         {
            onRegister();
         }
      }
   }
}

