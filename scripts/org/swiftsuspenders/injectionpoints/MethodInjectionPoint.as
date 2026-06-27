package org.swiftsuspenders.injectionpoints
{
   import flash.utils.getQualifiedClassName;
   import org.swiftsuspenders.InjectionConfig;
   import org.swiftsuspenders.Injector;
   import org.swiftsuspenders.InjectorError;
   
   public class MethodInjectionPoint extends InjectionPoint
   {
      
      protected var methodName:String;
      
      protected var _parameterInjectionConfigs:Array;
      
      protected var requiredParameters:int = 0;
      
      public function MethodInjectionPoint(param1:XML, param2:Injector = null)
      {
         super(param1,param2);
      }
      
      override public function applyInjection(param1:Object, param2:Injector) : Object
      {
         var _loc3_:Array = this.gatherParameterValues(param1,param2);
         var _loc4_:Function = param1[this.methodName];
         _loc4_.apply(param1,_loc3_);
         return param1;
      }
      
      override protected function initializeInjection(param1:XML) : void
      {
         var nameArgs:XMLList = null;
         var methodNode:XML = null;
         var node:XML = param1;
         nameArgs = node.arg.(@key == "name");
         methodNode = node.parent();
         this.methodName = methodNode.@name.toString();
         this.gatherParameters(methodNode,nameArgs);
      }
      
      protected function gatherParameters(param1:XML, param2:XMLList) : void
      {
         var _loc4_:XML = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         this._parameterInjectionConfigs = [];
         var _loc3_:* = 0;
         for each(_loc4_ in param1.parameter)
         {
            _loc5_ = "";
            if(param2[_loc3_])
            {
               _loc5_ = param2[_loc3_].@value.toString();
            }
            _loc6_ = _loc4_.@type.toString();
            if(_loc6_ == "*")
            {
               if(_loc4_.@optional.toString() == "false")
               {
                  throw new InjectorError("Error in method definition of injectee. " + "Required parameters can\'t have type \"*\".");
               }
               _loc6_ = null;
            }
            this._parameterInjectionConfigs.push(new ParameterInjectionConfig(_loc6_,_loc5_));
            if(_loc4_.@optional.toString() == "false")
            {
               ++this.requiredParameters;
            }
            _loc3_++;
         }
      }
      
      protected function gatherParameterValues(param1:Object, param2:Injector) : Array
      {
         var _loc6_:ParameterInjectionConfig = null;
         var _loc7_:InjectionConfig = null;
         var _loc8_:Object = null;
         var _loc3_:Array = [];
         var _loc4_:int = int(this._parameterInjectionConfigs.length);
         var _loc5_:* = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = this._parameterInjectionConfigs[_loc5_];
            _loc7_ = param2.getMapping(Class(param2.getApplicationDomain().getDefinition(_loc6_.typeName)),_loc6_.injectionName);
            _loc8_ = _loc7_.getResponse(param2);
            if(_loc8_ == null)
            {
               if(_loc5_ < this.requiredParameters)
               {
                  throw new InjectorError("Injector is missing a rule to handle injection into target " + param1 + ". Target dependency: " + getQualifiedClassName(_loc7_.request) + ", method: " + this.methodName + ", parameter: " + (_loc5_ + 1));
               }
               break;
            }
            _loc3_[_loc5_] = _loc8_;
            _loc5_++;
         }
         return _loc3_;
      }
   }
}

final class ParameterInjectionConfig
{
   
   public var typeName:String;
   
   public var injectionName:String;
   
   public function ParameterInjectionConfig(param1:String, param2:String)
   {
      super();
      this.typeName = param1;
      this.injectionName = param2;
   }
}
