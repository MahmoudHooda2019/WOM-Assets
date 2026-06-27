package peak.cuckoo.game.behavior.animation.uvAtlas
{
   import flash.display.BitmapData;
   import peak.cuckoo.game.attribute.view.AnimationAssetView;
   import peak.cuckoo.game.behavior.animation.LoopAnimation;
   import peak.cuckoo.game.behavior.render.gpu.GpuImage;
   import peak.cuckoo.game.behavior.render.gpu.GpuStarlingRender;
   import peak.resource.atlas.starling.StarlingAtlasReference;
   
   public class UVAtlasLoopAnimation extends LoopAnimation
   {
      
      protected var frames:Vector.<StarlingAtlasReference>;
      
      private var lastFrameNum:int = -1;
      
      private var render:GpuStarlingRender;
      
      private var gpuImage:GpuImage;
      
      public function UVAtlasLoopAnimation(param1:int, param2:int)
      {
         super();
         this.fpsChangeRate = param1;
         this.frameWidth = param2;
      }
      
      override public function init() : void
      {
         super.init();
         render = owner.root.render as GpuStarlingRender;
      }
      
      override public function update() : void
      {
         frameCounter += sync.precise;
         frameNum = int(frameCounter / fpsChangeRate) % frameTotal;
         if(lastFrameNum != frameNum)
         {
            gpuImage.setAtlasReference(frames[lastFrameNum = frameNum]);
         }
      }
      
      override public function prepareFrames(param1:BitmapData, param2:AnimationAssetView) : void
      {
         var _loc5_:* = 0;
         var _loc4_:StarlingAtlasReference = null;
         gpuImage = param2.gpuImage;
         var _loc3_:StarlingAtlasReference = render.atlasManager.getAtlasReference(param2.assetId + "-" + 0);
         frameHeight = _loc3_.height;
         frameCounter = 0;
         if(frameHeight > 0 && frameWidth > 0)
         {
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
   }
}

