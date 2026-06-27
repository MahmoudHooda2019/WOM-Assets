package wom.view.ui.mainframe.combat
{
   import flash.geom.Rectangle;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   
   public class MobileVictoryMeterProgressView extends Sprite
   {
      
      private var _progressView:DisplayObject;
      
      private var _rightAnchoredMask:Boolean;
      
      public function MobileVictoryMeterProgressView(param1:DisplayObject, param2:Boolean = true)
      {
         super();
         _progressView = param1;
         _rightAnchoredMask = param2;
         initLayout();
      }
      
      public function initLayout() : void
      {
         addChild(_progressView);
      }
      
      public function updateProgress(param1:Number) : void
      {
         clipRect = new Rectangle(_rightAnchoredMask ? 0 : (100 - param1) * _progressView.width / 100,0,Math.max(1,_progressView.width * param1 / 100),_progressView.height);
      }
   }
}

