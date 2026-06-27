package peak.cuckoo.game.behavior.animation.uv
{
   import flash.display.BitmapData;
   import peak.cuckoo.game.attribute.view.AnimationAssetView;
   import peak.cuckoo.game.behavior.animation.ActionAnimation;
   import peak.cuckoo.game.behavior.render.gpu.GpuRender;
   import peak.resource.atlas.BlockReference;
   
   public class UVActionAnimation extends ActionAnimation
   {
      
      protected var frames:Vector.<BlockReference>;
      
      private var lastFrameNum:int = -1;
      
      private var render:GpuRender;
      
      public function UVActionAnimation(param1:int, param2:int)
      {
         super();
         this.fpsChangeRate = param1;
         this.frameWidth = param2;
      }
      
      override public function init() : void
      {
         super.init();
         render = owner.root.render as GpuRender;
         startEnabled = false;
      }
      
      override public function setFrame(param1:uint) : void
      {
         frameCounter = param1 * fpsChangeRate;
         frameNum = param1;
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
         var _loc3_:* = 0;
         view = param2;
         frameHeight = param1.height;
         this.frameTotal = param1.width / frameWidth;
         frameCounter = 0;
         if(frameTotal > 0 && frameHeight > 0 && frameWidth > 0)
         {
            frames = new Vector.<BlockReference>();
            _loc3_ = 0;
            while(_loc3_ < frameTotal)
            {
               _loc3_++;
            }
            frameCounter = frameNum = Math.random() * 100 % frameTotal;
            if(requested)
            {
               enable();
            }
            prepared = true;
            view.gpuImage.assetReady();
            ownerSprite.bounds.init();
            ownerSprite.position.refreshPosition();
         }
      }
      
      override public function selectEnableDisableBitmap(param1:Boolean) : void
      {
         if(view)
         {
            if(param1)
            {
               disable();
            }
            else
            {
               enable();
            }
         }
      }
   }
}

