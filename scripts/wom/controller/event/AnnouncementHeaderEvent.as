package wom.controller.event
{
   import flash.events.Event;
   
   public class AnnouncementHeaderEvent extends Event
   {
      
      public static const UPDATED:String = "announcementHeaderUpdated";
      
      private var _header:String;
      
      public function AnnouncementHeaderEvent(param1:String, param2:String = "")
      {
         super(param1);
         _header = param2;
      }
      
      override public function clone() : Event
      {
         return new AnnouncementHeaderEvent(type,_header);
      }
      
      public function get header() : String
      {
         return _header;
      }
   }
}

