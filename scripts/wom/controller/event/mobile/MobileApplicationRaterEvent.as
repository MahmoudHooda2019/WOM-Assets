package wom.controller.event.mobile
{
   import flash.events.Event;
   
   public class MobileApplicationRaterEvent extends Event
   {
      
      public static const SETUP:String = "setupMobileApplicationRater";
      
      public static const SIGNIFICANT_EVENT:String = "significantEvent";
      
      private var data:Object;
      
      public function MobileApplicationRaterEvent(param1:String, param2:Object = null)
      {
         super(param1);
         this.data = param2;
      }
      
      override public function clone() : Event
      {
         return new MobileApplicationRaterEvent(type,data);
      }
   }
}

