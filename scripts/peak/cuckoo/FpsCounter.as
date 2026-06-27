package peak.cuckoo
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.utils.getTimer;
   
   public class FpsCounter extends Sprite
   {
      
      private var last:uint = getTimer();
      
      private var ticks:uint = 0;
      
      private var tf:TextField;
      
      public function FpsCounter(param1:int = 0, param2:int = 0, param3:uint = 0, param4:Boolean = false, param5:uint = 0)
      {
         super();
         x = param1;
         y = param2;
         tf = new TextField();
         tf.textColor = param3;
         tf.text = "----- fps";
         tf.selectable = false;
         tf.background = param4;
         tf.backgroundColor = param5;
         tf.autoSize = "left";
         addChild(tf);
         width = tf.textWidth;
         height = tf.textHeight;
         addEventListener("enterFrame",tick);
      }
      
      public function tick(param1:Event) : void
      {
         var _loc3_:Number = NaN;
         ticks = ticks + 1;
         var _loc2_:uint = uint(getTimer());
         var _loc4_:uint = _loc2_ - last;
         if(_loc4_ >= 1000)
         {
            _loc3_ = ticks / _loc4_ * 1000;
            tf.text = _loc3_.toFixed(1) + " fps";
            ticks = 0;
            last = _loc2_;
         }
      }
   }
}

