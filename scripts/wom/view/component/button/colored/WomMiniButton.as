package wom.view.component.button.colored
{
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.WomButton;
   
   public class WomMiniButton extends WomButton
   {
      
      public function WomMiniButton()
      {
         super();
         _buttonTextFormat = WomTextFormats.CAPTION_14;
         this.height = 21;
         this.textField.width = 0;
         this.textField.height = 0;
      }
      
      override protected function drawLayout() : void
      {
         super.drawLayout();
         this.textField.y += 1;
         this.rightTextField.y += 1;
      }
   }
}

