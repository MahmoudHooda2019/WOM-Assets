package wom.model.game.defense
{
   import peak.i18n.PText;
   
   public class NPCAttackChoiceType
   {
      
      public static const INVALID_CHOICE:NPCAttackChoiceType = new NPCAttackChoiceType(0,"invalidchoice");
      
      public static const BRING_MORE:NPCAttackChoiceType = new NPCAttackChoiceType(1,"bringmore");
      
      public static const THTAS_OK:NPCAttackChoiceType = new NPCAttackChoiceType(2,"thatsok");
      
      public static const BRING_LESS:NPCAttackChoiceType = new NPCAttackChoiceType(3,"bringless");
      
      private var _id:int;
      
      private var _name:String;
      
      public function NPCAttackChoiceType(param1:int, param2:String)
      {
         super();
         _id = param1;
         _name = param2;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get text() : String
      {
         var _loc1_:String = "ui.npcattack." + _name;
         return peak.i18n.PText.INSTANCE.getText0(_loc1_);
      }
   }
}

