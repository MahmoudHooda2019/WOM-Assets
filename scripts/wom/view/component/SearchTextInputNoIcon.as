package wom.view.component
{
   public class SearchTextInputNoIcon extends WomTextInput
   {
      
      public function SearchTextInputNoIcon()
      {
         super();
         this.maxChars = 50;
         this.height = 32;
      }
      
      override protected function drawLayout() : void
      {
         super.drawLayout();
         this.textField.width = this.width - 20;
         this.textField.height = this.height - 4;
         this.textField.x = 10;
         this.textField.y = 7;
      }
   }
}

