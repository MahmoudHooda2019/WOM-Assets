package wom.view.component
{
   import peak.display.CustomCursorAwareTextField;
   
   public class WomCustomCursorAwareTextField extends CustomCursorAwareTextField
   {
      
      public function WomCustomCursorAwareTextField()
      {
         super();
         this.defaultTextFormat = WomTextFormats.WOM_DEFAULT;
      }
   }
}

