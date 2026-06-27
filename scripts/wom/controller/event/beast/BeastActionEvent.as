package wom.controller.event.beast
{
   import flash.events.Event;
   
   public class BeastActionEvent extends Event
   {
      
      public static const BEAST_ACTION:String = "beastAction";
      
      public static const TRAIN:String = "train";
      
      public static const EVOLVE:String = "evolve";
      
      public static const HEAL:String = "heal";
      
      private var _actionType:String;
      
      public function BeastActionEvent(param1:String, param2:String)
      {
         super(param1);
         _actionType = param2;
      }
      
      override public function clone() : Event
      {
         return new BeastActionEvent(type,_actionType);
      }
      
      public function get actionType() : String
      {
         return _actionType;
      }
   }
}

