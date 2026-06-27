package peak.util
{
   public function passParameters2(param1:Function, ... rest) : Function
   {
      var method:Function = param1;
      var additionalArguments:Array = rest;
      return function(param1:Object, param2:Object):void
      {
         method.apply(null,[param1,param2].concat(additionalArguments));
      };
   }
}

