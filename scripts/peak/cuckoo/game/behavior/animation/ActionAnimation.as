package peak.cuckoo.game.behavior.animation
{
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import peak.cuckoo.game.attribute.view.AnimationAssetView;
   import peak.signal.Signal0;
   
   public class ActionAnimation extends Animation
   {
      
      protected var startFrame:uint;
      
      protected var stopFrame:uint;
      
      protected var forward:Boolean = true;
      
      public var loop:Boolean = false;
      
      public var animationFinished:Signal0;
      
      public function ActionAnimation(param1:int = 0, param2:int = 0)
      {
         super();
         animationFinished = new Signal0();
         requested = false;
         this.fpsChangeRate = param1;
         this.frameWidth = param2;
      }
      
      public function setFrame(param1:uint) : void
      {
         frameCounter = param1 * fpsChangeRate;
         frameNum = param1;
      }
      
      public function setStartFrame(param1:uint) : void
      {
         startFrame = param1;
      }
      
      public function setForward(param1:Boolean) : void
      {
         forward = param1;
      }
      
      public function setStopFrame(param1:uint) : void
      {
         stopFrame = param1;
      }
      
      override public function init() : void
      {
         super.init();
      }
      
      override public function startAnimation() : void
      {
         if(frameTotal == 0)
         {
            requested = true;
            return;
         }
         super.startAnimation();
      }
      
      override public function update() : void
      {
         if(frameNum == stopFrame)
         {
            if(!loop)
            {
               stopAnimation();
               animationFinished.dispatch();
               return;
            }
            frameCounter = startFrame * fpsChangeRate;
            frameNum = startFrame;
         }
         if(forward)
         {
            frameCounter += sync.precise;
            frameNum = int(frameCounter / fpsChangeRate) % frameTotal;
            frameNum < 0 && ((frameNum = frameNum + frameTotal) || (frameCounter = frameNum * fpsChangeRate));
         }
         else
         {
            frameCounter -= sync.precise;
            frameNum = int(frameCounter / fpsChangeRate) % frameTotal;
            frameNum < 0 && ((frameNum = frameNum + frameTotal) || (frameCounter = frameNum * fpsChangeRate));
         }
      }
      
      override public function prepareFrames(param1:BitmapData, param2:AnimationAssetView) : void
      {
         view = param2;
         frameHeight = param1.height;
         this.frameTotal = 32;
         frameCounter = 0;
         if(frameTotal > 0 && frameHeight > 0 && frameWidth > 0)
         {
            if(requested)
            {
               enable();
            }
            prepared = true;
         }
         view.bitmapData = new BitmapData(1,1);
      }
      
      public function setRotation(param1:Number) : void
      {
      }
      
      public function setMatrix(param1:Matrix) : void
      {
      }
   }
}

