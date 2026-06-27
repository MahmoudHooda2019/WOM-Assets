package wom.view.component.button
{
   import wom.view.component.button.colored.WomBlueSmallButton;
   import wom.view.component.progressbar.ReinforceProgressBar;
   import wom.view.component.progressbar.WomProgressBar;
   
   public class ReinforceButton extends WomBlueSmallButton
   {
      
      private var reinforceProgress:WomProgressBar;
      
      public function ReinforceButton()
      {
         super();
         width = 84;
         reinforceProgress = new ReinforceProgressBar();
         reinforceProgress.width = 60;
         reinforceProgress.x = 12;
         reinforceProgress.y = 3;
         addChild(reinforceProgress);
      }
      
      public function set maximum(param1:int) : void
      {
         reinforceProgress.maximum = param1;
      }
      
      public function set value(param1:int) : void
      {
         reinforceProgress.value = param1;
      }
      
      override protected function drawLayout() : void
      {
         super.drawLayout();
         textField.y = 9;
      }
   }
}

