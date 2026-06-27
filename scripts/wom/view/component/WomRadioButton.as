package wom.view.component
{
   import peak.component.PRadioButton;
   
   public class WomRadioButton extends PRadioButton
   {
      
      public function WomRadioButton()
      {
         super();
         this.height = 20;
         this.textField.width = 0;
         this.textField.height = 0;
         this.background.height = 20;
      }
      
      override protected function drawLayout() : void
      {
         super.drawLayout();
      }
   }
}

