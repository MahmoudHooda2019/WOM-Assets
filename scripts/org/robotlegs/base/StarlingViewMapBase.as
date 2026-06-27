package org.robotlegs.base
{
   import org.robotlegs.core.IInjector;
   import starling.display.DisplayObjectContainer;
   import starling.events.Event;
   
   public class StarlingViewMapBase
   {
      
      protected var _enabled:Boolean = true;
      
      protected var _contextView:DisplayObjectContainer;
      
      protected var injector:IInjector;
      
      protected var useCapture:Boolean;
      
      protected var viewListenerCount:uint;
      
      public function StarlingViewMapBase(param1:DisplayObjectContainer, param2:IInjector)
      {
         super();
         this.injector = param2;
         this.useCapture = true;
         this.contextView = param1;
      }
      
      public function get contextView() : DisplayObjectContainer
      {
         return _contextView;
      }
      
      public function set contextView(param1:DisplayObjectContainer) : void
      {
         if(param1 != _contextView)
         {
            removeListeners(_contextView);
            _contextView = param1;
            if(viewListenerCount > 0)
            {
               addListeners(_contextView);
            }
         }
      }
      
      public function get enabled() : Boolean
      {
         return _enabled;
      }
      
      public function set enabled(param1:Boolean) : void
      {
         if(param1 != _enabled)
         {
            removeListeners(_contextView);
            _enabled = param1;
            if(viewListenerCount > 0)
            {
               addListeners(_contextView);
            }
         }
      }
      
      protected function addListeners(param1:DisplayObjectContainer) : void
      {
      }
      
      protected function removeListeners(param1:DisplayObjectContainer) : void
      {
      }
      
      protected function onViewAdded(param1:Event) : void
      {
      }
   }
}

