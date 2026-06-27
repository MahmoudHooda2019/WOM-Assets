package wom.model.game.defense
{
   public class NPCAttackStatus
   {
      
      public static const WAIT_MILIS_AFTER_ENTRY_TO_GAME:int = 8000;
      
      public static const WAIT:NPCAttackStatus = new NPCAttackStatus(0,"Wait");
      
      public static const POSTPONED_FROM_UNHEALTHY_BUILDING:NPCAttackStatus = new NPCAttackStatus(1,"PostPoneFromUnhealthyBuilding");
      
      public static const SKIPPING:NPCAttackStatus = new NPCAttackStatus(2,"Skipping");
      
      public static const INIT_ASK:NPCAttackStatus = new NPCAttackStatus(10,"InitAsk");
      
      public static const ASK:NPCAttackStatus = new NPCAttackStatus(11,"Ask");
      
      public static const INIT_DELAY:NPCAttackStatus = new NPCAttackStatus(20,"InitDelay");
      
      public static const DELAY:NPCAttackStatus = new NPCAttackStatus(21,"Delay");
      
      public static const INIT_ATTACK:NPCAttackStatus = new NPCAttackStatus(30,"InitAttack");
      
      public static const ATTACK:NPCAttackStatus = new NPCAttackStatus(31,"Attack");
      
      private var _id:int;
      
      private var _name:String;
      
      public function NPCAttackStatus(param1:int, param2:String)
      {
         super();
         _id = param1;
         _name = param2;
      }
   }
}

