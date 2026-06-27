package peak.cuckoo.game.behavior.animation
{
   public class LoopAnimation extends Animation
   {
      
      public function LoopAnimation(param1:int = 0, param2:int = 0)
      {
         super();
      }
      
      override public function startAnimation() : void
      {
         frameNum = 0;
         enable();
      }
   }
}

