package peak.network
{
   import flash.events.Event;
   
   public class ClientEvent extends Event
   {
      
      public static const CONNECTION_ESTABLISHED:String = "connectionEstablished";
      
      public static const CONNECTION_LOST:String = "connectionLost";
      
      public static const CONNECTION_LOST_PROCESSED:String = "connectionLostProcessed";
      
      public static const CONNECT_TO_SERVER:String = "connectToServer";
      
      public static const REFRESH_PAGE:String = "refreshPage";
      
      private var _data:*;
      
      public function ClientEvent(param1:String, param2:* = null)
      {
         super(param1);
         _data = param2;
      }
      
      public function get data() : *
      {
         return _data;
      }
      
      override public function clone() : Event
      {
         return new ClientEvent(type,data);
      }
   }
}

