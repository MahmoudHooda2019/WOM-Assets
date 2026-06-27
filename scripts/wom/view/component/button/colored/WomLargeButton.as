package wom.view.component.button.colored
{
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.WomButton;
   
   public class WomLargeButton extends WomButton
   {
      
      public function WomLargeButton()
      {
         super();
         _buttonTextFormat = WomTextFormats.CAPTION_32;
         this.height = 60;
         this.textField.width = 0;
         this.textField.height = 0;
      }
   }
}

