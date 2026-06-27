package peak.display
{
   import peak.component.PTextField;
   
   public class CustomCursorAwareTextField extends PTextField
   {
      
      private var cursorManager:InteractiveCursorManager;
      
      public function CustomCursorAwareTextField()
      {
         super();
         this.cursorManager = new InteractiveCursorManager(this);
      }
   }
}

