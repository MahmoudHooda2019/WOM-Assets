package peak.logging
{
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.system.Worker;
   import peak.config.DocumentConfiguration;
   import peak.serialization.json.PJSON;
   
   public class ShippingLoggerTarget extends AbstractLoggerTarget implements LoggerTarget
   {
      
      private var _loginTime:String;
      
      private var _userId:String;
      
      private var _buffer:Vector.<String>;
      
      private var _shippingQueue:Vector.<String>;
      
      private var _shippingRequest:URLRequest;
      
      private var _shippingLoader:URLLoader;
      
      private var _currentBufferSize:Number;
      
      private var _maxBufferMessageCount:Number;
      
      private var _maxBufferSize:Number;
      
      public function ShippingLoggerTarget(param1:Number = 40, param2:Number = 32000)
      {
         super();
         _maxBufferMessageCount = param1;
         _maxBufferSize = param2;
         _buffer = new Vector.<String>(0);
         _shippingQueue = new Vector.<String>(0);
         _currentBufferSize = 0;
         initShippingLoader();
      }
      
      protected function initShippingLoader() : void
      {
         _shippingLoader = new URLLoader();
         _shippingLoader.addEventListener("complete",onShippingComplete);
         _shippingLoader.addEventListener("ioError",onShippingError);
         _shippingLoader.addEventListener("securityError",onShippingError);
      }
      
      protected function initShippingRequest(param1:DocumentConfiguration) : void
      {
         _shippingRequest = new URLRequest(param1.getParameter("logShippingUrl"));
         _shippingRequest.method = "POST";
      }
      
      [Inject]
      public function configure(param1:DocumentConfiguration) : void
      {
         _userId = param1.getParameter("user");
         _loginTime = param1.getParameter("loginTime");
         initShippingRequest(param1);
      }
      
      public function write(param1:String, param2:* = undefined) : void
      {
         var _temp_1:* = param1;
         var _loc6_:* = param2;
         var _loc4_:String = _temp_1;
         var _loc5_:String;
         var _loc3_:String = _loc5_ = (§§pop() && _loc4_.length > 0 ? _loc4_ : "") + (_loc6_ !== undefined ? " " + (_loc6_ is String ? _loc6_ : peak.serialization.json.PJSON.encode(_loc6_)) : "");
         if(_buffer.push(_loc3_) > _maxBufferMessageCount || (_currentBufferSize += _loc3_.length) >= _maxBufferSize)
         {
            flushBuffer();
         }
      }
      
      public function set userId(param1:String) : void
      {
         _userId = param1;
      }
      
      public function flushBuffer() : void
      {
         var _loc1_:uint = _shippingQueue.push(_buffer.join("\n"));
         _buffer.length = 0;
         _currentBufferSize = 0;
         if(_loc1_ == 1)
         {
            shipNext();
         }
      }
      
      protected function getShippingVariables() : URLVariables
      {
         var _loc1_:URLVariables = new URLVariables();
         _loc1_["uid"] = _userId || "UNKNOWN";
         _loc1_["login_time"] = _loginTime;
         _loc1_["message"] = _shippingQueue[0];
         _loc1_["env"] = 5;
         return _loc1_;
      }
      
      protected function shipNext() : void
      {
         if(!Worker.current.isPrimordial)
         {
            return;
         }
         _shippingRequest.data = getShippingVariables();
         try
         {
            _shippingLoader.load(_shippingRequest);
         }
         catch(e:Error)
         {
            log(LoggerContexts.INFRASTRUCTURE,"Error when shipping logs logs: " + _shippingRequest.url + " " + e.toString());
         }
      }
      
      protected function shippingComplete() : void
      {
         _shippingQueue.shift();
         if(_shippingQueue.length)
         {
            shipNext();
         }
      }
      
      protected function shippingError() : void
      {
         _shippingQueue.shift();
         if(_shippingQueue.length)
         {
            shipNext();
         }
      }
      
      private function onShippingComplete(param1:Event) : void
      {
         shippingComplete();
      }
      
      private function onShippingError(param1:ErrorEvent) : void
      {
         log(LoggerContexts.INFRASTRUCTURE,"ErrorEvent when shipping logs: " + _shippingRequest.url + " " + param1.toString());
         shippingError();
      }
   }
}

