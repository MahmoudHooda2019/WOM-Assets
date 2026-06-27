package org.robotlegs.base
{
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import org.robotlegs.core.IInjector;
   import org.robotlegs.core.IMediator;
   import org.robotlegs.core.IReflector;
   import org.robotlegs.core.IStarlingMediatorMap;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   import starling.events.Event;
   
   public class StarlingMediatorMap extends StarlingViewMapBase implements IStarlingMediatorMap
   {
      
      protected var mediatorByView:Dictionary;
      
      protected var mappingConfigByView:Dictionary;
      
      protected var mappingConfigByViewClassName:Dictionary;
      
      protected var reflector:IReflector;
      
      public function StarlingMediatorMap(param1:DisplayObjectContainer, param2:IInjector, param3:IReflector)
      {
         super(param1,param2);
         this.reflector = param3;
         this.mediatorByView = new Dictionary(true);
         this.mappingConfigByView = new Dictionary(true);
         this.mappingConfigByViewClassName = new Dictionary(false);
      }
      
      public function mapView(param1:*, param2:Class, param3:* = null, param4:Boolean = true, param5:Boolean = true) : void
      {
         var _loc6_:String = reflector.getFQCN(param1);
         if(mappingConfigByViewClassName[_loc6_] != null)
         {
            throw new ContextError("Mediator Class has already been mapped to a View Class in this context - " + param2);
         }
         if(reflector.classExtendsOrImplements(param2,IMediator) == false)
         {
            throw new ContextError("Mediator Class does not implement IMediator - " + param2);
         }
         var _loc7_:MappingConfig = new MappingConfig();
         _loc7_.mediatorClass = param2;
         _loc7_.autoCreate = param4;
         _loc7_.autoRemove = param5;
         if(param3)
         {
            if(param3 is Array)
            {
               _loc7_.typedViewClasses = (param3 as Array).concat();
            }
            else if(param3 is Class)
            {
               _loc7_.typedViewClasses = [param3];
            }
         }
         else if(param1 is Class)
         {
            _loc7_.typedViewClasses = [param1];
         }
         mappingConfigByViewClassName[_loc6_] = _loc7_;
         if(param4 || param5)
         {
            viewListenerCount = viewListenerCount + 1;
            if(viewListenerCount == 1)
            {
               addListeners(contextView);
            }
         }
         if(param4 && contextView && _loc6_ == getQualifiedClassName(contextView))
         {
            createMediatorUsing(contextView,_loc6_,_loc7_);
         }
      }
      
      public function unmapView(param1:*) : void
      {
         var _loc2_:String = reflector.getFQCN(param1);
         var _loc3_:MappingConfig = mappingConfigByViewClassName[_loc2_];
         if(_loc3_ && (_loc3_.autoCreate || _loc3_.autoRemove))
         {
            viewListenerCount = viewListenerCount - 1;
            if(viewListenerCount == 0)
            {
               removeListeners(contextView);
            }
         }
         delete mappingConfigByViewClassName[_loc2_];
      }
      
      public function createMediator(param1:Object) : IMediator
      {
         return createMediatorUsing(param1);
      }
      
      public function registerMediator(param1:Object, param2:IMediator) : void
      {
         var _loc3_:Class = reflector.getClass(param2);
         injector.hasMapping(_loc3_) && injector.unmap(_loc3_);
         injector.mapValue(reflector.getClass(param2),param2);
         mediatorByView[param1] = param2;
         mappingConfigByView[param1] = mappingConfigByViewClassName[getQualifiedClassName(param1)];
         param2.setViewComponent(param1);
         param2.preRegister();
      }
      
      public function removeMediator(param1:IMediator) : IMediator
      {
         var _loc2_:Object = null;
         if(param1)
         {
            _loc2_ = param1.getViewComponent();
            delete mediatorByView[_loc2_];
            delete mappingConfigByView[_loc2_];
            param1.preRemove();
            param1.setViewComponent(null);
            injector.unmap(reflector.getClass(param1));
         }
         return param1;
      }
      
      public function removeMediatorByView(param1:Object) : IMediator
      {
         return removeMediator(retrieveMediator(param1));
      }
      
      public function retrieveMediator(param1:Object) : IMediator
      {
         return mediatorByView[param1];
      }
      
      public function hasMapping(param1:*) : Boolean
      {
         var _loc2_:String = reflector.getFQCN(param1);
         return mappingConfigByViewClassName[_loc2_] != null;
      }
      
      public function hasMediatorForView(param1:Object) : Boolean
      {
         return mediatorByView[param1] != null;
      }
      
      public function hasMediator(param1:IMediator) : Boolean
      {
         for each(var _loc2_ in mediatorByView)
         {
            if(_loc2_ == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      override protected function addListeners(param1:DisplayObjectContainer) : void
      {
         if(param1 && enabled)
         {
            param1.addEventListener("added",onViewAdded);
            param1.addEventListener("removed",onViewRemoved);
            param1.addEventListener("addedToStage",onViewAdded);
            param1.addEventListener("removedFromStage",onViewRemoved);
         }
      }
      
      override protected function removeListeners(param1:DisplayObjectContainer) : void
      {
         if(param1)
         {
            param1.removeEventListener("added",onViewAdded);
            param1.removeEventListener("removed",onViewRemoved);
            param1.removeEventListener("addedToStage",onViewAdded);
            param1.removeEventListener("removedFromStage",onViewRemoved);
         }
      }
      
      protected function addView(param1:DisplayObject) : void
      {
         var _loc3_:int = 0;
         var _loc7_:int = 0;
         var _loc2_:DisplayObject = null;
         var _loc4_:String = getQualifiedClassName(param1);
         var _loc6_:MappingConfig = mappingConfigByViewClassName[_loc4_];
         if(_loc6_ && _loc6_.autoCreate)
         {
            createMediatorUsing(param1,_loc4_,_loc6_);
         }
         var _loc5_:DisplayObjectContainer = param1 as DisplayObjectContainer;
         if(_loc5_)
         {
            _loc3_ = _loc5_.numChildren;
            _loc7_ = 0;
            while(_loc7_ < _loc3_)
            {
               _loc2_ = _loc5_.getChildAt(_loc7_);
               addView(_loc2_);
               _loc7_++;
            }
         }
      }
      
      protected function removeView(param1:DisplayObject) : void
      {
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:DisplayObject = null;
         var _loc5_:MappingConfig = mappingConfigByView[param1];
         if(_loc5_ && _loc5_.autoRemove)
         {
            removeMediatorByView(param1);
         }
         var _loc4_:DisplayObjectContainer = param1 as DisplayObjectContainer;
         if(_loc4_)
         {
            _loc3_ = _loc4_.numChildren;
            _loc6_ = 0;
            while(_loc6_ < _loc3_)
            {
               _loc2_ = _loc4_.getChildAt(_loc6_);
               removeView(_loc2_);
               _loc6_++;
            }
         }
      }
      
      override protected function onViewAdded(param1:Event) : void
      {
         var _loc2_:DisplayObject = DisplayObject(param1.target);
         addView(_loc2_);
      }
      
      protected function createMediatorUsing(param1:Object, param2:String = "", param3:MappingConfig = null) : IMediator
      {
         var _loc5_:IMediator = mediatorByView[param1];
         if(_loc5_ == null)
         {
            if(!param2)
            {
               param2 = getQualifiedClassName(param1);
            }
            if(!param3)
            {
               param3 = mappingConfigByViewClassName[param2];
            }
            if(param3)
            {
               for each(var _loc4_ in param3.typedViewClasses)
               {
                  injector.mapValue(_loc4_,param1);
               }
               _loc5_ = injector.instantiate(param3.mediatorClass);
               for each(var _loc6_ in param3.typedViewClasses)
               {
                  injector.unmap(_loc6_);
               }
               registerMediator(param1,_loc5_);
            }
         }
         return _loc5_;
      }
      
      protected function onViewRemoved(param1:Event) : void
      {
         var _loc2_:DisplayObject = DisplayObject(param1.target);
         removeView(_loc2_);
      }
      
      public function listen(param1:DisplayObjectContainer) : void
      {
         addListeners(param1);
      }
   }
}

class MappingConfig
{
   
   public var mediatorClass:Class;
   
   public var typedViewClasses:Array;
   
   public var autoCreate:Boolean;
   
   public var autoRemove:Boolean;
   
   public function MappingConfig()
   {
      super();
   }
}
