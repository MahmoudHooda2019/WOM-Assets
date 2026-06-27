package peak.logging
{
   import peak.serialization.json.PJSON;
   
   public class TraceLoggerTarget extends AbstractLoggerTarget implements LoggerTarget
   {
      
      public function TraceLoggerTarget()
      {
         super();
      }
      
      public function write(param1:String, param2:* = undefined) : void
      {
         §§push(trace);
         §§push(global);
         var _temp_1:* = param1;
         var _loc5_:* = param2;
         var _loc3_:String = _temp_1;
         var _loc4_:String = (_loc3_ && _loc3_.length > 0 ? _loc3_ : "") + (_loc5_ !== undefined ? " " + (_loc5_ is String ? _loc5_ : peak.serialization.json.PJSON.encode(_loc5_)) : "");
         §§pop()(_loc4_);
      }
   }
}

