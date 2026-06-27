package peak.network
{
   import flash.events.Event;
   
   public class NetworkEvent extends Event
   {
      
      public static const CONNECTED:String = "connected";
      
      public static const DATA_RECEIVED:String = "dataReceived";
      
      private var _data:Object;
      
      public function NetworkEvent(param1:String, param2:* = null)
      {
         super(param1,true);
         this.data = param2;
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      public function set data(param1:Object) : void
      {
         this._data = param1;
      }
      
      override public function clone() : Event
      {
         return new NetworkEvent(this.type,this.data);
      }
   }
}

