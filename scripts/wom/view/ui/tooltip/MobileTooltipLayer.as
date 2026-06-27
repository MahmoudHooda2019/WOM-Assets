package wom.view.ui.tooltip
{
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.controller.event.ui.MobileStarlingTooltipEvent;
   
   public class MobileTooltipLayer extends Sprite
   {
      
      private var _tooltipView:MobileBaseTooltipView;
      
      private var _timer:Timer;
      
      public function MobileTooltipLayer()
      {
         super();
         _timer = new Timer(500,1);
         _timer.addEventListener("timerComplete",onTimerComplete);
      }
      
      public function clear() : void
      {
         if(_tooltipView)
         {
            if(contains(_tooltipView))
            {
               removeChild(_tooltipView);
            }
            _tooltipView = null;
         }
         dispatchEvent(new MobileStarlingTooltipEvent("closeTooltipTriggered"));
      }
      
      public function showTooltip(param1:MobileBaseTooltipView, param2:int, param3:int) : void
      {
         clear();
         _tooltipView = param1;
         addChild(_tooltipView);
         _tooltipView.x = param2;
         _tooltipView.y = param3;
         _timer.start();
      }
      
      public function get timer() : Timer
      {
         return _timer;
      }
      
      private function onTimerComplete(param1:TimerEvent) : void
      {
         _timer.reset();
      }
      
      override public function hitTest(param1:Point, param2:Boolean = false) : DisplayObject
      {
         if(_tooltipView)
         {
            if(_timer.running)
            {
               return super.hitTest(param1,param2);
            }
            if(_tooltipView.interactable && _tooltipView.bounds.containsPoint(param1))
            {
               return super.hitTest(param1,param2);
            }
            clear();
            return null;
         }
         return null;
      }
   }
}

