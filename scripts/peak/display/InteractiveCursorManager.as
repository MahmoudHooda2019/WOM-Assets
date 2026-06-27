package peak.display
{
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   import flash.ui.Mouse;
   
   public class InteractiveCursorManager extends CustomCursorManager
   {
      
      protected var target:InteractiveObject;
      
      public function InteractiveCursorManager(param1:InteractiveObject, param2:String = "arrow")
      {
         super(param2);
         this.target = param1;
         this.enabled = true;
      }
      
      public function set enabled(param1:Boolean) : void
      {
         if(param1)
         {
            target.addEventListener("rollOver",onRollOver);
            target.addEventListener("rollOut",onRollOut);
         }
         else
         {
            target.removeEventListener("rollOver",onRollOver);
            target.removeEventListener("rollOut",onRollOut);
         }
      }
      
      protected function onRollOver(param1:MouseEvent) : void
      {
         this.savedCursor = flash.ui.Mouse.cursor;
         flash.ui.Mouse.cursor = "button";
      }
      
      protected function onRollOut(param1:MouseEvent) : void
      {
         if(this.savedCursor && flash.ui.Mouse.cursor == "button")
         {
            flash.ui.Mouse.cursor = this.savedCursor;
         }
      }
   }
}

