package wom.view.component
{
   import peak.component.PTextInput;
   
   public class WomTextInput extends PTextInput
   {
      
      public function WomTextInput()
      {
         super();
         this.maxChars = 512;
         this.height = 25;
      }
      
      override protected function drawLayout() : void
      {
         super.drawLayout();
         this.textField.y += 3;
         this.textField.x += 3;
         this.textField.width -= 3;
      }
   }
}

