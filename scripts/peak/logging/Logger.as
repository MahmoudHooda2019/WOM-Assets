package peak.logging
{
   import flash.system.Capabilities;
   import peak.config.DocumentConfiguration;
   import peak.util.DateTimeUtil;
   
   public class Logger
   {
      
      public static const INSTANCE:Logger = new Logger();
      
      private const MAX_CALLER_LENGTH:Number = 35;
      
      private const MAX_TIME_LENGTH:Number = 19;
      
      private const MAX_CONTEXT_LENGTH:Number = 13;
      
      private const VERBOSE_WRITING_ENABLED:Boolean = false;
      
      private var _configuration:DocumentConfiguration;
      
      private var _enabledContexts:Vector.<LoggerContext>;
      
      private var _targets:Vector.<LoggerTarget>;
      
      public function Logger()
      {
         super();
         reset();
      }
      
      public function reset() : void
      {
         _targets = new Vector.<LoggerTarget>();
         _enabledContexts = new Vector.<LoggerContext>();
         _configuration = null;
      }
      
      [Inject]
      public function configure(param1:DocumentConfiguration) : void
      {
         _configuration = param1;
      }
      
      public function addTarget(param1:LoggerTarget) : void
      {
         if(!(param1 in _targets))
         {
            _targets.push(param1);
         }
         else
         {
            log(LoggerContexts.INFRASTRUCTURE,"Target already exists!");
         }
      }
      
      public function removeTarget(param1:LoggerTarget) : Boolean
      {
         var _loc2_:Boolean = false;
         if(param1 in _targets)
         {
            _targets.splice(_targets.lastIndexOf(param1),1);
            _loc2_ = true;
         }
         else
         {
            log(LoggerContexts.INFRASTRUCTURE,"Target function could not be found!");
         }
         return _loc2_;
      }
      
      public function enableContext(param1:LoggerContext) : void
      {
         if(!(param1 in _enabledContexts))
         {
            _enabledContexts.push(param1);
         }
         else
         {
            log(LoggerContexts.INFRASTRUCTURE,"Context already exists!");
         }
      }
      
      public function disableContext(param1:LoggerContext) : void
      {
         if(param1 in _enabledContexts)
         {
            _targets.splice(_enabledContexts.lastIndexOf(param1),1);
         }
         else
         {
            log(LoggerContexts.INFRASTRUCTURE,"Context could not be found!");
         }
      }
      
      public function log(param1:LoggerContext, param2:String, param3:* = undefined) : void
      {
         var _loc4_:String = null;
         var _loc7_:String = null;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         if(checkContext(param1))
         {
            _loc4_ = adjustLength(DateTimeUtil.getUTCFormattedTimeAndDateWithMillisecondsFromDate(new Date(),"",":"," ","."),19);
            _loc7_ = adjustLength(param1.contextMessage,13);
            _loc5_ = _loc4_;
            if(Capabilities.isDebugger)
            {
               _loc5_ += " [" + adjustLength(callerClassAndMethod(),35,true) + "]";
            }
            _loc5_ += " [" + _loc7_ + "] " + param2;
            _loc6_ = 0;
            while(_loc6_ < _targets.length)
            {
               _targets[_loc6_].write(_loc5_,param3);
               _loc6_++;
            }
         }
      }
      
      private function adjustLength(param1:String, param2:Number, param3:Boolean = false) : String
      {
         var _loc4_:int = 0;
         var _loc5_:String = param1;
         if(param1.length > param2)
         {
            _loc5_ = param1.substring(param1.length - param2,param1.length);
         }
         else
         {
            _loc4_ = 0;
            while(_loc4_ < param2 - param1.length)
            {
               _loc5_ = param3 ? " " + _loc5_ : _loc5_ + " ";
               _loc4_++;
            }
         }
         return _loc5_;
      }
      
      private function checkContext(param1:LoggerContext) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:Boolean = false;
         _loc3_ = 0;
         while(_loc3_ < _enabledContexts.length && !_loc2_)
         {
            _loc2_ = (_enabledContexts[_loc3_].contextId & param1.contextId) != 0;
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function callerClassAndMethod(param1:Boolean = true) : String
      {
         var _loc5_:Array = null;
         var _loc2_:LoggerStackData = null;
         var _loc4_:String = null;
         var _loc3_:String = "";
         var _loc6_:String = new Error().getStackTrace();
         if(_loc6_ != null)
         {
            _loc5_ = _loc6_.split("\n");
            if(_loc5_ != null && _loc5_.length >= 4)
            {
               _loc2_ = new LoggerStackData(_loc5_[4]);
               _loc4_ = _loc2_.className;
               if(param1)
               {
                  _loc4_ = _loc4_.replace(/([\w])[a-z]+(?=[A-Z0-9_])/g,"$1");
               }
               _loc3_ = _loc4_ + "." + _loc2_.methodName + ":" + _loc2_.lineNumber;
            }
         }
         return _loc3_;
      }
   }
}

