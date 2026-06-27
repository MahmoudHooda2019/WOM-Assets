package wom.view.component
{
   import peak.component.PCheckBox;
   
   public class WomCheckBox extends PCheckBox
   {
      
      public function WomCheckBox()
      {
         super(true);
      }
      
      override protected function drawLayout() : void
      {
         super.drawLayout();
         this.textField.y += 1;
      }
   }
}

