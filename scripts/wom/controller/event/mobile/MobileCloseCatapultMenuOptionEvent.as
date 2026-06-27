package wom.controller.event.mobile
{
   import flash.events.Event;
   
   public class MobileCloseCatapultMenuOptionEvent extends Event
   {
      
      public static const CLOSE_OPTION_MENU:String = "closeOptionMenu";
      
      public function MobileCloseCatapultMenuOptionEvent()
      {
         super("closeOptionMenu");
      }
   }
}

