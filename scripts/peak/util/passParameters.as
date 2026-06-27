package peak.util
{
   public function passParameters(param1:Function, ... rest) : Function
   {
      var method:Function = param1;
      var additionalArguments:Array = rest;
      return function(param1:Object):void
      {
         method.apply(null,[param1].concat(additionalArguments));
      };
   }
}

