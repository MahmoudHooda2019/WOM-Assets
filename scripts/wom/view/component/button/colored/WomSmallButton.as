package wom.view.component.button.colored
{
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.WomButton;
   
   public class WomSmallButton extends WomButton
   {
      
      public function WomSmallButton()
      {
         super();
         _buttonTextFormat = WomTextFormats.CAPTION_18;
         this.height = 31;
         this.textField.width = 0;
         this.textField.height = 0;
      }
   }
}

