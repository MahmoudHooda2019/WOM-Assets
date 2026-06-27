package peak.cuckoo.game.behavior.animation.uvAtlas
{
   import flash.display.BitmapData;
   import peak.cuckoo.game.attribute.view.AnimationAssetView;
   import peak.cuckoo.game.behavior.animation.StateDirectionAnimation;
   import peak.cuckoo.game.behavior.render.gpu.GpuImage;
   import peak.cuckoo.game.behavior.render.gpu.GpuStarlingRender;
   import peak.resource.atlas.starling.StarlingAtlasReference;
   
   public class UVAtlasStateDirectionAnimation extends StateDirectionAnimation
   {
      
      private var states:Vector.<Vector.<AnimationPart>>;
      
      private var frames:Vector.<StarlingAtlasReference>;
      
      private var lastFrameNum:int = -1;
      
      private var render:GpuStarlingRender;
      
      private var gpuImage:GpuImage;
      
      public function UVAtlasStateDirectionAnimation(param1:Array, param2:int, param3:int)
      {
         super(param1,param2,param3);
         this.stateFramesTotal = param2;
         this.directionTotal = param3;
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
         var _loc6_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         gpuImage = param2.gpuImage;
         var _loc3_:StarlingAtlasReference = render.atlasManager.getAtlasReference(param2.assetId + "-" + 0);
         this.stateTotal = stateMap.length;
         this.frameWidth = _loc3_.width;
         this.frameHeight = _loc3_.height;
         frameCounter = 0;
         if(stateTotal > 0 && directionTotal > 0 && frameHeight > 0 && frameWidth > 0)
         {
            states = new Vector.<Vector.<AnimationPart>>();
            _loc6_ = 0;
            while(_loc6_ < directionTotal)
            {
               states[_loc6_] = new Vector.<AnimationPart>();
               _loc4_ = 0;
               _loc4_ = 0;
               while(_loc4_ < stateTotal)
               {
                  states[_loc6_][_loc4_] = new AnimationPart();
                  states[_loc6_][_loc4_].frames = new Vector.<StarlingAtlasReference>();
                  frameTotal = stateMap[_loc4_].length;
                  _loc5_ = 0;
                  _loc5_ = 0;
                  while(_loc5_ < frameTotal)
                  {
                     states[_loc6_][_loc4_].frames[_loc5_] = render.atlasManager.getAtlasReference(param2.assetId + "-" + ((stateMap[_loc4_].start + _loc5_) * directionTotal + _loc6_));
                     _loc5_++;
                  }
                  states[_loc6_][_loc4_].totalFrame = frameTotal;
                  states[_loc6_][_loc4_].fpsChangeRate = stateMap[_loc4_].fpsChangeRate;
                  _loc4_++;
               }
               _loc6_++;
            }
         }
         frameNum = 0;
         frames = states[_direction][_state].frames;
         frameTotal = states[_direction][_state].totalFrame;
         fpsChangeRate = states[_direction][_state].fpsChangeRate;
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
         enable();
      }
      
      override public function set direction(param1:uint) : void
      {
         try
         {
            _direction = param1;
            frames = states[_direction][_state].frames;
            frameTotal = states[_direction][_state].totalFrame;
            if(frameNum >= frameTotal)
            {
               frameNum = 0;
            }
            gpuImage.setAtlasReference(frames[lastFrameNum = frameNum]);
         }
         catch(e:Error)
         {
         }
      }
      
      override public function set state(param1:uint) : void
      {
         try
         {
            _state = param1;
            frames = states[_direction][_state].frames;
            frameTotal = states[_direction][_state].totalFrame;
            fpsChangeRate = states[_direction][_state].fpsChangeRate * _modifier;
            if(frameNum >= frameTotal)
            {
               frameNum = 0;
            }
            frameCounter = Math.random() * frameTotal * fpsChangeRate;
            if(lastFrameNum != frameNum)
            {
               gpuImage.setAtlasReference(frames[lastFrameNum = frameNum]);
            }
         }
         catch(e:Error)
         {
         }
      }
      
      override public function get modifier() : Number
      {
         return super.modifier;
      }
      
      override public function set modifier(param1:Number) : void
      {
         super.modifier = param1;
         try
         {
            fpsChangeRate = states[_direction][_state].fpsChangeRate * _modifier;
         }
         catch(e:Error)
         {
         }
      }
   }
}

import peak.resource.atlas.starling.StarlingAtlasReference;

class AnimationPart
{
   
   public var frames:Vector.<StarlingAtlasReference>;
   
   public var fpsChangeRate:uint;
   
   public var totalFrame:uint;
   
   public function AnimationPart()
   {
      super();
   }
}
