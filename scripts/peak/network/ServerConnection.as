package peak.network
{
   public interface ServerConnection
   {
      
      function connect(param1:String, param2:int) : void;
      
      function write(param1:String) : void;
      
      function disconnect() : void;
      
      function get connected() : Boolean;
      
      function reset() : void;
      
      function keepAlive() : void;
   }
}

