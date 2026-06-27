package wom.view.component.button.colored
{
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.WomButton;
   
   public class WomMediumButton extends WomButton
   {
      
      public function WomMediumButton()
      {
         super();
         _buttonTextFormat = WomTextFormats.CAPTION_24;
         this.height = 40;
         this.textField.width = 0;
         this.textField.height = 0;
      }
   }
}

