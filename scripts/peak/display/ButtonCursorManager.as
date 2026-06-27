package peak.display
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.ui.Mouse;
   
   public class ButtonCursorManager extends InteractiveCursorManager
   {
      
      private var spriteTarget:Sprite;
      
      public function ButtonCursorManager(param1:Sprite, param2:String = "arrow")
      {
         super(param1,param2);
         spriteTarget = param1;
      }
      
      override protected function onRollOver(param1:MouseEvent) : void
      {
         if(spriteTarget.useHandCursor)
         {
            this.savedCursor = flash.ui.Mouse.cursor;
            flash.ui.Mouse.cursor = "button";
         }
      }
      
      override protected function onRollOut(param1:MouseEvent) : void
      {
         if(spriteTarget.useHandCursor)
         {
            if(this.savedCursor && flash.ui.Mouse.cursor == "button")
            {
               flash.ui.Mouse.cursor = this.savedCursor;
            }
         }
      }
   }
}

