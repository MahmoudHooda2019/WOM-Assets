package peak.logging
{
   public class LoggerContexts
   {
      
      public static const INFRASTRUCTURE:LoggerContext = new LoggerContext(1,"INFRA");
      
      public static const UNCAUGHT_ERROR:LoggerContext = new LoggerContext(2,"UCERR");
      
      public static const UNEXPECTED:LoggerContext = new LoggerContext(4,"UNEXP");
      
      public static const NETWORK:LoggerContext = new LoggerContext(8,"NET");
      
      public static const MESSAGING:LoggerContext = new LoggerContext(16,"MESG");
      
      public static const CUCKOOERROR:LoggerContext = new LoggerContext(32,"CUCER");
      
      public static const CUCKOOMOUSE:LoggerContext = new LoggerContext(64,"CUCMOU");
      
      public static const RENDER:LoggerContext = new LoggerContext(128,"RENDER");
      
      public function LoggerContexts()
      {
         super();
      }
   }
}

