package wom.view.component.progressbar
{
   import flash.display.Sprite;
   
   public class MaskedProgressBar extends WomProgressBar
   {
      
      protected var _mask:Sprite;
      
      public function MaskedProgressBar()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         _mask = new Sprite();
         addChild(_mask);
      }
      
      override protected function drawBars() : void
      {
         super.drawBars();
         determinateBar.mask = _mask;
      }
      
      override protected function drawLayout() : void
      {
         super.drawLayout();
         _mask.x = determinateBar.x;
         _mask.y = determinateBar.y;
         _mask.graphics.beginFill(16711680);
         _mask.graphics.drawRect(0,0,1,determinateBar.height);
      }
      
      override protected function drawDeterminateBar() : void
      {
         var _loc1_:Number = Number(getStyleValue("barPadding"));
         determinateBar.width = Math.round(width - _loc1_ * 2);
         determinateBar.x = _direction == "left" ? width - _loc1_ - determinateBar.width : _loc1_;
         _mask.graphics.clear();
         _mask.graphics.beginFill(16711680);
         var _loc2_:int = int(determinateBar.width / 100 * percentComplete) + _loc1_;
         _mask.graphics.drawRect(0,0,_loc2_,determinateBar.height);
      }
   }
}

