package wom.controller.event
{
   import flash.events.Event;
   
   public class GameModeChangedEvent extends Event
   {
      
      public static const CHANGE:String = "gameModeChange";
      
      public function GameModeChangedEvent(param1:String)
      {
         super(param1);
      }
      
      override public function clone() : Event
      {
         return new GameModeChangedEvent(type);
      }
   }
}

