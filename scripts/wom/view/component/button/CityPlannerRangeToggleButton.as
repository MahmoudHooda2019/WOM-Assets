package wom.view.component.button
{
   import wom.view.component.button.colored.WomRedMediumButton;
   
   public class CityPlannerRangeToggleButton extends WomRedMediumButton
   {
      
      public function CityPlannerRangeToggleButton()
      {
         super();
         this.toggle = true;
      }
      
      override protected function drawLayout() : void
      {
         super.drawLayout();
         textField.visible = false;
         if(icon != null)
         {
            icon.x = -2;
         }
      }
   }
}

