package peak.cuckoo.game.behavior.cull
{
   import peak.cuckoo.core.Behavior;
   import peak.cuckoo.game.attribute.Viewport;
   import peak.cuckoo.game.attribute.container.GameSpriteContainer;
   import peak.cuckoo.game.attribute.container.RenderChildrenContainer;
   
   public class BaseCull extends Behavior
   {
      
      public static const TYPE_ID:String = "BaseCull";
      
      protected var allContainer:GameSpriteContainer;
      
      protected var viewContainer:RenderChildrenContainer;
      
      protected var viewport:Viewport;
      
      public function BaseCull()
      {
         super();
         priority = 1;
      }
      
      override public function get typeId() : String
      {
         return "BaseCull";
      }
      
      override public function init() : void
      {
         super.init();
         viewContainer = owner.componentManager["RenderChildrenContainer"] as RenderChildrenContainer;
         allContainer = owner.componentManager["GameSpriteContainer"] as GameSpriteContainer;
         viewport = owner.root.componentManager["Viewport"] as Viewport;
      }
      
      override public function destroy() : void
      {
         disable();
      }
   }
}

