package wom.controller.event
{
   import flash.events.Event;
   
   public class GameTickEvent extends Event
   {
      
      public static const START:String = "start";
      
      public static const STOP:String = "stop";
      
      public static const TICK:String = "tick";
      
      private var _timeDifferenceFromServer:Number;
      
      public function GameTickEvent(param1:String, param2:Number = 0)
      {
         super(param1);
         _timeDifferenceFromServer = param2;
      }
      
      override public function clone() : Event
      {
         return new GameTickEvent(type,_timeDifferenceFromServer);
      }
      
      public function get timeDifferenceFromServer() : Number
      {
         return _timeDifferenceFromServer;
      }
   }
}

