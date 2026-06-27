package org.robotlegs.mvcs
{
   import org.robotlegs.base.ContextError;
   import org.robotlegs.base.StarlingEventMap;
   import org.robotlegs.base.StarlingMediatorMap;
   import org.robotlegs.base.StarlingViewMap;
   import org.robotlegs.core.IEventMap;
   import org.robotlegs.core.IStarlingEventMap;
   import org.robotlegs.core.IStarlingMediatorMap;
   import org.robotlegs.core.IStarlingViewMap;
   import starling.display.DisplayObjectContainer;
   import starling.events.Event;
   import wom.PContext;
   
   public class StarlingContext extends PContext
   {
      
      protected var _contextView:DisplayObjectContainer;
      
      protected var _mediatorMap:IStarlingMediatorMap;
      
      protected var _viewMap:IStarlingViewMap;
      
      protected var _eventMap:IStarlingEventMap;
      
      public function StarlingContext(param1:DisplayObjectContainer = null, param2:Boolean = true)
      {
         super();
         _contextView = param1;
         _autoStartup = param2;
         if(_contextView)
         {
            mapInjections();
            checkAutoStartup();
         }
      }
      
      public function get contextView() : DisplayObjectContainer
      {
         return _contextView;
      }
      
      public function set contextView(param1:DisplayObjectContainer) : void
      {
         if(_contextView)
         {
            throw new ContextError("Context contextView must only be set once");
         }
         if(param1)
         {
            _contextView = param1;
            mapInjections();
            checkAutoStartup();
         }
      }
      
      protected function get mediatorMap() : IStarlingMediatorMap
      {
         if(!_mediatorMap)
         {
            _mediatorMap = new StarlingMediatorMap(contextView,createChildInjector(),reflector);
         }
         return _mediatorMap;
      }
      
      protected function set mediatorMap(param1:IStarlingMediatorMap) : void
      {
         _mediatorMap = param1;
      }
      
      protected function get viewMap() : IStarlingViewMap
      {
         if(!_viewMap)
         {
            _viewMap = new StarlingViewMap(contextView,injector);
         }
         return _viewMap;
      }
      
      protected function set viewMap(param1:IStarlingViewMap) : void
      {
         _viewMap = param1;
      }
      
      protected function get eventMap() : IStarlingEventMap
      {
         if(_eventMap == null)
         {
            _eventMap = new StarlingEventMap(eventDispatcher);
         }
         return _eventMap;
      }
      
      protected function set eventMap(param1:IStarlingEventMap) : void
      {
         _eventMap = param1;
      }
      
      override protected function mapInjections() : void
      {
         super.mapInjections();
         injector.mapValue(DisplayObjectContainer,contextView);
         injector.mapValue(IStarlingMediatorMap,mediatorMap);
         injector.mapValue(IStarlingViewMap,viewMap);
         injector.mapValue(IEventMap,eventMap);
         injector.mapValue(IStarlingEventMap,eventMap);
      }
      
      protected function checkAutoStartup() : void
      {
         if(_autoStartup && contextView)
         {
            contextView.stage ? startup() : contextView.addEventListener("addedToStage",onAddedToStage);
         }
      }
      
      protected function onAddedToStage(param1:Event) : void
      {
         contextView.removeEventListener("addedToStage",onAddedToStage);
         startup();
      }
   }
}

