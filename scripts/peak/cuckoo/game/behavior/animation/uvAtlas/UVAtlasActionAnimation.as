package peak.cuckoo.game.behavior.animation.uvAtlas
{
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import peak.cuckoo.game.attribute.view.AnimationAssetView;
   import peak.cuckoo.game.behavior.animation.ActionAnimation;
   import peak.cuckoo.game.behavior.render.gpu.GpuImage;
   import peak.cuckoo.game.behavior.render.gpu.GpuStarlingRender;
   import peak.cuckoo.game.behavior.render.gpu.GpuTransformableImage;
   import peak.resource.atlas.starling.StarlingAtlasReference;
   
   public class UVAtlasActionAnimation extends ActionAnimation
   {
      
      protected var frames:Vector.<StarlingAtlasReference>;
      
      private var lastFrameNum:int = -1;
      
      private var render:GpuStarlingRender;
      
      private var gpuImage:GpuImage;
      
      private var gpuTransformableImage:GpuTransformableImage;
      
      public function UVAtlasActionAnimation(param1:int, param2:int)
      {
         super();
         this.fpsChangeRate = param1;
         this.frameWidth = param2;
      }
      
      override public function init() : void
      {
         super.init();
         render = owner.root.render as GpuStarlingRender;
         startEnabled = false;
      }
      
      override public function setFrame(param1:uint) : void
      {
         frameCounter = param1 * fpsChangeRate;
         frameNum = param1;
         frames && gpuImage.setAtlasReference(frames[frameNum]);
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
         if(prepared && lastFrameNum != frameNum)
         {
            gpuImage.setAtlasReference(frames[frameNum]);
         }
      }
      
      override public function prepareFrames(param1:BitmapData, param2:AnimationAssetView) : void
      {
         var _loc5_:* = 0;
         var _loc4_:StarlingAtlasReference = null;
         gpuImage = param2.gpuImage;
         if(param2.transformable)
         {
            gpuTransformableImage = gpuImage as GpuTransformableImage;
         }
         var _loc3_:StarlingAtlasReference = render.atlasManager.getAtlasReference(param2.assetId + "-" + 0);
         if(_loc3_)
         {
            frameHeight = _loc3_.height;
            frameCounter = 0;
            frames = new Vector.<StarlingAtlasReference>();
            _loc5_ = 0;
            while(true)
            {
               _loc4_ = render.atlasManager.getAtlasReference(param2.assetId + "-" + _loc5_);
               if(!_loc4_)
               {
                  break;
               }
               frames.push(_loc4_);
               _loc5_++;
            }
            this.frameTotal = _loc5_;
            frameCounter = frameNum = Math.random() * 100 % frameTotal;
            if(requested)
            {
               enable();
            }
            prepared = true;
            ownerSprite.bounds.init();
            if(!ownerSprite.position.initialized)
            {
               ownerSprite.position.init();
            }
            else
            {
               ownerSprite.position.refreshPosition();
            }
            gpuImage.setAtlasReference(frames[frameNum]);
            gpuImage.assetReady();
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
      
      override public function setRotation(param1:Number) : void
      {
         if(gpuTransformableImage)
         {
            gpuTransformableImage.angle(param1);
         }
      }
      
      override public function setMatrix(param1:Matrix) : void
      {
         if(gpuTransformableImage)
         {
            gpuTransformableImage.applyMatrix(param1);
         }
      }
   }
}

