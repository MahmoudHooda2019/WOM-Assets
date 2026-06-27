package peak.display
{
   import flash.display.Sprite;
   
   public class CustomCursorAwareSprite extends Sprite
   {
      
      private var cursorManager:ButtonCursorManager;
      
      public function CustomCursorAwareSprite()
      {
         super();
         this.cursorManager = new ButtonCursorManager(this);
      }
      
      override public function set buttonMode(param1:Boolean) : void
      {
         super.buttonMode = param1;
         cursorManager.enabled = param1;
      }
   }
}

