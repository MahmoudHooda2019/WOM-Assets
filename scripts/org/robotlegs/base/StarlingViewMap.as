package org.robotlegs.base
{
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import org.robotlegs.core.IInjector;
   import org.robotlegs.core.IStarlingViewMap;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   import starling.events.Event;
   
   public class StarlingViewMap extends StarlingViewMapBase implements IStarlingViewMap
   {
      
      protected var mappedPackages:Array;
      
      protected var mappedTypes:Dictionary;
      
      protected var injectedViews:Dictionary;
      
      public function StarlingViewMap(param1:DisplayObjectContainer, param2:IInjector)
      {
         super(param1,param2);
         this.mappedPackages = [];
         this.mappedTypes = new Dictionary(false);
         this.injectedViews = new Dictionary(true);
      }
      
      public function mapPackage(param1:String) : void
      {
         if(mappedPackages.indexOf(param1) == -1)
         {
            mappedPackages.push(param1);
            viewListenerCount = viewListenerCount + 1;
            if(viewListenerCount == 1)
            {
               addListeners(_contextView);
            }
         }
      }
      
      public function unmapPackage(param1:String) : void
      {
         var _loc2_:int = mappedPackages.indexOf(param1);
         if(_loc2_ > -1)
         {
            mappedPackages.splice(_loc2_,1);
            viewListenerCount = viewListenerCount - 1;
            if(viewListenerCount == 0)
            {
               removeListeners(_contextView);
            }
         }
      }
      
      public function mapType(param1:Class) : void
      {
         if(mappedTypes[param1])
         {
            return;
         }
         mappedTypes[param1] = param1;
         viewListenerCount = viewListenerCount + 1;
         if(viewListenerCount == 1)
         {
            addListeners(_contextView);
         }
         if(contextView && contextView is param1)
         {
            injectInto(contextView);
         }
      }
      
      public function unmapType(param1:Class) : void
      {
         var _loc2_:Class = mappedTypes[param1];
         delete mappedTypes[param1];
         if(_loc2_)
         {
            viewListenerCount = viewListenerCount - 1;
            if(viewListenerCount == 0)
            {
               removeListeners(_contextView);
            }
         }
      }
      
      public function hasType(param1:Class) : Boolean
      {
         return mappedTypes[param1] != null;
      }
      
      public function hasPackage(param1:String) : Boolean
      {
         return mappedPackages.indexOf(param1) > -1;
      }
      
      override protected function addListeners(param1:DisplayObjectContainer) : void
      {
         if(param1 && enabled)
         {
            param1.addEventListener("added",onViewAdded);
         }
      }
      
      override protected function removeListeners(param1:DisplayObjectContainer) : void
      {
         if(param1)
         {
            param1.removeEventListener("added",onViewAdded);
         }
      }
      
      override protected function onViewAdded(param1:Event) : void
      {
         var _loc4_:String = null;
         var _loc7_:int = 0;
         var _loc2_:String = null;
         var _loc3_:DisplayObject = DisplayObject(param1.target);
         if(injectedViews[_loc3_])
         {
            return;
         }
         for each(var _loc6_ in mappedTypes)
         {
            if(_loc3_ is _loc6_)
            {
               injectInto(_loc3_);
               return;
            }
         }
         var _loc5_:int = int(mappedPackages.length);
         if(_loc5_ > 0)
         {
            _loc4_ = getQualifiedClassName(_loc3_);
            _loc7_ = 0;
            while(_loc7_ < _loc5_)
            {
               _loc2_ = mappedPackages[_loc7_];
               if(_loc4_.indexOf(_loc2_) == 0)
               {
                  injectInto(_loc3_);
                  return;
               }
               _loc7_++;
            }
         }
      }
      
      protected function injectInto(param1:DisplayObject) : void
      {
         injector.injectInto(param1);
         injectedViews[param1] = true;
      }
   }
}

