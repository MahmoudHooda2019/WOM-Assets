package wom.controller.event.ui
{
   import flash.events.Event;
   import wom.model.game.report.AttackLog;
   
   public class AttackLogEvent extends Event
   {
      
      public static const GET_BATTLE_REPORT:String = "getBattleReport";
      
      private var _attackLog:AttackLog;
      
      public function AttackLogEvent(param1:String, param2:AttackLog)
      {
         super(param1);
         _attackLog = param2;
      }
      
      override public function clone() : Event
      {
         return new AttackLogEvent(type,_attackLog);
      }
      
      public function get attackLog() : AttackLog
      {
         return _attackLog;
      }
   }
}

