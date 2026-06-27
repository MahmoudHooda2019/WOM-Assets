package peak.cuckoo.game.behavior.sort
{
   import peak.cuckoo.core.Behavior;
   
   public class BaseSort extends Behavior
   {
      
      public static const TYPE_ID:String = "BaseSort";
      
      public function BaseSort()
      {
         super();
         priority = 1;
      }
      
      override public function get typeId() : String
      {
         return "BaseSort";
      }
      
      override public function init() : void
      {
         super.init();
      }
      
      override public function update() : void
      {
         disable();
      }
      
      override public function destroy() : void
      {
         disable();
      }
   }
}

