package wom.view.component
{
   import peak.component.PTextField;
   
   public class WomTextField extends PTextField
   {
      
      public function WomTextField(param1:Boolean = false)
      {
         super(param1);
         this.defaultTextFormat = WomTextFormats.WOM_DEFAULT;
      }
   }
}

