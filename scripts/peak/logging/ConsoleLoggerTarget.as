package peak.logging
{
   import flash.external.ExternalInterface;
   
   public class ConsoleLoggerTarget implements LoggerTarget
   {
      
      private var enabled:Boolean;
      
      public function ConsoleLoggerTarget()
      {
         super();
         enabled = ExternalInterface.available && ExternalInterface.call("function(){return typeof window.console == \'object\'}");
      }
      
      public function write(param1:String, param2:* = undefined) : void
      {
         if(enabled)
         {
            if(param1 && param1.length > 0)
            {
               if(param2 !== undefined)
               {
                  ExternalInterface.call("console.log",param1,param2);
               }
               else
               {
                  ExternalInterface.call("console.log",param1);
               }
            }
            else if(param2 !== undefined)
            {
               ExternalInterface.call("console.log",param2);
            }
         }
      }
   }
}

