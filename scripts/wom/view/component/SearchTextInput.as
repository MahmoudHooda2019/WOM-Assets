package wom.view.component
{
   public class SearchTextInput extends WomTextInput
   {
      
      public function SearchTextInput()
      {
         super();
         this.maxChars = 50;
         this.height = 32;
      }
      
      override protected function drawLayout() : void
      {
         super.drawLayout();
         this.textField.width = this.width - 42;
         this.textField.height = this.height - 4;
         this.textField.x = 26;
         this.textField.y = 7;
      }
   }
}

