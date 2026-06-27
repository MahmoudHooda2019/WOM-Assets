package mx.validators
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mx.core.IMXMLObject;
   import mx.core.mx_internal;
   import mx.events.ValidationResultEvent;
   import mx.resources.IResourceManager;
   import mx.resources.ResourceManager;
   
   use namespace mx_internal;
   
   public class Validator extends EventDispatcher implements IMXMLObject, IValidator
   {
      
      mx_internal static const VERSION:String = "4.10.0.0";
      
      protected static const ROMAN_LETTERS:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
      
      protected static const DECIMAL_DIGITS:String = "0123456789";
      
      private var document:Object;
      
      private var _enabled:Boolean = true;
      
      private var _listener:Object;
      
      private var _property:String;
      
      public var required:Boolean = true;
      
      private var _resourceManager:IResourceManager = ResourceManager.getInstance();
      
      private var _source:Object;
      
      protected var subFields:Array = [];
      
      private var _trigger:IEventDispatcher;
      
      private var _triggerEvent:String = "valueCommit";
      
      private var _requiredFieldError:String;
      
      private var requiredFieldErrorOverride:String;
      
      public function Validator()
      {
         super();
         this.resourceManager.addEventListener(Event.CHANGE,this.resourceManager_changeHandler,false,0,true);
         this.resourcesChanged();
      }
      
      public static function validateAll(param1:Array) : Array
      {
         var _loc5_:IValidator = null;
         var _loc6_:ValidationResultEvent = null;
         var _loc2_:Array = [];
         var _loc3_:int = int(param1.length);
         var _loc4_:* = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = param1[_loc4_] as IValidator;
            if((Boolean(_loc5_)) && _loc5_.enabled)
            {
               _loc6_ = _loc5_.validate();
               if(_loc6_.type != ValidationResultEvent.VALID)
               {
                  _loc2_.push(_loc6_);
               }
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      private static function findObjectFromString(param1:Object, param2:String) : Object
      {
         var resourceManager:IResourceManager = null;
         var message:String = null;
         var doc:Object = param1;
         var value:String = param2;
         var obj:Object = doc;
         var parts:Array = value.split(".");
         var n:int = int(parts.length);
         var i:int = 0;
         while(i < n)
         {
            try
            {
               obj = obj[parts[i]];
               if(obj == null)
               {
               }
            }
            catch(error:Error)
            {
               if(error is TypeError && error.message.indexOf("null has no properties") != -1)
               {
                  resourceManager = ResourceManager.getInstance();
                  message = resourceManager.getString("validators","fieldNotFound",[value]);
                  throw new Error(message);
               }
               throw error;
            }
            i++;
         }
         return obj;
      }
      
      private static function trimString(param1:String) : String
      {
         var _loc2_:* = 0;
         while(param1.indexOf(" ",_loc2_) == _loc2_)
         {
            _loc2_++;
         }
         var _loc3_:* = int(param1.length - 1);
         while(param1.lastIndexOf(" ",_loc3_) == _loc3_)
         {
            _loc3_--;
         }
         return _loc3_ >= _loc2_ ? param1.slice(_loc2_,_loc3_ + 1) : "";
      }
      
      protected function get actualTrigger() : IEventDispatcher
      {
         if(this._trigger)
         {
            return this._trigger;
         }
         if(this._source)
         {
            return this._source as IEventDispatcher;
         }
         return null;
      }
      
      protected function get actualListeners() : Array
      {
         var _loc1_:Array = [];
         if(this._listener)
         {
            _loc1_.push(this._listener);
         }
         else if(this._source)
         {
            _loc1_.push(this._source);
         }
         return _loc1_;
      }
      
      public function get enabled() : Boolean
      {
         return this._enabled;
      }
      
      public function set enabled(param1:Boolean) : void
      {
         this._enabled = param1;
      }
      
      public function get listener() : Object
      {
         return this._listener;
      }
      
      public function set listener(param1:Object) : void
      {
         this.removeListenerHandler();
         this._listener = param1;
         this.addListenerHandler();
      }
      
      public function get property() : String
      {
         return this._property;
      }
      
      public function set property(param1:String) : void
      {
         this._property = param1;
      }
      
      [Bindable("unused")]
      protected function get resourceManager() : IResourceManager
      {
         return this._resourceManager;
      }
      
      public function get source() : Object
      {
         return this._source;
      }
      
      public function set source(param1:Object) : void
      {
         var _loc2_:String = null;
         if(this._source == param1)
         {
            return;
         }
         if(param1 is String)
         {
            _loc2_ = this.resourceManager.getString("validators","SAttribute",[param1]);
            throw new Error(_loc2_);
         }
         this.removeTriggerHandler();
         this.removeListenerHandler();
         this._source = param1;
         this.addTriggerHandler();
         this.addListenerHandler();
      }
      
      public function get trigger() : IEventDispatcher
      {
         return this._trigger;
      }
      
      public function set trigger(param1:IEventDispatcher) : void
      {
         this.removeTriggerHandler();
         this._trigger = param1;
         this.addTriggerHandler();
      }
      
      public function get triggerEvent() : String
      {
         return this._triggerEvent;
      }
      
      public function set triggerEvent(param1:String) : void
      {
         if(this._triggerEvent == param1)
         {
            return;
         }
         this.removeTriggerHandler();
         this._triggerEvent = param1;
         this.addTriggerHandler();
      }
      
      public function get requiredFieldError() : String
      {
         return this._requiredFieldError;
      }
      
      public function set requiredFieldError(param1:String) : void
      {
         this.requiredFieldErrorOverride = param1;
         this._requiredFieldError = param1 != null ? param1 : this.resourceManager.getString("validators","requiredFieldError");
      }
      
      public function initialized(param1:Object, param2:String) : void
      {
         this.document = param1;
      }
      
      protected function resourcesChanged() : void
      {
         this.requiredFieldError = this.requiredFieldErrorOverride;
      }
      
      private function addTriggerHandler() : void
      {
         if(this.actualTrigger)
         {
            this.actualTrigger.addEventListener(this._triggerEvent,this.triggerHandler);
         }
      }
      
      private function removeTriggerHandler() : void
      {
         if(this.actualTrigger)
         {
            this.actualTrigger.removeEventListener(this._triggerEvent,this.triggerHandler);
         }
      }
      
      protected function addListenerHandler() : void
      {
         var _loc1_:Object = null;
         var _loc2_:Array = this.actualListeners;
         var _loc3_:int = int(_loc2_.length);
         var _loc4_:* = 0;
         while(_loc4_ < _loc3_)
         {
            _loc1_ = _loc2_[_loc4_];
            if(_loc1_ is IValidatorListener)
            {
               addEventListener(ValidationResultEvent.VALID,IValidatorListener(_loc1_).validationResultHandler);
               addEventListener(ValidationResultEvent.INVALID,IValidatorListener(_loc1_).validationResultHandler);
            }
            _loc4_++;
         }
      }
      
      protected function removeListenerHandler() : void
      {
         var _loc1_:Object = null;
         var _loc2_:Array = this.actualListeners;
         var _loc3_:int = int(_loc2_.length);
         var _loc4_:* = 0;
         while(_loc4_ < _loc3_)
         {
            _loc1_ = _loc2_[_loc4_];
            if(_loc1_ is IValidatorListener)
            {
               removeEventListener(ValidationResultEvent.VALID,IValidatorListener(_loc1_).validationResultHandler);
               removeEventListener(ValidationResultEvent.INVALID,IValidatorListener(_loc1_).validationResultHandler);
            }
            _loc4_++;
         }
      }
      
      protected function isRealValue(param1:Object) : Boolean
      {
         return param1 != null;
      }
      
      public function validate(param1:Object = null, param2:Boolean = false) : ValidationResultEvent
      {
         var _loc3_:ValidationResultEvent = null;
         if(param1 == null)
         {
            param1 = this.getValueFromSource();
         }
         if(this.isRealValue(param1) || this.required)
         {
            return this.processValidation(param1,param2);
         }
         _loc3_ = new ValidationResultEvent(ValidationResultEvent.VALID);
         if(!param2 && this._enabled)
         {
            dispatchEvent(_loc3_);
         }
         return _loc3_;
      }
      
      protected function getValueFromSource() : Object
      {
         var _loc1_:String = null;
         if(Boolean(this._source) && Boolean(this._property))
         {
            return this._source[this._property];
         }
         if(!this._source && Boolean(this._property))
         {
            _loc1_ = this.resourceManager.getString("validators","SAttributeMissing");
            throw new Error(_loc1_);
         }
         if(Boolean(this._source) && !this._property)
         {
            _loc1_ = this.resourceManager.getString("validators","PAttributeMissing");
            throw new Error(_loc1_);
         }
         return null;
      }
      
      private function processValidation(param1:Object, param2:Boolean) : ValidationResultEvent
      {
         var _loc3_:ValidationResultEvent = null;
         var _loc4_:Array = null;
         if(this._enabled)
         {
            _loc4_ = this.doValidation(param1);
            _loc3_ = this.handleResults(_loc4_);
         }
         else
         {
            param2 = true;
         }
         if(!param2)
         {
            dispatchEvent(_loc3_);
         }
         return _loc3_;
      }
      
      protected function doValidation(param1:Object) : Array
      {
         var _loc2_:Array = [];
         var _loc3_:ValidationResult = this.validateRequired(param1);
         if(_loc3_)
         {
            _loc2_.push(_loc3_);
         }
         return _loc2_;
      }
      
      private function validateRequired(param1:Object) : ValidationResult
      {
         var _loc2_:String = null;
         if(this.required)
         {
            _loc2_ = param1 != null ? String(param1) : "";
            _loc2_ = trimString(_loc2_);
            if(_loc2_.length == 0)
            {
               return new ValidationResult(true,"","requiredField",this.requiredFieldError);
            }
         }
         return null;
      }
      
      protected function handleResults(param1:Array) : ValidationResultEvent
      {
         var _loc2_:ValidationResultEvent = null;
         var _loc3_:Object = null;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:* = 0;
         if(param1.length > 0)
         {
            _loc2_ = new ValidationResultEvent(ValidationResultEvent.INVALID);
            _loc2_.results = param1;
            if(this.subFields.length > 0)
            {
               _loc3_ = {};
               _loc5_ = int(param1.length);
               _loc6_ = 0;
               while(_loc6_ < _loc5_)
               {
                  _loc4_ = param1[_loc6_].subField;
                  if(_loc4_)
                  {
                     _loc3_[_loc4_] = true;
                  }
                  _loc6_++;
               }
               _loc5_ = int(this.subFields.length);
               _loc6_ = 0;
               while(_loc6_ < _loc5_)
               {
                  if(!_loc3_[this.subFields[_loc6_]])
                  {
                     param1.push(new ValidationResult(false,this.subFields[_loc6_]));
                  }
                  _loc6_++;
               }
            }
         }
         else
         {
            _loc2_ = new ValidationResultEvent(ValidationResultEvent.VALID);
         }
         return _loc2_;
      }
      
      private function triggerHandler(param1:Event) : void
      {
         this.validate();
      }
      
      private function resourceManager_changeHandler(param1:Event) : void
      {
         this.resourcesChanged();
      }
   }
}

