package peak.logging
{
   public class LoggerContext
   {
      
      private var _contextId:int;
      
      private var _contextMessage:String;
      
      public function LoggerContext(param1:int, param2:String)
      {
         super();
         _contextId = param1;
         _contextMessage = param2;
      }
      
      public static function combine(param1:LoggerContext, param2:LoggerContext) : LoggerContext
      {
         return new LoggerContext(param1.contextId | param2.contextId,param1.contextMessage + " " + param2.contextMessage);
      }
      
      public function get contextId() : int
      {
         return _contextId;
      }
      
      public function get contextMessage() : String
      {
         return _contextMessage;
      }
   }
}

