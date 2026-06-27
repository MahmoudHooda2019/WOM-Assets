package peak.logging
{
   import peak.serialization.json.PJSON;
   
   public class AbstractLoggerTarget
   {
      
      public function AbstractLoggerTarget()
      {
         super();
      }
      
      protected static function buildOutput(param1:String, param2:*) : String
      {
         return (param1 && param1.length > 0 ? param1 : "") + (param2 !== undefined ? " " + (param2 is String ? param2 : PJSON.encode(param2)) : "");
      }
   }
}

