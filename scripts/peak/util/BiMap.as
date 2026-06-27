package peak.util
{
   import flash.utils.Dictionary;
   
   public dynamic class BiMap extends Dictionary
   {
      
      protected var keyByValue:Dictionary;
      
      public function BiMap()
      {
         super();
         keyByValue = new Dictionary();
      }
      
      public function hasValue(param1:*) : Boolean
      {
         return param1 in keyByValue;
      }
      
      public function hasKey(param1:*) : Boolean
      {
         return param1 in this;
      }
      
      public function put(param1:*, param2:*) : void
      {
         if(hasKey(param1) || hasValue(param2))
         {
            throw new Error("Trying to put invalid key/value pair into BiMap");
         }
         this[param1] = param2;
         keyByValue[param2] = param1;
      }
      
      public function removeByKey(param1:*) : *
      {
         var _loc2_:* = getValue(param1);
         delete keyByValue[_loc2_];
         delete this[param1];
         return _loc2_;
      }
      
      public function removeByValue(param1:*) : *
      {
         var _loc2_:* = getKey(param1);
         delete this[_loc2_];
         delete keyByValue[param1];
         return _loc2_;
      }
      
      public function getValue(param1:*) : *
      {
         return this[param1];
      }
      
      public function getKey(param1:*) : *
      {
         return keyByValue[param1];
      }
   }
}

