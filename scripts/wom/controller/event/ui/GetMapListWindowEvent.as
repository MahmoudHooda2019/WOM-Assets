package wom.controller.event.ui
{
   import flash.events.Event;
   
   public class GetMapListWindowEvent extends Event
   {
      
      public static const SHOW_MAP:String = "showMap";
      
      public static const SHOW_MAP_LIST_WINDOW:String = "showMapListWindow";
      
      public static const MAP_READY:String = "mapReady";
      
      public function GetMapListWindowEvent(param1:String)
      {
         super(param1);
      }
      
      override public function clone() : Event
      {
         return new GetMapListWindowEvent(type);
      }
   }
}

