package wom.controller.event.model
{
   import flash.events.Event;
   
   public class NotEnoughGoldEvent extends Event
   {
      
      public static const BLACKSMITH_FINISH_NOW:String = "blacksmithFinishNow";
      
      public function NotEnoughGoldEvent(param1:String)
      {
         super(param1);
      }
      
      override public function clone() : Event
      {
         return new NotEnoughGoldEvent(type);
      }
   }
}

