package wom.service.logging
{
   import peak.logging.LoggerContext;
   
   public class WomLoggerContexts
   {
      
      public static const STATUS:LoggerContext = new LoggerContext(256,"STATUS");
      
      public static const GAME:LoggerContext = new LoggerContext(512,"GAME");
      
      public static const KONTAGENT:LoggerContext = new LoggerContext(2097152,"KONTAGENT");
      
      public static const CUCKOO:LoggerContext = new LoggerContext(4194304,"CUCKOO");
      
      public static const VALIDATION:LoggerContext = new LoggerContext(8388608,"VALIDATION");
      
      public function WomLoggerContexts()
      {
         super();
      }
   }
}

